//
//  CourseSection.swift
//  CourseSection
//
//  Created by Meng To on 2021-08-05.
//

import SwiftUI

struct CourseSection: Identifiable {
    let id = UUID()
    var title: String
    var subtitle: String
    var text: String
    var image: String
    var background: String
    var logo: String
    var progress: CGFloat
    var messages: Int
}

var courseSections = [
    CourseSection(title: "John Aplesty", subtitle: "Message", text: "Build an iOS app for iOS 15 with custom layouts...", image: "Illustration 1", background: "Background 5", logo: "Logo 2", progress: 0.5, messages: 2),
    CourseSection(title: "Bates Callie", subtitle: "Messages", text: "Learn about the formatted(date:time:) method and AsyncImage", image: "Illustration 2", background: "Background 4", logo: "Logo 2", progress: 0.2, messages: 0),
    CourseSection(title: "Venessa Hudgens", subtitle: "Message", text: "Reset your CSS, set up your fonts and create your first React component", image: "Illustration 3", background: "Background 3", logo: "Logo 3", progress: 0.8, messages: 5),
    CourseSection(title: "Bill Watson", subtitle: "Message", text: "Use the GestureDetector Widget to create amazing user interactions", image: "Illustration 4", background: "Background 2", logo: "Logo 1", progress: 0.0, messages: 0)
]

struct NotificationModel: Identifiable {
    let id = UUID()
    var name: String
    var message: String
    var numberofmessages: Int
    var avatar: String
    var background: String
    var online: Bool
   
}

var messageSections = [
    NotificationModel(name: "john Bates", message: "Hey bro", numberofmessages: 4, avatar: "ob1", background: "ob1", online: true),
    NotificationModel(name: "Ben Stiller", message: "Reset your CSS, set up your fonts and create your first React component", numberofmessages: 3, avatar: "cover3", background: "cover2", online: false),
    NotificationModel(name: "Ced Rits", message: "Hey bro", numberofmessages: 3, avatar: "cover3", background: "cover2", online: false),
    NotificationModel(name: "Jim Stiller", message: "Hey bro", numberofmessages: 3, avatar: "cover3", background: "cover2", online: false),
    NotificationModel(name: "Terr Gill", message: "Hey bro", numberofmessages: 3, avatar: "cover3", background: "cover2", online: false),
    NotificationModel(name: "Ben Stiller", message: "Hey bro", numberofmessages: 3, avatar: "cover3", background: "cover2", online: false),
    NotificationModel(name: "Nija Wersa", message: "Hey bro", numberofmessages: 3, avatar: "cover3", background: "cover2", online: false)
   
]
