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



