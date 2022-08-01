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
        message: "Hey monet",
        time: "2:34 PM",
        response: true
        
    )
]
