//
//  CustomFieldModifier.swift
//  CustomFieldModifier
//
//  Created by Meng To on 2021-08-03.
//

import SwiftUI
struct Onboarding2View_Previews: PreviewProvider {
    static var previews: some View {
        // OnboardingView()
        //  OnboardingView(doneIntro: .constant(false), signIn: .constant(false))
        //  .preferredColorScheme(.dark)
        ViewController()
            .preferredColorScheme(.dark)
    }
}
struct TextFieldModifier: ViewModifier {
    var icon: String
    
    func body(content: Content) -> some View {
        content
            .overlay(
                HStack {
                    Image(systemName: icon)
                        .frame(width: 36, height: 36)
                        .background(.thinMaterial)
                        .cornerRadius(30)
                        .offset(x: -46)
                        .foregroundStyle(.secondary)
                        .accessibility(hidden: true)
                    Spacer()
                }
            )
            .foregroundStyle(.primary)
            .padding(15)
            .padding(.leading, 40)
           // .background(.ultraThinMaterial)
          //  .background(LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.05), Color.gray.opacity(0.10)]), startPoint: .leading, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
           
         //   .modifier(OutlineOverlay(cornerRadius: 20))
    }
}

extension View {
    func customField(icon: String) -> some View {
        self.modifier(TextFieldModifier(icon: icon))
    }
}

struct SettingTextFieldModifier: ViewModifier {
    var icon: String
    
    func body(content: Content) -> some View {
        content
            .overlay(
                HStack {
                    Image(systemName: icon)
                        .frame(width: 36, height: 36)
                        .background(.thinMaterial)
                        .cornerRadius(30)
                        .offset(x: -46)
                        .foregroundStyle(.secondary)
                        .accessibility(hidden: true)
                    Spacer()
                }
            )
            .foregroundStyle(.primary)
            .padding(10)
            .padding(.leading, 40)
            .background(.gray.opacity(0.25))
            .cornerRadius(25)
            //.modifier(OutlineOverlay(cornerRadius: 20))
    }
}

extension View {
    func settingcustomField(icon: String) -> some View {
        self.modifier(SettingTextFieldModifier(icon: icon))
    }
}









