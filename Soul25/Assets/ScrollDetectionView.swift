//
//  ScrollDetectionView.swift
//  Soul25
//
//  Created by Zablon Charles on 4/21/24.
//

import SwiftUI

struct ScrollDetectionView: View {
    @Binding var userScrolledAmount: CGFloat
    var body: some View {
        Rectangle()
            .frame(width: 0, height: 0.0001)
            .scrollDetection(userScrolledAmount: $userScrolledAmount)
            .onAppear{
                
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        if userScrolledAmount != 0.000000 {
                        userScrolledAmount = 0.000000
                    }
                }
            }
    }
}


