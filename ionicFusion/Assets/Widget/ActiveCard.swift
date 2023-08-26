//
//  ActiveCard.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/30/23.
//

import SwiftUI

struct ActiveCard: View {
    let completion: () -> Void
    var user: UserStruct
    @State var userImageLoaded = false
    @State var userBackgroundLoaded = false
    
    @State var appeared = false
    var body: some View {
        ZStack {
            VStack{
                
                Spacer()
            }.frame(width: 185, height: 230)
            
                .background(LinearGradient(colors: [Color("offwhiteneo"),  Color.clear], startPoint: .bottom, endPoint: .top))
                .background(
                    // Image("image_09")
                    GetImageAlert(url:"https://source.unsplash.com/random/?landscape,dark", loaded: $userBackgroundLoaded)
                        .animation(.easeIn, value: userBackgroundLoaded)
                        .opacity(userBackgroundLoaded ? 1 : 0)
                    //   .resizable()
                    //  .blur(radius: 1)
                    //  .aspectRatio(contentMode: .fill)
                    
                )
                .cornerRadius(8)
            
            VStack{
                Spacer()
                HStack {
                    Text(user.firstname)
                        .font(.footnote)
                    Text("Active")
                        .font(.caption)
                        .foregroundColor(.green)
                    Spacer()
                }.padding(.vertical)
                    .padding(.leading,5)
                    .offset(y:15)
                //.background(Color.black)
                //.cornerRadius(15)
            }.padding()
            
            VStack{
                Spacer()
            }.frame(width: 180, height: 180)
            
                .background(
                    
                    
                    GetImageAlert(url:user.avatar, loaded: $userImageLoaded)
                    //
                    //                        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                    
                )
                .cornerRadius(5)
                .offset(y:-22)
            
            
        }
        .overlay(
            
            Image("cardhalfgirldark")
                .resizable()
                .rotation3DEffect(.degrees(userBackgroundLoaded ? 0 : 180), axis: (x: 0, y: 1, z: 0))
                .frame(width: 185, height: 235)
            
                .cornerRadius(10)
                .frame(width: 185, height: 230)
                .animation(.easeInOut.speed(0.25), value: userBackgroundLoaded)
                .opacity(userBackgroundLoaded ? 0 : 1)
        )
        .rotation3DEffect(.degrees(userBackgroundLoaded ? 0 : 180), axis: (x: 0, y: 1, z: 0))
        .animation(.spring(), value: userBackgroundLoaded)
        .scaleEffect(appeared ? 1 : 0.95)
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

//struct ActiveCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ActiveCard(){
//            //
//        }
//    }
//}
