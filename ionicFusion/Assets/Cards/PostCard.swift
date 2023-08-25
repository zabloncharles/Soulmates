//
//  PostCard.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/25/23.
//

import SwiftUI

struct PostCard: View {
    var firstname = "Jane"
    var avatar = ""
    var quote = "Do not go gently into that goodnight!"
    var poster = ""
    let completion: () -> Void
    var body: some View {
        
            HStack {
                VStack(spacing: 15.0){
                    VStack {
                        Image(systemName: "heart.fill")
                            .font(.title)
                            .foregroundColor(.red)
                        Text("734")
                            .fontWeight(.semibold)
                    }
                    Image(systemName: "paperplane")
                        .font(.title)
                    Image(systemName: "bookmark")
                        .font(.title)
                    Spacer()
                }.padding()
                
                
                //The image is this
                ZStack {
                    GetImageViewer(url:poster)
                        .frame(width: 340, height: 500)
                        .cornerRadius(34)
                        .padding(.horizontal,0)
                        .padding(.trailing,5)
                    
                    
                    //Bottom card avatar and quote
                    VStack {
                        Spacer()
                        HStack {
                            GetImageViewer(url:avatar)
                                .frame(width: 60,height: 60)
                                .cornerRadius(60)
                            
                            HStack {
                                Text("\(firstname):")
                                    .font(.headline)
                                +
                                Text(quote)
                                    .font(.subheadline)
                                
                            }.lineLimit(2)
                        }
                        .padding(5)
                        .padding(.trailing,15)
                        .background(Color("offwhite"))
                        .cornerRadius(45)
                        .padding()
                    }
                }.neoButton(isToggle: false) {
                    //code here
                    completion()
                }
            }//the whole two crds right and left individual
            .frame(height: 500)
        
    }
}

//struct PostCard_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCard()
//    }
//}
