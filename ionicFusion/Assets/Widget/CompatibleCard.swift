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
    @State var appeared = false
    @State var randomGradients = [Color.purple, Color.blue, Color.white,Color.red]
    
    var body: some View {
        
            ZStack {
                VStack{
                    Spacer()
                }.frame(width: 390, height: 500)
                    .background(LinearGradient(colors: [Color.clear, Color.clear, Color.clear], startPoint: .bottom, endPoint: .top))
                    .background(
                        GetImageAlert(url:"https://source.unsplash.com/random/?hotgirl,prettywoman", loaded: $userImageLoaded)
                            .opacity(appeared ? 1 : 0)
                        
                    )
                    .cornerRadius(15)
                
                VStack{
                    Spacer()
                    
                    VStack {
                        Text(user.firstname)
                            .font(.custom("BodoniFLF-Roman", size: 28))
                            .foregroundColor(Color("black"))
                            .multilineTextAlignment(.center)
                       
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
                    } .padding()
                        .background(Color("offwhite"))
                        .cornerRadius(12)
                }
            
                .frame(width: 900)
                    .padding(.bottom,10)
            }

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

struct CompatibleCard_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
    }
}
