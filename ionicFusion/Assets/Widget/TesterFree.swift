import SwiftUI

struct SlidingImagesView: View {
    let images: [String]
    @State private var currentIndex = 0
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(images.indices, id: \.self) { index in
                    Image(images[index])
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width)
                }
            }
        }
        .content.offset(x: -CGFloat(currentIndex) * UIScreen.main.bounds.width)
        .gesture(
            DragGesture()
                .onEnded { value in
                    let offset = value.translation.width
                    let newIndex = currentIndex + (offset > 50 ? -1 : (offset < -50 ? 1 : 0))
                    currentIndex = min(max(0, newIndex), images.count - 1)
                }
        )
    }
}

struct ContentTestView: View {
    let imageNames = ["cover2", "cover3", "image4", "image5"]
    
    var body: some View {
        SlidingImagesView(images: imageNames)
            .frame(height: 200)
    }
}

struct Tester345_Previews: PreviewProvider {
    static var previews: some View {
        ContentTestView()
    }
}
