//
//  FontModifier.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 2/21/22.
//

import SwiftUI


//MARK: Neurmorphic Cutom Modifiers
struct customfontModifier: ViewModifier {
    var customFont: String
    var style: UIFont.TextStyle = .body
    
    func body(content: Content) -> some View {
        content
            .font(.custom(customFont, size: UIFont.preferredFont(forTextStyle: style).pointSize))
    }
}

extension View {
    func customfontFunc(customFont : String, style : UIFont.TextStyle) -> some View {
        self.modifier(customfontModifier(customFont : customFont, style: style))
    }
}
