//
//  CompatibleProfilesCards.swift
//  Soul25
//
//  Created by Zablon Charles on 4/20/24.
//

import SwiftUI

struct CompatibleProfilesCards: View {
    @State var currentUser: UserStruct = fakeUser
    @Binding var profile : UserStruct
    @State var filteredProfiles: [UserStruct] = [] // This will hold the filtered profiles
    
    @State var profilesLoaded = 0
    @State var noCardsPageAppeared = false
    @State var track = ""
    @State var currentUserInterests: [String] = ["Cooking"] //
    @State var loadingBeforeNoCards = false
    @Binding var showProfile : Bool
    var body: some View {
        VStack {
           if profilesLoaded < 5 {
                ProgressView()
                
                    .padding(.top,250)
            }
            if !filteredProfiles.isEmpty {
              
                ZStack {
               
                        
                    
                    VStack(spacing: 10) {
                        ForEach(filteredProfiles, id: \.id) { user in
                            
                            HomeCard(firstname: user.firstName,avatar: user.avatar, poster: user.photos[0], loaded : $profilesLoaded){
                                //tapp does what?
                                withAnimation(.spring()) {
                                    showProfile = true
    //                                hidemainTab = true
                                }
                                profile = user
                            }.padding(.bottom,0)
                           
                            
                            Divider()
                                .padding(.bottom, 10)
                            
                        }
                    }
                    .offset(y: profilesLoaded > 5 ? 0 : UIScreen.main.bounds.height * 1.2)
                   
                    .animation(.spring(), value: profilesLoaded)
                    .padding(.top,10)
                .padding(.bottom,85)
                }
               
                
            } else {
                VStack {
                    if loadingBeforeNoCards {
                        NoProfilesView(pageAppeared: $noCardsPageAppeared, profiletype: .constant(0))
                    } else {
                        ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color("black")))
                    }
                }
                    
            }
        }
        .onAppear{
            
            fetchUserData(parameter: "https://randomuser.me/api/?gender=female&results=10") { result in
                // Check if there is a result from the API call
                if let resultProfiles = result {
                    // Filter the resultProfiles based on common interests with the current user
                    let filteredResultProfiles = resultProfiles.filter { profile in
                        // Check if any interests of the profile match with any interest of the currentUser
                        let commonInterests = Set(profile.interests).intersection(currentUserInterests)
                        // Consider the profile compatible if it has at least one common interest
                        return !commonInterests.isEmpty
                    }
                    // Assign the filtered profiles to the profiles array
                    
                    if filteredResultProfiles.isEmpty {
                        filteredProfiles = fakeUsers
                    } else {
                        filteredProfiles = filteredResultProfiles
                    }
                    
                } else {
                    // If there is no result from the API call, use fakeUsers
                    filteredProfiles = fakeUsers
                }
            }
            
        }
       
    }
    
}

struct CompatibleProfilesCards_Previews: PreviewProvider {
    static var previews: some View {
        CompatibleProfilesCards(profile: .constant(fakeUsers[0]), showProfile:.constant(false))
    }
}
