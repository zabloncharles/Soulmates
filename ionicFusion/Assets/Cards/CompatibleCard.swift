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
    @State var appeared = false
    
    var body: some View {
        ZStack {
            VStack{
                Spacer()
            }.frame(width: 350, height: 500)
                .background(LinearGradient(colors: [Color("offwhiteneo"), Color.clear, Color.clear], startPoint: .bottom, endPoint: .top))
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
                    Text(user.online ? "Active Today" : "Inactive")
                        .font(.footnote)
                        .foregroundColor(user.online ? .green : .red)
                    Spacer()
                }.padding()
                    .background(Color.black)
                    .cornerRadius(25)
            }.padding()
                .padding(.bottom,25)
            
            VStack{
                Spacer()
            }.frame(width: 340, height: 400)
                
                .background( Image("image_09")
                    .resizable())
                
                .cornerRadius(15)
                .offset(y:-40)
            
            
        } .scaleEffect(appeared ? 1 : 0.97)
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

//struct CompatibleCard_Previews: PreviewProvider {
//    static var previews: some View {
//        CompatibleCard(){
//            //
//        }
//    }
//}
