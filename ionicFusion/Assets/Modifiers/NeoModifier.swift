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
