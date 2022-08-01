//
//  PostModel.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 3/22/22.
//

import SwiftUI

struct PostModel: Identifiable, Hashable {
    var id = UUID()
    var index: Int
    var avatar: String
    var username: String
    var topic: String
    var timeposted: String
    var votes: String
    var post: String
    var views: String
}

var postData = [
    PostModel(
        index: 1, avatar: "ob1", username: "Bill Vern", topic: "Health", timeposted: "30m", votes: "262", post: "hey i jus wan to say that this is sick", views: "234"
        
    ),
    PostModel(
        index: 2, avatar: "image_02", username: "casey Mov", topic: "Health", timeposted: "40m", votes: "62", post: "zzzzzzzzzzzzz nigt adaihdhidhihd dhaidhaiohdhai d ", views: "5677"
        
    )
]
