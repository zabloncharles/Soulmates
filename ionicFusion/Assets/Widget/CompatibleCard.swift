//
//  CompatibleCard.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/30/23.
//

import SwiftUI

struct CompatibleCard: View {
    let completion: () -> Void
    var user: UserStruct
    var namespace: Namespace.ID
    @State var userImageLoaded = false
    @State var userBackgroundLoaded = false
    @State var appeared = false
    @State var randomGradients = [Color.purple, Color.blue, Color.white,Color.red]
    
    var body: some View {
        ZStack {
            ZStack {
                VStack{
                    Spacer()
                }.frame(width: 390, height: 500)
                    .background(LinearGradient(colors: [Color("offwhiteneo"), Color.clear, Color.clear], startPoint: .bottom, endPoint: .top))
                    .background(
                        // Image("image_04")
                        //  .resizable()
                        GetImageAlert(url:"https://source.unsplash.com/random/?space,stars", loaded: $userBackgroundLoaded)
                            .blur(radius: userBackgroundLoaded ? 0 : 5)
                            .opacity(appeared ? 1 : 0)
                        //  .aspectRatio(contentMode: .fill)
                        
                    )
                    .cornerRadius(15)
                
                VStack{
                    Spacer()
                    
                    VStack {
                        Text(user.firstname)
                            .font(.custom("BodoniFLF-Roman", size: 28))
                            .foregroundColor(.clear)
                            .background(LinearGradient(colors: [randomGradients.randomElement() ?? .clear,Color.white,randomGradients.randomElement() ?? .clear], startPoint: .leading, endPoint: .trailing))
                        
                            .multilineTextAlignment(.center)
                        
                            .mask (
                                Text(user.firstname)
                                    .font(.custom("BodoniFLF-Roman", size: 28))
                                    .multilineTextAlignment(.center)
                            )
                        // Text("There is only one way to find love and thats to go out there and expose yourself to the wonders of nature")
                        Rectangle()
                            .opacity(0.45)
                            .frame(width: 250, height:0.2)
                            .padding(-10)
                        
                        Text(user.aboutme)
                            .font(.custom("BodoniFLF-Italic", size: 15))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 270)
                            .lineLimit(3)
                            .padding(.top,-8)
                    }
                    // Text(user.online ? "Active Today" : "Inactive")
                    // .font(.footnote)
                    // .foregroundColor(user.online ? .green : .red)
                    // Spacer()
                    
                    // .background(Color.black)
                    // .cornerRadius(10)
                }.padding()
                    .padding(.bottom,10)
                
                VStack{
                    Spacer()
                }.frame(width: 380, height: 400)
                
                    .background( //Image("image_02")
                        VStack {
                            
                            
                            
                            GetImageAlert(url:user.avatar, loaded: $userImageLoaded)
                            // .matchedGeometryEffect(id: "\(user.avatar)", in: namespace)
                            
                            
                            
                        }
                    )
                
                    .cornerRadius(10)
                    .offset(y:-44)
                
                
                
                
            }.overlay(
                VStack {
                    if !userImageLoaded || !userBackgroundLoaded {
                        ZStack {
                        Rectangle()
                        .fill(Color("offwhite").opacity(100))
                    .cornerRadius(13)
                        
                            LottieView(filename: "droplet",loop: true)
                                .offset(y:-60)
                                .scaleEffect(1.6)
                                .mask(Circle())
                               // .colorInvert()
                                .colorMultiply(Color("offwhite"))
                            
                        Image("fusionhalfgirl")
                            .resizable()
                          //  .rotation3DEffect(.degrees(userBackgroundLoaded ? 0 : 180), axis: (x: 0, y: 1, z: 0))
                           // .frame(width: 185, height: 235)
                        
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(13)
                            .padding(30)
                            .colorMultiply(.black)
                         
                            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                        
                            
                        }
                    }
                }
            
            )
            
            //.scaleEffect(appeared ? 1 : 0.97)
            .onAppear{
                withAnimation(.spring()) {
                    appeared = true
                }
            }
            .onDisappear{
                withAnimation(.spring()) {
                    appeared = false
                }
            }
            .neoButton(isToggle: false) {
                //Do this
                completion()
        }
        }
    }
}

struct CompatibleCard_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
    }
}
