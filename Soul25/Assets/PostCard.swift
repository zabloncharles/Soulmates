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
    var post = ""
    var quote = "Do not go gently into that goodnight!"
    var showProfile = false
    @State var profileLoaded = false
    @Binding var indexRemoved : Int
    @Binding var imageUrlReturned : String
    @Binding var imageLoaded : Int
    @State var percent = 56
    @State var animatex = false
    @Binding var unmatch : Bool
    var index = 0
    let completion: () -> Void
    var body: some View {
        
            HStack {
                VStack(spacing: 15.0){
                    VStack {
                        Image(systemName: "heart.fill")
                            .font(.title)
                            .foregroundColor(.red)
                        Text("Like")
                            .fontWeight(.semibold)
                            .foregroundColor(.red)
                    }
                    Image(systemName: "paperplane")
                        .font(.title)
                    Image(systemName: "multiply")
                        .font(.title)
                        .rotationEffect(.degrees(animatex ? 90 : 0))
                        .animation(.spring()) // Add animation for smooth transition
                        .neoButton(isToggle: true) {
                            //
                            animatex = true
                            indexRemoved = index
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                                animatex = false
                                unmatch = true
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                                    unmatch = false
                                }
                            }
                        }
                    Spacer()
                    
                }.padding()
//                    .opacity(index == 0 ? 1 : 0)
                    
                
                
                //The image is this
                ZStack {
                    GetImageAndUrl(url:post, loaded: $profileLoaded, imageUrl: .constant(""))
                        .frame(width: 340, height: 500)
                        .cornerRadius(34)
                        .padding(.horizontal,0)
                        .padding(.trailing,5)
                    
                    
                    //Bottom card avatar and quote
                    VStack {
                        Spacer()
                        HStack {
                            GetImageAndUrl(url:avatar, loaded: .constant(true), imageUrl: $imageUrlReturned)
                                .frame(width: 60,height: 60)
                                .cornerRadius(60)
                            
                            HStack {
                                Text("\(firstname): ")
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
                                        .foregroundColor(Color.white)
                                        
                                        
                                    }
                                )
                                .offset(x:-10)
                        }.padding(15)
                        Spacer()
                    })
                
                .neoButton(isToggle: true) {
                    //code here
                    completion()
                }
            }//the whole two crds right and left individual
            .frame(height: 500)
            .overlay(
                // Rotate the text 90 degrees
                VStack {
                    Spacer()
                    HStack {
                     
                       Text("Liked You: 02/05/2023")
                           
                            .padding(.horizontal)
                            .padding(.vertical,10)
                            .background(Color("offwhite"))
                            
                            .cornerRadius(23)
                            .neoButton(isToggle: false) {
                                //code
                            }
                            .rotationEffect(.degrees(-90))
                            .offset(x:-63)
                        Spacer()
                    }
                }.padding(.bottom, 80)
//                    .opacity(index == 0 ? 1 : 0)
                  
            )
            .onChange(of: profileLoaded) { newValue in
                imageLoaded = imageLoaded + 1
            }
        
    }
}

//struct PostCard_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCard()
//    }
//}
