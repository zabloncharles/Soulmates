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
    @State var imageLoaded = false
    @Binding var loaded : Int
    @State var percent = 56
    let completion: () -> Void
    var body: some View {
        
        
          
            //The image is this
            VStack {
                //Bottom card avatar and quote
                
                VStack {
                    HStack {
                        HStack(spacing:4) {
                            GetImageAndUrl(url:avatar, loaded: .constant(true), imageUrl: .constant(""))
                                .frame(width: 40,height: 40)
                                .cornerRadius(60)
                            
                            VStack(alignment: .leading) {
                               
                                
                                HStack {
                                    Text(firstname)
                                        .bold()
                                        .font(.subheadline)
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                    .font(.system(size: 18, weight: .medium))
                                }
                                
                                
                                Text("2d")
                                    .font(.callout)
                                    .foregroundColor(.gray)
                            }.padding(.leading,5)
                        }
                        
                       
                        Spacer()
                        VStack {
                            Image(systemName: "ellipsis")
                                .onTapGesture {
                                    withAnimation(.spring()){
                                        
                                    }
                            }
                            
                        }
                    }.padding(.trailing,20)
                    Spacer()
                    
                    HStack {
                        VStack {
                            Image(systemName: "quote.opening")
                                .font(.system(size: 18, weight: .medium))
                            
                        }
                        Text(quote)
                            .font(.callout)
                            .italic()
                        
                        Spacer()
                    }.padding(.trailing,10)
                }
                .padding(.leading,20)
                .padding(.vertical,10)
                
                HStack {
                    Rectangle()
                        .fill(Color("black").opacity(0.50))
                        .frame(width:2)
                        .padding(.vertical, 20)
                    
                    ZStack {
                        GetImageAndUrl(url:avatar, width: UIScreen.main.bounds.width - 53, height: 400, loaded: .constant(false), imageUrl: .constant(""))
                        
                            .cornerRadius(14)
                            .offset(x:7, y:-12)
                        GetImageAndUrl(url:poster, width: UIScreen.main.bounds.width - 53, height: 400, loaded: $imageLoaded, imageUrl: .constant(""))
                           
                            .cornerRadius(14)
                            .padding(.bottom,10)
                            .onChange(of: imageLoaded) { newValue in
                                if imageLoaded {
                                    withAnimation(.spring()) {
                                        loaded = loaded + 1
                                    }
                                }
                                
                        }
                    }
                }
                
              
                
                
            
            }
          
            
            .neoButton(isToggle: false) {
                //code here
                completion()
            }

      
        
        
    }
}


struct ViewControdller_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
        
        
    }
}
