//
//  NeumorphicModifier.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 2/22/22.
//

import SwiftUI

struct neumorphicModifier: ViewModifier {
    var padding: CGFloat = -1
    var opacity: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(
                Circle()
                    .fill(Color("offWhite"))
                    .overlay(
                        Circle()
                            .stroke(Color.black, lineWidth: 4)
                            .blur(radius: 4)
                            .offset(x: 2, y: 2)
                            .mask(Circle().fill(LinearGradient(Color("black"), Color.clear)))
                    )
                    .overlay(
                        Circle()
                            .stroke(Color("white"), lineWidth: 8)
                            .blur(radius: 4)
                            .offset(x: -2, y: -2)
                            .mask(Circle().fill(LinearGradient(Color.clear, Color("black"))))
                    )
                    .padding(padding)
                    .opacity(opacity)
            )
        
    }
}

extension View {
    func neumorphiccircle(padding: CGFloat, opacity: CGFloat) -> some View {
        self.modifier(neumorphicModifier(padding: padding, opacity: opacity))
    }
}

