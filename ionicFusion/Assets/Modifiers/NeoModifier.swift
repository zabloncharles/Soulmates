//
//  NeoModifier.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/29/23.
//

import Foundation
import SwiftUI


struct TapCompletionModifier: ViewModifier {
    @State var isTapped = false
    @State var appeared = false
    var isToggle = false
    let completion: () -> Void
    
    func body(content: Content) -> some View {
        content
            .shadow(color:  .black.opacity(0.3), radius: 10, x:isTapped ? -5 : 10, y:isTapped ? -5 : 10 )
            .shadow(color: Color("white").opacity(0.9),radius: 10, x:isTapped  ? 10 : -5, y:isTapped  ? 10 : -5)
            .scaleEffect(isTapped ? 0.97 : 1)
            .onTapGesture {
            // Execute the completion closure when the view is tapped
                
                if isToggle {
                    withAnimation(.spring()) {
                        isTapped.toggle()
                    }
                  
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            completion()
                        }
                    
                } else {
                    withAnimation(.spring()) {
                        isTapped = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.spring()) {
                            isTapped = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            completion()
                        }
                    }
                }
              
            
        }
    }
}


extension View {
    func neoButton(isToggle: Bool, perform completion: @escaping () -> Void) -> some View {
        return modifier(TapCompletionModifier(isToggle: isToggle, completion: completion))
    }
}


struct TapCompletionModifier2: ViewModifier {
    @State var isTapped = false
    @State var appeared = false
    var isToggle = false
    var cornerRadius = 15
    let completion: () -> Void
    
    func body(content: Content) -> some View {
        content
            .background(Color("offwhite").opacity( appeared ? 1:0))
            .cornerRadius(CGFloat(cornerRadius))
            .shadow(color:  .black.opacity( appeared ? 0.3 : 0 ), radius: 10, x:isTapped ? appeared ? -5 : 0 : 10, y:isTapped ? appeared ? -5 : 0 : appeared ? 10 : 0 )
            .shadow(color: Color("white").opacity( appeared ?  0.9 : 0),radius: 10, x:isTapped  ? appeared ? 10 : 0 : appeared ? -5 : 0, y:isTapped  ? appeared ? 10:0 : appeared ? -5 : 0)
            .scaleEffect(isTapped ? 0.97 : appeared ? 1 : 0.97)
            .onTapGesture {
                // Execute the completion closure when the view is tapped
                
                if isToggle {
                    withAnimation(.spring()) {
                        isTapped.toggle()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        completion()
                    }
                    
                } else {
                    withAnimation(.spring()) {
                        isTapped = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.spring()) {
                            isTapped = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            completion()
                        }
                    }
                }
                
                
            }
            .onAppear{
                
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9)  {
                        withAnimation(.easeIn.speed(0.4)) {
                        appeared = true
                    }
                }
            }
    }
}


extension View {
    func neoButtonOff(isToggle: Bool, cornerRadius: Int, perform completion: @escaping () -> Void) -> some View {
        return modifier(TapCompletionModifier2(isToggle: isToggle, cornerRadius: cornerRadius, completion: completion))
    }
}

struct TapCompletionModifier3: ViewModifier {
    var isTapped = false
    var cornerRadius = 0
  
    
    func body(content: Content) -> some View {
        content
            .background(Color("offwhite"))
            .cornerRadius(CGFloat(cornerRadius))
            .shadow(color:  .black.opacity(0.3), radius: 10, x:isTapped ? -5 : 10, y:isTapped ? -5 : 10 )
            .shadow(color: Color("white").opacity(0.9),radius: 10, x:isTapped  ? 10 : -5, y:isTapped  ? 10 : -5)
            .scaleEffect(isTapped ? 0.97 : 1)
           
    }
}


extension View {
    func neoButtonOffShadow(cornerRadius: Int, isTapped: Bool) -> some View {
        return modifier(TapCompletionModifier3(isTapped: isTapped, cornerRadius: cornerRadius))
    }
}
