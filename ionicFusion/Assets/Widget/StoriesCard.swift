//
//  StoriesCard.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/25/23.
//

import SwiftUI



struct StoriesCard: View {
    
    var body: some View{
        
        //the stories
        VStack{
            ScrollView(.horizontal,showsIndicators: false){
               
                        VStack {
                            
                            Image("image_02")
                                .resizable()
                                .frame(width: 70,height: 70)
                                .cornerRadius(60)
                            
                            Text("grandpa")
                                .font(.footnote)
                                .lineLimit(1)
                        }
                   
                
            }
            // .background(LinearGradient(colors: [Color("white"),Color("white"),Color.clear], startPoint: .top, endPoint: .bottom))
            //  .background(Color("offwhite").opacity(0.50))
            //  .background( .ultraThinMaterial.opacity(userScrolledAmount < 35 ? 1 : 0.0))
            // .background(Color("white"))
            
            
            
            Spacer()
        }
    }
}
