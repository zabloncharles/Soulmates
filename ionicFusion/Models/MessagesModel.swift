//
//  MessagesModel.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 3/21/22.
//

import SwiftUI

struct MessagesModel: Identifiable, Hashable {
    var id = UUID()
    var message: String
    var time: String
    var response: Bool
}

var messages = [
    MessagesModel(
        message: "Hey john",
        time: "2:34 PM",
        response: false
        
    ),
    MessagesModel(
        message: "What up dawg",
        time: "2:34 PM",
        response: true
        
    ),
    MessagesModel(
        message: "Nothing",
        time: "2:34 PM",
        response: false
        
    ),
    MessagesModel(
        message: "Hey john, you are going tot the mall. makes sure to let me know the time please",
        time: "2:34 PM",
        response: true
        
    ),
    MessagesModel(
        message: "So what is going on, why are you not talking to me men",
        time: "2:34 PM",
        response: true
        
    ),
    MessagesModel(
        message: "Say something so i know your alright okay.",
        time: "2:34 PM",
        response: false
        
    ),
    MessagesModel(
        message: "What up dawg",
        time: "2:34 PM",
        response: true
        
    ),
    MessagesModel(
        message: "Nothing",
        time: "2:34 PM",
        response: false
        
    ),
    MessagesModel(
        message: "Hey john, you are going tot the mall. makes sure to let me know the time please",
        time: "2:34 PM",
        response: true
        
    ),
    MessagesModel(
        message: "So what is going on, why are you not talking to me men",
        time: "2:34 PM",
        response: true
        
    ),
    MessagesModel(
        message: "Say something so i know your alright okay.",
        time: "2:34 PM",
        response: false
        
    )
]
