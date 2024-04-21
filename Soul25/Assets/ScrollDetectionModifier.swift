
import SwiftUI



struct ScrollDetectionModifier: ViewModifier {
    @Binding var userScrolledAmount: CGFloat // Binding to the userScrolledAmount variable
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    let offset = proxy.frame(in: .named("scroll")).minY
                    Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
                }
            )
            .onPreferenceChange(ScrollPreferenceKey.self) { offset in
                withAnimation(.spring()) {
                    userScrolledAmount = offset
                }
            }
    }
}

extension View {
    func scrollDetection(userScrolledAmount: Binding<CGFloat>) -> some View {
        self.modifier(ScrollDetectionModifier(userScrolledAmount: userScrolledAmount))
    }
}
