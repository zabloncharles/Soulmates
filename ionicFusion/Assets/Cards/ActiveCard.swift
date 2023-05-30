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
    @State var appeared = false
    var body: some View {
        ZStack {
            VStack{
                Spacer()
            }.frame(width: 190, height: 260)
                .background(
                    Image("image_05")
                        .resizable()
                    //  .blur(radius: 1)
                    //  .aspectRatio(contentMode: .fill)
                    
                )
                .cornerRadius(15)
            
            VStack{
                Spacer()
                HStack {
                    Text(user.firstname)
                        .font(.caption)
                    Text("Active")
                        .font(.caption)
                        .foregroundColor(.green)
                    Spacer()
                }.padding()
                    .background(Color.black)
                    .cornerRadius(25)
            }.padding()
            
            VStack{
                Spacer()
            }.frame(width: 180, height: 180)
                .background( Image("image_09")
                    .resizable())
                .cornerRadius(15)
                .offset(y:-30)
            
            
        }.scaleEffect(appeared ? 1 : 0.95)
            .onAppear{
                withAnimation(.spring()) {
                    appeared = true
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
