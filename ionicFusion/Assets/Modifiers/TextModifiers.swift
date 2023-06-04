//
//  TextModifiers.swift
//  TextModifiers
//
//  Created by Meng To on 2021-08-05.
//

import SwiftUI

struct SectionTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.footnote.weight(.semibold))
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
}

extension View {
    func sectionTitleModifier() -> some View {
        modifier(SectionTitleModifier())
    }
}

struct GradientText: View {
   
   @State var text: String
   @State var gradient: [Color]
    @State var typeWriter = true
    @State var typeWriterSpeed = 0.06
    @State var appeared = false
    @State var doneTyping = false
   
   var body: some View {
       
    
           Text(text)
               .foregroundColor(Color.clear)
           
               .background(
                ZStack {
                    Color("black")
                        .mask(Text(self.text))
                    LinearGradient(
                        gradient: Gradient(colors: gradient),
                        startPoint: .leading,
                        endPoint: .trailing
                    ).offset(x:doneTyping ? 100 : 0)
                        .mask(Text(self.text))
                })
               .onAppear{
                  if typeWriter {
                       withAnimation(.spring()) {
                           appeared = true
                       }
                       typeWriter(text){
                           withAnimation(.spring()) {
                               doneTyping = true
                           }
                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                               withAnimation(.spring()) {
                                   doneTyping = false
                               }
                           }
                           
                       }
                   }
               }
       
          
       
   }
    func typeWriter(_ textr: String, completion: @escaping () -> Void) {
        
        text = ""
        var currentIndex = 0
        
        Timer.scheduledTimer(withTimeInterval: typeWriterSpeed, repeats: true) { timer in
            if currentIndex < textr.count {
                let index = textr.index(textr.startIndex, offsetBy: currentIndex)
                let character = textr[index]
                
                DispatchQueue.main.async {
                        text += String(character)
                     // Update the typedText property on the main queue
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

struct Previews_TextModifiers_Previews: PreviewProvider {
    static var previews: some View {
        GradientText(text: "Hello, World", gradient: [Color.black,Color.yellow,Color.blue])
    }
}
