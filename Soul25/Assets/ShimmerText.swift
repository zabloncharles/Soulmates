//
//  ShimmerText.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 2/21/22.
//

import SwiftUI


struct ShimmerVar: View {
    var text = "Fumble"
    var font = "sanfrancisco"
    var size : UIFont.TextStyle = .title3
    @State var shimmerAppeared = false
    @State var shimmerOpacity = false
    @State var useCustomFont = false
    @State var ifNotCustomFont : Font = .subheadline
    
    var body : some View {
        
        
        textview
        
        
    }
    
    var textview : some View {
        
        VStack {
            
            //This is the text we are displaying on the view
            Text(text)
            // .customfontFunc(customFont: font, style: size)
                .font(.custom("MrDafoe-Regular", size: 42))
                .foregroundColor(.clear)
            
            
            //We are simply scrolling the gradient from left to right for effect
                .background(
                    VStack {
                        LinearGradient(gradient:
                                        Gradient(colors: [Color("black"), .yellow.opacity(0.79), Color("black")]),
                                       startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                        
                            .opacity(shimmerAppeared ? 1 : 1)
//                            .animation(.easeIn(duration: 2.3), value: shimmerAppeared)
                            .animation(.easeIn(duration: 2.3).repeatCount(5).delay(0.5), value: shimmerAppeared)
                        
                        
                    }
                        .offset(x:shimmerAppeared ? 170 : -290)
                    
                    //We mask the gradient with the same text on the view
                        .mask(
                            Text(text)
                                .font(.custom("MrDafoe-Regular", size: 42))
                            //  .customfontFunc(customFont: font, style: size)
                        )
                    
                )
            
            //below which is black
                .background(
                    VStack {
                        LinearGradient(gradient:
                                        Gradient(colors: [Color("black").opacity(shimmerOpacity ? 1 : 0)]),
                                       startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                        
                    }.mask(
                        Text(text)
                            .font(.custom("MrDafoe-Regular", size: 42))
                        //  .customfontFunc(customFont: font, style: size)
                    )
                    
                )
            
        }
        .font(!useCustomFont ? ifNotCustomFont : .custom(font, size: UIFont.preferredFont(forTextStyle: size).pointSize))
        
        .onAppear {
            shimmerAppearFunc()
        }
        .onDisappear {
            shimmerDisappearFunc()
        }
    }
    
    
    
    func typeWriter() {
        shimmerAppeared.toggle()
        
    }
    
    func shimmerAppearFunc(){
        withAnimation(.easeIn(duration: 4)) {
            
            shimmerOpacity  = true
            
        }
        withAnimation(.linear(duration: 4)) {
            shimmerAppeared = true
            
        }
        
       
    }
    func shimmerDisappearFunc(){
        withAnimation(.linear) {
            shimmerAppeared = false
        }
        withAnimation(.linear) {
            shimmerOpacity = false
        }
    }
    
}

struct ShimmerVar_Previews: PreviewProvider {
    static var previews: some View {
        ShimmerVar()
    }
}
