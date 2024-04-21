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
    @State var editingProfile = false
    @State var isSheetPresented = false
    @State var currentIndex = 5
    
    var body: some View {
        ZStack {
          
            SkullProfile(currentUser: $currentUser, profile: profile, showProfile:  $isSheetPresented, editingProfile: editingProfile, currentIndex: $currentIndex)
        }.onAppear{
            editingProfile = true
           
        }
        .sheet(isPresented: $isSheetPresented, content: {
            if currentIndex != 1 {
               
                    SettingsView(isSheetPresented: $isSheetPresented)
                    .navigationBarHidden(true) // Hide the top bar on the sheet
             
            } else {
                EditProfileInfoDetailView(isSheetPresented: $isSheetPresented)
            }
        })
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
