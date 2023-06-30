//
//  BookShelfView.swift
//  motion-Interaction
//
//  Created by Yohey Kuwa on 2023/05/14.
//

import SwiftUI

struct BookShelfView: View{
    @ObservedObject var motion: MotionSensor
    
    @State var seeDetails = false
    
    var albums = [
        Album(name: "KICK BACK", imageName: "kickback", frameSize: 90),
        Album(name: "The Life Of Pablo", imageName: "TLOP serif ver_small", frameSize: 90),
        Album(name: "Thriller", imageName: "thriller_small", frameSize: 90),
    ]
    
    let artworkSize: CGFloat = 90
    let frameHeight: CGFloat = 16
    
    ///let bgShadow: Color = C
    var body: some View{
        ZStack{
            Image("WoodBG_small")
                .resizable()
            Color.bgShadow.opacity(1)
            Image("WoodBG_small")
                .resizable()
                .opacity(0.9)
            
            HStack{
                ZStack{
                    Image("WoodBG_small")
                        .resizable()
                    Color.bgShadow.opacity(1)
                        .blendMode(.multiply)
                    Image("WoodBG_small")
                        .resizable()
                        .opacity(0.4)
                        
                }
                .frame(width: 20)
                    
                Spacer()
                
                ZStack{
                    Image("WoodBG_small")
                        .resizable()
                    Color.bgShadow.opacity(1)
                        .blendMode(.multiply)
                    Image("WoodBG_small")
                        .resizable()
                        .opacity(0.4)
                        
                }
                .frame(width: 20)
            }
            .shadow(color: .bgShadow.opacity(0.4), radius: 3)
            .shadow(color: .bgShadow.opacity(0.8), radius: 20)
            
            GeometryReader{ geo in
                ZStack{
                    Image("WoodBG_small")
                        .resizable()
                    Color.bgShadow.opacity(1)
                        .blendMode(.multiply)
                    Image("WoodBG_small")
                        .resizable()
                        .opacity(0.2)
                    
                        
                }
                .clipShape(
                    Path() {path in
                        path.addLines([
                            CGPoint(x: 20, y: 0),
                            CGPoint(x: 0, y: 16),
                            CGPoint(x: geo.size.width, y: 16),
                            CGPoint(x: geo.size.width-20, y: 0),
                            ///CGPoint(x: 0, y: 0),
                        ])
                    }
                )
                .shadow(color: .bgShadow.opacity(0.7), radius: 10)
                .offset(y: geo.size.height/2-16 + artworkSize/2+frameHeight/2)
                
                
            }
            
            VStack{
                ZStack{
                    Image("WoodBG_small")
                        .resizable()
                    Color.white.opacity(0.2)
                }
                .frame(height: frameHeight)
                .shadow(color: .black, radius: 18)
                Spacer()
            }
            ZStack{
                Image("WoodBG_small")
                    .resizable()
                Color.white.opacity(0.2)
            }
            .frame(height: frameHeight)
            .offset(y: artworkSize/2+frameHeight)
            
            HStack{
                ForEach(albums){album in
                    Button(action: {
                        withAnimation(){
                            seeDetails.toggle()
                            if seeDetails{
                                motion.stop()
                                album.frameSize *= 2
                            }else{
                                album.frameSize /= 2
                                motion.start()
                                
                            }
                        }
                    }){
                        Image(album.imageName)
                            .resizable()
                            .frame(width: album.frameSize, height: album.frameSize)
                            .cornerRadius(4)
                            .shadow(radius: 10, x: motion.attitudeRoll*20,y:0)
                            .offset(x: motion.attitudeRoll*20, y: 0)
                    }
                }
            }
        }
        .frame(height: 200)
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding()
        .onAppear(){
            motion.start()
        }
    }
}


struct Album: Identifiable{
    var id = UUID()
    var name: String
    var imageName: String
    @State var frameSize: CGFloat
}
