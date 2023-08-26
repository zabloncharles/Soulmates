//
//  TextAnimatingGradient.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/25/23.
//


import SwiftUI


struct TextAnimatingGradient: View {
    var text = "Shimmer text here"
    var font = "sanfrancisco"
    var size : UIFont.TextStyle = .title3
    var colors : [Color] = [Color.blue,Color("black"),Color.pink]
    @State var shimmerAppeared = false
    @State var shimmerOpacity = false
    @State var useCustomFont = false
    @State var ifNotCustomFont : Font = .subheadline
    
    func getRandomColor() -> [Color] {
        let colors = [colors[Int.random(in: 0..<colors.count)],colors[Int.random(in: 0..<colors.count)],colors[Int.random(in: 0..<colors.count)]]
        return colors
    }
    
    var body : some View {
        
        
        textview
        
        
    }
    
    var textview : some View {
        
        VStack {
            
            //This is the text we are displaying on the view
            Text(text)
            // .customfontFunc(customFont: font, style: size)
                .foregroundColor(.clear)
            
            
            //We are simply scrolling the gradient from left to right for effect
                .background(
                    VStack {
                        LinearGradient(gradient:
                                        Gradient(colors: [Color("black"), .yellow, Color("black")]),
                                       startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                        
                        .opacity(shimmerAppeared ? 1 : 1)
                        .animation(.easeIn(duration: 2.3), value: shimmerAppeared)
                        
                        
                    }
                        .offset(x:shimmerAppeared ? 170 : -290)
                    
                    //We mask the gradient with the same text on the view
                        .mask(
                            Text(text)
                            //  .customfontFunc(customFont: font, style: size)
                        )
                    
                )
            
            //below which is black
                .background(
                    VStack {
                        ZStack {
                            
                            
                            LinearGradient(gradient:
                                            Gradient(colors: [Color("black").opacity(shimmerOpacity ? 1 : 0)]),
                                           startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                            
                            LinearGradient(gradient:
                                            Gradient(colors: getRandomColor()),
                                           startPoint: .leading, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                           // .opacity(shimmerOpacity ? 0 : 0)
                            
                           
                        }
                        
                    }.mask(
                        Text(text)
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

struct ShimmerVarr_Previews: PreviewProvider {
    static var previews: some View {
        TextAnimatingGradient()
    }
}
