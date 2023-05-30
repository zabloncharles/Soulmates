//
//  UserModel.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 3/4/22.
//

import SwiftUI


struct User: Identifiable {
    var id = UUID()
    var fname: String
    var lname: String
    var notifications: String
    var avatar: String
    var cyclechange: String
    var birthday: String
    var email: String
}



struct Userr: Identifiable {
    var id = UUID()
    var fname: String
}


var matchDummy = [
    UserStruct(firstname: "hey", lastname: "they", notifications: "4", avatar: "a", cyclechange: "66", birthday: "df", email: "email", aboutme: "som", education: "edu", work: "somewere", images: ["String"], likes: ["String"], location: ["String"], lookingfor: "String", online: false, password: "String", matches: 3, age: "", lifestyle: ["String"], lifestyledesc: "String")
]
