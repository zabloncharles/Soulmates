//
//  TextWriterAppear.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/29/23.
//

import SwiftUI

struct TextWriterAppear: View {
    @State var typeText = "Soulmate"
    @State var speed = 0.3
    @State var wait = 0.0
    @State var appeared = false
    var body: some View {
        //This is the text we are displaying on the view
        Text(typeText)
            .font(.custom("MrDafoe-Regular", size: 42))
        
            .foregroundColor(.clear)
            .background( LinearGradient(colors: [Color.red,.blue,.purple], startPoint: .leading, endPoint: .trailing))
            .mask(
                
                Text(typeText)
                    .font(.custom("MrDafoe-Regular", size:  42))
                
                
            )
        
        
        
        
        
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
