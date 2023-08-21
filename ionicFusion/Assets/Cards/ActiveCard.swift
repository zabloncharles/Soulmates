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
                    GetImageAlert(url:"https://source.unsplash.com/random/?landscape,dark", loaded: .constant(true))
                        .opacity(appeared ? 1 : 0)
                     //   .resizable()
                    //  .blur(radius: 1)
                    //  .aspectRatio(contentMode: .fill)
                    
                )
                .cornerRadius(10)
            
            VStack{
                Spacer()
                HStack {
                    Text(user.firstname)
                        .font(.caption)
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
                    GetImageAlert(url:user.avatar, loaded: .constant(true))
                        .opacity(appeared ? 1 : 0)
                   // .resizable()
                )
                .cornerRadius(5)
                .offset(y:-22)
            
            
        }.scaleEffect(appeared ? 1 : 0.95)
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
