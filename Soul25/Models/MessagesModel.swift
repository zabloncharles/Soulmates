//
//  MessagesModel.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 3/21/22.
//

import SwiftUI


struct MessageModel: Identifiable {
    let id = UUID()
    let userID: String
    let text: String
    let sender: String
    let timestamp: String
    let stamp: String
}

var messages = [
    MessageModel(userID: "user1", text: "Hello, how are you?", sender: "user1", timestamp: "2023-08-19 10:00:00", stamp: "Sent"),
    MessageModel(userID: "user2", text: "I'm doing well, thanks! Just finished a great book.", sender: "user2", timestamp: "2023-08-19 10:05:00", stamp: "Received"),
    MessageModel(userID: "user1", text: "That's great to hear! What book did you read?", sender: "user1", timestamp: "2023-08-19 10:10:00", stamp: "Sent"),
    MessageModel(userID: "user2", text: "I read 'The Great Gatsby' by F. Scott Fitzgerald. It's a classic!", sender: "user2", timestamp: "2023-08-19 10:15:00", stamp: "Received"),
    MessageModel(userID: "user1", text: "Ah, I love that book! The symbolism in it is amazing.", sender: "user1", timestamp: "2023-08-19 10:20:00", stamp: "Sent"),
    MessageModel(userID: "user2", text: "Yes, the green light at the end of Daisy's dock is so iconic.", sender: "user2", timestamp: "2023-08-19 10:25:00", stamp: "Received"),
    MessageModel(userID: "user1", text: "Exactly! Have you read any other classics recently?", sender: "user1", timestamp: "2023-08-19 10:30:00", stamp: "Sent"),
    MessageModel(userID: "user2", text: "Not recently, but I'm thinking about reading 'To Kill a Mockingbird' next.", sender: "user2", timestamp: "2023-08-19 10:35:00", stamp: "Received"),
    MessageModel(userID: "user1", text: "That's a fantastic choice! Harper Lee's writing is exceptional.", sender: "user1", timestamp: "2023-08-19 10:40:00", stamp: "Sent"),
    MessageModel(userID: "user2", text: "I've heard great things about it. Can't wait to start!", sender: "user2", timestamp: "2023-08-19 10:45:00", stamp: "Received"),
    MessageModel(userID: "user1", text: "Let me know how you like it when you finish.", sender: "user1", timestamp: "2023-08-19 10:50:00", stamp: "Sent"),
    MessageModel(userID: "user2", text: "I will! Do you have any other book recommendations?", sender: "user2", timestamp: "2023-08-19 10:55:00", stamp: "Received"),
    MessageModel(userID: "user1", text: "Sure, have you read '1984' by George Orwell?", sender: "user1", timestamp: "2023-08-19 11:00:00", stamp: "Sent"),
    MessageModel(userID: "user2", text: "No, I haven't. What's it about?", sender: "user2", timestamp: "2023-08-19 11:05:00", stamp: "Received"),
    MessageModel(userID: "user1", text: "'1984' is a dystopian novel about a totalitarian regime and the loss of individual freedom.", sender: "user1", timestamp: "2023-08-19 11:10:00", stamp: "Sent"),
    MessageModel(userID: "user2", text: "That sounds intriguing. I'll add it to my reading list!", sender: "user2", timestamp: "2023-08-19 11:15:00", stamp: "Received"),
    // Add more fake messages to make the conversation even longer
    // Add more fake messages as needed
]


var chatLogs = (["email":"zab.charles@gmail.com"],["logs": messages])
