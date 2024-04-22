//
//  OffwhiteButtonModifier.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 2/22/22.
//

import SwiftUI
struct OffwhiteButtonTapped: ViewModifier {
    @State var isTapped: Bool
    @State var isToggle: Bool
    @State var cornerRadius: CGFloat = 15
    @Binding var action : Bool
    let generator = UINotificationFeedbackGenerator()
    
    
    func body(content: Content) -> some View {
        content
            .background(Color("offwhite").opacity(0.8))
            .cornerRadius(cornerRadius)
//            .shadow(color:  .black.opacity(0.9), radius: 10, x:isTapped ? -5 : 10, y:isTapped ? -5 : 10 )
//            .shadow(color: Color("white").opacity(0.3),radius: 10, x:isTapped  ? 10 : -5, y:isTapped  ? 10 : -5)
            .scaleEffect(isTapped ? 0.97 : 1)
        
            .onTapGesture {
                let impactMed = UIImpactFeedbackGenerator(style: .light)
                impactMed.impactOccurred()
                if isToggle {
                   
                    withAnimation(.spring())  {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.spring()) {
                                action.toggle()
                            }
                        }
                        isTapped.toggle()
                    }
                } else {
                   
                    withAnimation(.spring()) {
                        action = true
                        isTapped = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        withAnimation(.spring()) {
                            isTapped = false
                          //  action = true
                        }
                        
                    }
                }
            }
        
    }
}

extension View {
    func offwhitebutton(isTapped: Bool, isToggle: Bool, cornerRadius: CGFloat, action : Binding<Bool>) -> some View {
        self.modifier(OffwhiteButtonTapped(isTapped: isTapped, isToggle: isToggle, cornerRadius: cornerRadius, action: action))
    }
}



//------------------------------------------------------
//MARK: Neurmorphic Cutom Modifiers that can tap above
struct offwhiteModifier2: ViewModifier {
    var offwhitecolor: Color = Color("black")
    var offwhitecolorShadow: Color = Color("white")
    var offwhiteisTapped: Bool
    @Binding var tapped: Bool
    
    func body(content: Content) -> some View {
        
        
        content
        //  .background(Color("offwhite"))
        // .cornerRadius(19)
            .shadow(color:  offwhitecolor.opacity(0.9), radius: 10, x:offwhiteisTapped ? -5 : 10, y:offwhiteisTapped ? -5 : 10 )
            .shadow(color: offwhitecolorShadow.opacity(0.9),radius: 10, x:offwhiteisTapped  ? 10 : -5, y:offwhiteisTapped  ? 10 : -5)
            .onTapGesture {
                
                tapped.toggle()
                
            }
        
        
        
        
    }
}

extension View {
    func offwhiteButton(offwhitecolor : Color, offwhitecolorShadow : Color, offwhiteisTapped : Bool, tapped : Binding<Bool>) -> some View {
        self.modifier(offwhiteModifier2(offwhitecolor : offwhitecolor, offwhitecolorShadow: offwhitecolorShadow, offwhiteisTapped: offwhiteisTapped, tapped: tapped))
    }
}

