//
//  AquaButton.swift
//  motion-Interaction
//
//  Created by Yohey Kuwa on 2023/05/15.
//

import SwiftUI

struct AquaButton: View{
    @ObservedObject var motion: MotionSensor
    
    var baseColor_Blue = LinearGradient(gradient: Gradient(colors: [.blue1, .blue2]), startPoint: .top, endPoint: .bottom)
    ///var baseColor_Orange = LinearGradient(gradient: Gradient(colors: [.orange1, .orange2]), startPoint: .top, endPoint: .bottom)
    let gradient2 = LinearGradient(gradient: Gradient(colors: [.white.opacity(0.9), .white.opacity(0.3), .white.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
    
    
    let offset1: CGFloat = 5
    
    var buttonText = "button"
    
    var size: CGSize = CGSize(width: 200, height: 60)
    
    var body: some View{
        let cornerR: CGFloat = size.height/2
        let padding1: CGFloat = size.height/4
        let padding2: CGFloat = 2
        Button(action: {}){
            ZStack{
                //highlights edge
                Rectangle()
                    .fill(.white.opacity(0.8))
                    .cornerRadius(cornerR)
                    .shadow(radius: 6, x: motion.attitudeRoll*20, y: motion.attitudePitch*20)
                
                //base background
                Rectangle()
                    .fill(baseColor_Blue)
                    .cornerRadius(cornerR)
                    .padding(padding2)
                    .blur(radius: padding2)
                
                //highlight
                Rectangle()
                    .fill(.white.opacity(0.5))
                    .cornerRadius(cornerR)
                    .padding(10)
                    .blur(radius: 10)
                
                Text(buttonText)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary.opacity(0.8))
                    .shadow(radius: 6, x: motion.attitudeRoll*10, y: motion.attitudePitch*10)
                    .padding()
                
                //highlight on a top
                Rectangle()
                    .fill(gradient2)
                    .cornerRadius(cornerR)
                    .padding(padding1)
                    .offset(y: -size.height/4 + padding2*2)
                    .blur(radius: padding2)
                
                
                
            }
            .frame(width: size.width, height: size.height)
            .offset(x: motion.attitudeRoll*25, y: motion.attitudePitch*25)
            .onAppear(){
                motion.start()
            }
        }
    }
}
