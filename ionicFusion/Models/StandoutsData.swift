//
//  StandoutsData.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/15/23.
//


import SwiftUI

struct StandoutsData: Identifiable {
    let id = UUID()
    var name: String
    var subtitle: String
    var text: String
    var image: String
    var background: String
    var logo: String
    var progress: CGFloat
    var messages: Int
}

var standoutsData = [
    StandoutsData(title: "John Aplesty", subtitle: "Message", text: "Build an iOS app for iOS 15 with custom layouts...", image: "Illustration 1", background: "Background 5", logo: "Logo 2", progress: 0.5, messages: 2),
    StandoutsData(title: "Bates Callie", subtitle: "Messages", text: "Learn about the formatted(date:time:) method and AsyncImage", image: "Illustration 2", background: "Background 4", logo: "Logo 2", progress: 0.2, messages: 0),
    StandoutsData(title: "Venessa Hudgens", subtitle: "Message", text: "Reset your CSS, set up your fonts and create your first React component", image: "Illustration 3", background: "Background 3", logo: "Logo 3", progress: 0.8, messages: 5),
    StandoutsData(title: "Bill Watson", subtitle: "Message", text: "Use the GestureDetector Widget to create amazing user interactions", image: "Illustration 4", background: "Background 2", logo: "Logo 1", progress: 0.0, messages: 0)
]
