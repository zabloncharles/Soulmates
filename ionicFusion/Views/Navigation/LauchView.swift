//
//  LauchView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 4/2/22.
//

import SwiftUI

struct LauchView: View {
    @State var gradientTitle : [Color] =  [.white , .orange, .white]
    @State var gradientMessage : [Color] =  [.blue , .orange, .white]
    @State var appears = false
    @State var complete = false
    @State var backButtonAppeared = false
    @State var messageeTapped = false
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .leading),
        removal: .move(edge: .leading))
    var body: some View {
        ZStack {
           if !complete {
               
               Color.black.edgesIgnoringSafeArea(.all)
         ZStack {
            
         Image("darkblob")
                .offset(x: -154, y: -340)
                .blur(radius: 58)
                
            LottieView(filename: "stars" ,loop: appears)
               
                .offset(x: 0, y: -420)
            
            LottieView(filename: "birds" ,loop: appears)
               
                .offset(x: 0, y: -220)
         
         }.opacity(appears ? 1 : 0)
               
            
            
            
          
                
                VStack {
                    Image("lc2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 350, alignment: .center)
                        .offset(y: -90)
                    
                    
                }.scaleEffect(appears ? 1 : 0.96)
                  .offwhite(offwhitecolor: .purple, offwhitecolorShadow: .black, offwhiteisTapped: appears)
            }
          ViewController()
                .offset(x: complete ? 0 : UIScreen.main.bounds.width * 2.09)
      
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 5)){
                appears = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation(.spring()){
                complete = false
                }
            }
        }
        .onDisappear {
            appears = false
            complete = false
        }
        
        
    }
    
}

struct LauchView_Previews: PreviewProvider {
    static var previews: some View {
        LauchView()
    }
}
