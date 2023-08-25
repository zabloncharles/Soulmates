//
//  KerboardAvoiderModifier.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/24/23.
//

import SwiftUI

struct KeyboardAvoider: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onAppear(perform: subscribeToKeyboardEvents)
            .onDisappear(perform: unsubscribeFromKeyboardEvents)
    }
    
    private func subscribeToKeyboardEvents() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: .main
        ) { notification in
            if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                keyboardHeight = keyboardSize.height
            }
        }
        
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: .main
        ) { _ in
            keyboardHeight = 0
        }
    }
    
    private func unsubscribeFromKeyboardEvents() {
        NotificationCenter.default.removeObserver(self)
    }
}

extension View {
    func keyboardAvoider() -> some View {
        modifier(KeyboardAvoider())
    }
}
