//
//  SearchModel.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 2/23/22.
//

import SwiftUI
struct Suggestion: Identifiable {
    let id = UUID()
    var text: String
}

var suggestionsData = [
    Suggestion(text: "SwiftUI"),
    Suggestion(text: "Flutter"),
    Suggestion(text: "Design"),
    Suggestion(text: "React")
]
