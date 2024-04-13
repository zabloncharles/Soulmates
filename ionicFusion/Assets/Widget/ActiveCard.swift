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
            }.frame(width: 185, height: 220)
            
                
             
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
            }.frame(width: 190, height: 250)
            
                .background(
                    
                    
                    GetImageAndUrl(url:user.avatar, loaded: $userImageLoaded, imageUrl: .constant(""))
                    //
                    //                        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                    
                )
                .cornerRadius(5)
               
            
            
        }
        .background(Color("white"))
        .cornerRadius(12)
        .animation(.spring(), value: userBackgroundLoaded)
       
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
