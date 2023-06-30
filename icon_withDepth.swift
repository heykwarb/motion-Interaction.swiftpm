//
//  icon_3d.swift
//  motion-Interaction
//
//  Created by Yohey Kuwa on 2023/06/08.
//

import SwiftUI

struct icon_withDepth: View {
    @ObservedObject var motion: MotionSensor
    
    var body: some View {
        HStack{
            icon(motion: motion, iconSize: 200, firstLayerImage: true, imgName1st: "maps_icon_1", imgName2nd: "maps_icon_2", imgName3rd: "maps_icon_3")
            
            ///icon(motion: motion, iconSize: 100, firstLayerImage: false, color1st: .twitterBlue, imgName2nd: "twitter_icon_2")
            
            ///icon(motion: motion, iconSize: 100, firstLayerImage: true, imgName1st: "instagram_icon_1", imgName2nd: "instagram_icon_2")
            
            ///icon(motion: motion, iconSize: 100, firstLayerImage: false, color1st: .white, imgName2nd: "youtube_icon_2")
        }
    }
}

struct icon_withDepth_Previews: PreviewProvider {
    
    static var previews: some View {
        icon_withDepth(motion: MotionSensor())
            
    }
}

struct icon: View {
    @ObservedObject var motion: MotionSensor
    var iconSize: CGFloat
    var firstLayerImage: Bool
    var color1st = Color.blue
    var imgName1st = ""
    var imgName2nd = ""
    var imgName3rd = ""
    
    var body: some View {
        ZStack{
            if firstLayerImage{
                Image(imgName1st)
                    .resizable()
                    .scaledToFit()
            }else{
                Rectangle()
                    .foregroundColor(color1st)
            }
                
            Image(imgName2nd)
                .resizable()
                .scaledToFit()
                .shadow(radius: iconSize/20, x: -motion.attitudeRoll/CGFloat.pi*iconSize/2/4, y: -motion.attitudePitch/CGFloat.pi*iconSize/2/4)
                ///.offset(x: motion.attitudeRoll/CGFloat.pi*iconSize/2/2, y: motion.attitudePitch/CGFloat.pi*iconSize/2/2)
            
            Image(imgName3rd)
                .resizable()
                .scaledToFit()
                .shadow(radius: iconSize/10, x: -motion.attitudeRoll/CGFloat.pi*iconSize/2/4, y: -motion.attitudePitch/CGFloat.pi*iconSize/2/4)
            
            Circle()
                .frame(width: iconSize/2, height: iconSize/2)
                .blur(radius: iconSize/2/4)
                .foregroundColor(.white.opacity(0.5))
                .offset(x: -motion.attitudeRoll/CGFloat.pi*iconSize, y: -motion.attitudePitch/CGFloat.pi*iconSize)
        }
        .frame(width: iconSize, height: iconSize)
        .clipShape(Circle())
        .shadow(radius: iconSize/30, x: -motion.attitudeRoll/CGFloat.pi*iconSize/2/8, y: -motion.attitudePitch/CGFloat.pi*iconSize/2/8)
        ///.offset(x: motion.attitudeRoll/CGFloat.pi*iconSize/2/4, y: motion.attitudePitch/CGFloat.pi*iconSize/2/4)
        .rotation3DEffect(Angle(degrees: Double(motion.attitudeRoll/CGFloat.pi*90/1.5)), axis: (x: 0, y: 1, z: 0))
        .rotation3DEffect(Angle(degrees: Double(-motion.attitudePitch/CGFloat.pi*90/1.5)), axis: (x: 1, y: 0, z: 0))
        .onAppear(){
            motion.start()
        }
    }
}
