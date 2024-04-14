//
//  PostCard.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/25/23.
//

import SwiftUI

struct HomeCard: View {
    var firstname = "Jane"
    var avatar = ""
    var quote = "Do not go gently into that goodnight!"
    var poster = ""
    @State var percent = 56
    let completion: () -> Void
    var body: some View {
        
        HStack {
          
            //The image is this
            ZStack {
                GetImageAndUrl(url:poster, loaded: .constant(true), imageUrl: .constant(""))
                    .blur(radius: 60)
                    .frame(width: UIScreen.main.bounds.width - 20, height: 407)
                    .cornerRadius(35)
                   
                GetImageAndUrl(url:poster, loaded: .constant(true), imageUrl: .constant(""))
                    .frame(width: UIScreen.main.bounds.width - 29, height: 400)
                    .cornerRadius(33)
                
                //Bottom card avatar and quote
                VStack {
                    Spacer()
                    HStack {
                        GetImageAndUrl(url:avatar, loaded: .constant(true), imageUrl: .constant(""))
                            .frame(width: 60,height: 60)
                            .cornerRadius(60)
                        
                        HStack {
                            Text("\(firstname): ")
                                .font(.headline)
                           
                               
                            +
                            Text(quote)
                                .font(.subheadline)
                            
                        }.lineLimit(2)
                        
                        Spacer()
                    }
                    .padding(5)
                    
                    .background(Color("offwhite"))
                    .cornerRadius(45)
                    .padding(.horizontal,25)
                    .padding(.bottom,20)
                }
            }
            .overlay(
                VStack{
                    HStack{
                        Spacer()
                        Circle()
                            .fill(Color("offwhite"))
                            .frame(width: 30,height: 30)
                            .padding(2)
                            .background(Color("offwhite"))
                            .cornerRadius(60)
                            .overlay (
                                ZStack {
                                    
                                    CircularView(value: Double(percent) / 100.0,lineWidth: 1.0)
                                    
                                    Text("\(percent)%")
                                        .font(.caption)
                                        .foregroundColor(Color("black"))
                                    
                                    
                                }
                            )
                            .offset(x:-10)
                    }.padding(15)
                    Spacer()
                })
            
            neoButton(isToggle: false, shadow: false) {
                //code here
                completion()
            }
        }//the whole two crds right and left individual
        .frame(height: 400)
      
        
    }
}


