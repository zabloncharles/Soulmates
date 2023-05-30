//
//  DragTest.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/30/23.
//

import SwiftUI


struct DragTest_Previews: PreviewProvider {
    static var previews: some View {
        DragTest()
    }
}

import SwiftUI

struct DragTest: View {
    @State private var cards = [0, 1, 2]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(cards.indices, id: \.self) { index in
                    CardView()
                        .modifier(DraggableCardModifier(index: index, size: geometry.size, cardsCount: cards.count))
                }
            }
        }
    }
}

struct DraggableCardModifier: ViewModifier {
    @State private var offset: CGFloat = 0
    
    let index: Int
    let size: CGSize
    let cardsCount: Int
    
    var body: some View {
        let cardWidth = size.width - 60
        let cardX = CGFloat(index) * 30
        let middleX = size.width / 2
        let distanceFromMiddleX = abs(cardX + 15 - middleX)
        let scale = 1 - min(distanceFromMiddleX / (cardWidth / 2), 0.5)
        
        return CardView()
            .offset(x: offset * cardWidth)
            .scaleEffect(scale)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation.width / cardWidth
                    }
                    .onEnded { gesture in
                        withAnimation {
                            if abs(offset) > 0.5 {
                                let newIndex = offset > 0 ? (index + 1) % cardsCount : (index - 1 + cardsCount) % cardsCount
                                offset = 0
                                cards.swapAt(index, newIndex)
                            } else {
                                offset = 0
                            }
                        }
                    }
            )
    }
}

struct CardView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.blue)
            .frame(width: 200, height: 300)
            .overlay(
                Text("Card")
                    .foregroundColor(.white)
                    .font(.title)
            )
    }
}


