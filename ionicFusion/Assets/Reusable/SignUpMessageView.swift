//
//  SignUpMessageView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 6/5/23.
//

import SwiftUI

struct SignUpMessageView: View {
    var title = "Welcome to Fusion"
    var message = "Here at Fusion LLC, we have dedicated half of our life in the solde pupose of helping women all around the globe get the health that they deserve."
    var gradientTitle : [Color] =  [.white , .orange, .white]
    var gradientMessage : [Color] =  [.blue , .orange, .white]
    var image = "lc2"
    @State var appears = false
    @State var backButtonAppeared = false
    @State var messageeTapped = false
    
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .leading),
        removal: .move(edge: .leading))
    var body: some View {
        ZStack {
            LottieView(filename: "stars" ,loop: appears)
                .frame(width: 380)
                .offset(x: 0, y: -420)
            
            LottieView(filename: "birds" ,loop: appears)
                .frame(width: 380)
                .offset(x: 0, y: -220)
            
            
            
            ZStack {
                
                
                VStack{
                    
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 350, alignment: .center)
                        .offset(y: UIScreen.main.bounds.height * -0.1)
                    
                    
                    
                }
                
            }
            .scaleEffect(appears ? 1 : 0.96)
            
            .onTapGesture {
                withAnimation(.spring()){
                    appears.toggle()
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 4)){
                    appears = true
                }
                
            }
            .onDisappear {
                appears = false
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Spacer()
                
                
                
                VStack(alignment: .leading, spacing: 4){
                    Text(title)
                        .fontWeight(.bold)
                        .foregroundColor(.clear)
                        .background(
                            LinearGradient(gradient: Gradient(colors: gradientTitle), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                                .mask(
                                    Text(title)
                                ))
                        .font(.title)
                        .padding(.horizontal, -3)
                    
                    
                    
                    Text(message)
                        .fontWeight(.thin)
                        .foregroundColor(.clear)
                        .background(
                            LinearGradient(gradient: Gradient(colors: gradientMessage), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                            
                                .mask(Text(message)))
                        .font(.callout)
                }.padding()
                    .background(
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .opacity(0)
                    )
                // .rotation3DEffect(Angle(degrees: messageeTapped ? 180 : 0), axis: (x: 0, y: 180, z: 0))
                    .animation(.spring(), value: messageeTapped)
                    .neoButtonOff(isToggle: false, cornerRadius: 15, perform: {
                        //
                    })
                
            }.padding(.horizontal, 18)
                .edgesIgnoringSafeArea(.all)
                .padding(.bottom, 29)
                .onTapGesture(perform: {
                    messageeTapped.toggle()
                })
        }
            
    }
    
}

struct SignUpMessageView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpMessageView()
    }
}
