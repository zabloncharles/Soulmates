


import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    var filename: String
    var loopMode: LottieLoopMode = .playOnce
    var animationView = LottieAnimationView()
    var loop = true
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView()
        
        animationView.animation = LottieAnimation.named(filename)
        animationView.contentMode = .scaleAspectFill
      
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        animationView.play()
    }
}
