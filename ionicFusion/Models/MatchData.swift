//
//  MatchData.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/15/23.
//

import SwiftUI

struct MatchCardData: Identifiable {
    let id = UUID()
    var name: String
    var location: String
    var quote: String
    var profilepic: String
    var background: String
    var work: String
    var matchscore: String
    var usernumber: Int
    var status: Int
   
}

var matchCardData = [
    MatchCardData(name: "Siri Mattis", location: "Rochester", quote: "You only live once", profilepic: "image_02", background: "image_06", work: "Tech", matchscore: "80", usernumber: 0, status: 0),
    MatchCardData(name: "Vinny Cris", location: "Buffalo", quote: "You only live once", profilepic: "image_05", background: "image_09", work: "Healthcare", matchscore: "90", usernumber: 1, status: 1),
    MatchCardData(name: "Jenni Denny", location: "Crystal Cove", quote: "You only live once", profilepic: "image_06", background: "image_08", work: "WeWork", matchscore: "10", usernumber: 2, status: 0),
    MatchCardData(name: "Siri Mattis", location: "Rochester", quote: "You only live once", profilepic: "image_02", background: "image_06", work: "Tech", matchscore: "80", usernumber: 3, status: 1),
    MatchCardData(name: "Bill Cris", location: "Buffalo", quote: "You only live once", profilepic: "image_05", background: "image_09", work: "Healthcare", matchscore: "90", usernumber: 4, status: 1),
    MatchCardData(name: "Cat Denny", location: "Crystal Cove", quote: "You only live once", profilepic: "image_06", background: "image_02", work: "WeWork", matchscore: "10", usernumber: 5, status: 0),
    MatchCardData(name: "Ben Mattis", location: "Rochester", quote: "You only live once", profilepic: "image_02", background: "image_03", work: "Tech", matchscore: "80", usernumber: 6, status: 1),
    MatchCardData(name: "Ace Cris", location: "Buffalo", quote: "You only live once", profilepic: "image_05", background: "image_09", work: "Healthcare", matchscore: "90", usernumber: 7, status: 0),
    MatchCardData(name: "Carry Denny", location: "Crystal Cove", quote: "You only live once", profilepic: "image_06", background: "image_04", work: "WeWork", matchscore: "10", usernumber: 8, status: 1)
    
]
