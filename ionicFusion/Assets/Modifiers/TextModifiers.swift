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
   
   var body: some View {
      Text(text)
      .foregroundColor(Color.clear)
      .background(LinearGradient(
        gradient: Gradient(colors: gradient),
        startPoint: .leading,
        endPoint: .trailing
      ).mask(Text(self.text)))
   }
   
}
