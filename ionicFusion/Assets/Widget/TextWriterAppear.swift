//
//  TextWriterAppear.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/29/23.
//

import SwiftUI

struct TextWriterAppear: View {
    @State var typeText = "hey john"
    @State var speed = 0.3
    @State var wait = 0.0
    @State var appeared = false
    var body: some View {
        //This is the text we are displaying on the view
        Text(typeText)
        // .customfontFunc(customFont: font, style: size)
            .foregroundColor(.clear)
        
        
        //We are simply scrolling the gradient from left to right for effect
            
            .background(
                VStack {
                    LinearGradient(gradient:
                                    Gradient(colors: [Color("black"), .yellow, Color("black")]),
                                   startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                    
                    .opacity(appeared ? 0 : 1)
                    .offset(x:appeared ? 90 : 0)
                    .animation(.linear(duration: 2.3), value: appeared)
                    
                    
                }
                    
                
                //We mask the gradient with the same text on the view
                    .mask(
                        Text(typeText)
                        //  .customfontFunc(customFont: font, style: size)
                    )
                
            )
            .background(Color.white
                .mask(
                    Text(typeText)
                    //  .customfontFunc(customFont: font, style: size)
                ))
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + wait) {
                    appeared = true
                    typeWriter(typeText) {
                        //Do something
                    }
                }
                
            }
    }
    func typeWriter(_ text: String, completion: @escaping () -> Void) {
      
        typeText = ""
        var currentIndex = 0
        
        Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { timer in
            if currentIndex < text.count {
                let index = text.index(text.startIndex, offsetBy: currentIndex)
                let character = text[index]
                
                DispatchQueue.main.async {
                    withAnimation(.easeIn) {
                        typeText += String(character)
                    } // Update the typedText property on the main queue
                }
                
                currentIndex += 1
            } else {
                
                timer.invalidate()
                completion()
                // Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
                //   withAnimation(.easeInOut) {
                //  typeText = original
                //
                //   }
                // }
                
            }
        }
    }
}

struct TextWriterAppear_Previews: PreviewProvider {
    static var previews: some View {
        TextWriterAppear()
    }
}
