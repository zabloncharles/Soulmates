//
//  ScrollDetectionView.swift
//  Soul25
//
//  Created by Zablon Charles on 4/21/24.
//

import SwiftUI

struct ScrollDetectionView: View {
    @Binding var userScrolledAmount: Bool
    var body: some View {
        Rectangle()
            .frame(width: 0, height: 0.0001)
            .scrollDetection(userScrolledAmount: $userScrolledAmount)
            
    }
}


