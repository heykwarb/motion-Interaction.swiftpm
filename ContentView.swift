//
//  ContentView.swift
//  motion-Interaction
//
//  Created by Yohey Kuwa on 2023/05/15.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var motion = MotionSensor()
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack(){
                List{
                    NavigationLink("FluidScrollView") {
                        FluidScrollView(motion: motion)
                    }
                    NavigationLink("BookShelfView") {
                        BookShelfView(motion: motion)
                    }
                    NavigationLink("Aqua Button") {
                        AquaButton(motion: motion)
                    }
                    NavigationLink("Motion3D") {
                        Motion3D(motion: motion)
                    }
                    NavigationLink("icon_withDepth") {
                        icon_withDepth(motion: motion)
                    }
                }
                .navigationTitle("Motion Fluid")
            }
           
        } else {
            // Fallback on earlier versions
        }
    }
}
