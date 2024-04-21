//
//  RippleCircle.swift
//  Soul25
//
//  Created by Zablon Charles on 4/20/24.
//

import SwiftUI

import SwiftUI


struct RippleCircle: View {
    @State private var firstCircle = 1.0
    @State private var secondCircle = 1.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.blue)
                .scaleEffect(firstCircle)
                .opacity(2 - firstCircle)
                .onAppear {
                    withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: false)) {
                        firstCircle = 3
                    }
                }
            
            Circle()
                .stroke(.blue)
                .scaleEffect(secondCircle)
                .opacity(2 - secondCircle)
                .onAppear {
                    withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: false)) {
                        secondCircle = 2
                    }
                }
        }
        .padding(50)
    }
}





struct RippleCircle_Previews: PreviewProvider {
    static var previews: some View {
        RippleCircle()
    }
}
