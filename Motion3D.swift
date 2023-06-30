//
//  Motion3D.swift
//  motion-Interaction
//
//  Created by Yohey Kuwa on 2023/05/19.
//

import SwiftUI
import RealityKit

struct Motion3D: View {
    @ObservedObject var motion: MotionSensor
    
    var body: some View {
        VStack{
            ARViewContainer(motion: motion)
                .onAppear(){
                    motion.start()
                }
                .ignoresSafeArea()
        }
    }  
}

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var motion: MotionSensor
    
    @State var anchor = AnchorEntity(world: .zero)
    @State var cube = ModelEntity(mesh: .generateBox(size: 0.6))
    ///@State var usdzModel: Entity?
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .nonAR, automaticallyConfigureSession: false)
        
        //create anchor
        ///let anchor = AnchorEntity(world: .zero)
        
        //setting background color
        arView.environment.background = .color(.green)
        
        ///let skyboxName = "brown_photostudio_02_1k" // The .exr or .hdr file
        ///let skyboxResource = try! EnvironmentResource.load(named: skyboxName)
        ///arView.environment.lighting.resource = skyboxResource
        ///arView.environment.lighting.intensityExponent = 0
        
        if let usdzModel = try? Entity.loadModel(named: "iphone_lock_bg_virgil")
        {
            ///usdzModel.orientation = simd_quatf(angle: Float.pi/2, axis: SIMD3(x: 1, y: 0, z: 0))
            var scaleValue = 0.5
            usdzModel.scale = [0.5, 0.5, 0.5]
            anchor.addChild(usdzModel)
            ///usdzModel.generateCollisionShapes(recursive: true)
            ///arView.installGestures(.all, for: usdzModel)
        }
        
        var material = PhysicallyBasedMaterial()
        if let normalResource = try? TextureResource.load(named:
        "normalmap-test1") {
            let normalMap = MaterialParameters.Texture(normalResource)
            material.normal = PhysicallyBasedMaterial.Normal(texture:normalMap)
        }
        
        cube.model?.materials = [material]
        
        // Add the box anchor to the scene
        ///anchor.addChild(cube)
        arView.scene.addAnchor(anchor)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        ///print("updateUIView")
        
        ///cube.orientation = simd_quatf(angle: Float(-motion.attitudeRoll), axis: SIMD3(x: 0, y: 1, z: 0))
        withAnimation(){
            anchor.orientation = simd_quatf(angle: Float(-motion.attitudeRoll/3), axis: SIMD3(x: 0, y: 1, z: 0))
        }
    }
}

