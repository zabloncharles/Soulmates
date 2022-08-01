//
//  RecommendedModel.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 3/30/22.
//

import SwiftUI

struct RecommendedModel: Identifiable {
    let id = UUID()
    var index: Int
    var title: String
    var subtitle: String
    var text: String
    var image: String
    var background: String
    var logo: String
}



var RecommendedData2 = [
    RecommendedModel(index: 1, title: "are you seroius dawg?", subtitle: "20 sections - 3 hours", text: "Pregnant? Hangry? Looking for a snack that will make your tummy and your baby happy? You’re probably hearing it a lot: Eating nutritious foods while pregnant is essential.", image: "Illustration 9", background: "Background 5", logo: "Logo 2"),
    RecommendedModel(index: 2, title: "like really ", subtitle: "20 sections - 3 hours", text: "Here are 12 tips from Dr. Meadows to help you increase your chances of having a healthy pregnancy and a healthy baby.", image: "Illustration 2", background: "Background 3", logo: "Logo 3"),
    RecommendedModel(index: 3, title: "what is your problem", subtitle: "20 sections - 3 hours", text: "Design an iOS app for iOS 15 with custom layouts, animations and ...", image: "Illustration 3", background: "Background 4", logo: "Logo 4"),
    RecommendedModel(index: 4, title: "hater much", subtitle: "20 sections - 3 hours", text: "Flutter is a relatively new toolkit that makes it easy to build ", image: "Illustration 1", background: "Background 1", logo: "Logo 1"),
]


