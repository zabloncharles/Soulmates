//
//  LikesView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/14/23.
//

import SwiftUI

struct LikesView: View {
    @AppStorage("hidemainTab") var hidemainTab = false
    @State var pageAppeared = false
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                LottieView(filename: "loveflying" ,loop: true)
                    .frame(width: 100)
                    .opacity(pageAppeared ? 1 : 0)
                
            }.offset( x:-40, y:280)
                .opacity(0.7)
            
            VStack {
                LottieView(filename: "girllikingstuff" ,loop: true)
                    .frame(width: 280)
                    .opacity(pageAppeared ? 1 : 0)
                
            }.offset(y:-160)
            
         
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "fleuron")
                        Text("Likes You")
                        
                    }.font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                    HStack {
                        Image(systemName: "fleuron")
                        Text("Boost")
                    }.padding(.horizontal,12)
                        .padding(.vertical,5)
                        .background(Color.blue.opacity(0.3))
                        .cornerRadius(20)
                        
                }.padding(15).offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 15, action:  .constant(false))
                    .offset(y: pageAppeared ? 0 : -300)
                
                Spacer()
             
                VStack(alignment: .center, spacing: 20.0) {
                   
                    Text("You're new here! No likes yet")
                        .font(.headline)
                    Text("Likes are more intentional on Soulmate so don't worry, They'll come in very soon.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    HStack {
                        Text("Try boosting your profile")
                            .font(.body)
                            .fontWeight(.semibold)
                    }.padding(.horizontal,15)
                        .padding(.vertical,10)
                        .background(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
                        .cornerRadius(30)
                }.padding(10)
                    .opacity(pageAppeared ? 1 : 0)
                    
                    
                    
                Spacer()
            }.padding(20)
        }
            .onAppear{
                hidemainTab = false
                withAnimation(.spring().speed(0.4)){
                    pageAppeared = true
                }
            }
            .onDisappear{
               
                withAnimation(.spring()){
                    pageAppeared = false
                }
            }
    }
}

struct LikesView_Previews: PreviewProvider {
    static var previews: some View {
        LikesView()
    }
}
