import SwiftUI

struct FluidScrollView: View {
    @ObservedObject var motion: MotionSensor
    
    @State var seeDetails = false
    @State var boxSize: CGFloat = 200
    var body: some View {
        ScrollView(){
            HStack{
                Spacer()
                VStack {
                    ForEach(0..<10){_ in
                        Button(action: {
                            withAnimation(){
                                seeDetails.toggle()
                                if seeDetails{
                                    motion.stop()
                                    boxSize = 400
                                    motion.attitudeRoll = 0
                                    motion.attitudePitch = 0
                                }else{
                                    motion.start()
                                    boxSize = 200
                                }
                            }
                        }){
                            Rectangle()
                                .frame(width: boxSize, height: boxSize)
                                .foregroundColor(.green)
                                .cornerRadius(10)
                                .shadow(radius: 10, x: motion.attitudeRoll*10,y:motion.attitudePitch*40)
                                .padding()
                                .offset(x: motion.attitudeRoll*10, y: motion.attitudePitch*40)
                            
                        }
                    }
                }
                Spacer()
            }
            
        }
        .onAppear(){
            motion.start()
        }
    }
}

