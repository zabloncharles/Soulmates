//
//  ProfileView.swift
//  Soul25
//
//  Created by Zablon Charles on 4/14/24.
//

import SwiftUI

struct ProfileView: View {
    @Binding var currentUser: UserStruct?
    @State var profile : UserStruct = fakeUser
    var body: some View {
        ZStack {
          
            SkullProfile(currentUser: $currentUser, profile: profile, showProfile: .constant(true), currentIndex: .constant(0))
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
