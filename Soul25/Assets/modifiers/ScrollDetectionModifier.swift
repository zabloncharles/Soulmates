
import SwiftUI



struct ScrollDetectionModifier: ViewModifier {
    @Binding var userScrolledAmount: Bool // Binding to the userScrolledAmount variable
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    let offset = proxy.frame(in: .named("scroll")).minY
                    Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
                }
            )
            .onPreferenceChange(ScrollPreferenceKey.self) { offset in
                
                if offset > -55 {
                    withAnimation(.spring()) {
                        userScrolledAmount = true
                    }
                } else {
                    withAnimation(.spring()) {
                        userScrolledAmount = false
                    }
                }
               
            }
    }
}

extension View {
    func scrollDetection(userScrolledAmount: Binding<Bool>) -> some View {
        self.modifier(ScrollDetectionModifier(userScrolledAmount: userScrolledAmount))
    }
}
