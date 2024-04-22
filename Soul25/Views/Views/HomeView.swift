//
//  HomeView.swift
//  iOS15
//
//  Created by Zablon Charles on 2021-06-22.

import CoreLocation
import SwiftUI
import Lottie

struct HomeView: View {
    @State var profiles: [UserStruct] = []
    @State private var filteredProfiles: [UserStruct] = []
    @Binding var currentUser: UserStruct?
    @State var profile = fakeUsers[0]
    @State var profiletype = 0
    @State var profilesLoaded = 0
    @State var userScrolledAmount : Bool = false

    @State var contentHasScrolled = false
    @State var noCardsPageAppeared = false
    @State var loadingIcon = false
    @State var showProfile = false
    @AppStorage("hidemainTab") var hidemainTab = false
    
    
    var body: some View {
        ZStack {
            BackgroundView()
                ScrollView {
                    ScrollDetectionView(userScrolledAmount: $userScrolledAmount)
                   topbar
                     .padding(.top,70)
                     
                   if (profiletype == 0) {
                       CompatibleProfilesCards(profile: $profile, showProfile: $showProfile)
                           
                   } else {
                       nocards
                   }
                } .coordinateSpace(name: "scroll")
                .cornerRadius(showProfile ? 25 : 0)
                .scaleEffect( showProfile ? 0.98 : 1)
                
            
            
            // show the profile of the user in full view
                SkullProfile(currentUser: $currentUser, profile: profile, showProfile: $showProfile, currentIndex: .constant(0))
                    .animation(.spring(), value: showProfile)
                    .cornerRadius(showProfile ?  40 : 43)
                    .edgesIgnoringSafeArea(.all)
                    .offset(y: !showProfile ? UIScreen.main.bounds.height *  1.02 : 0)
                    
            if loadingIcon  {
                loading
            }
            
            
          
                VStack {
                    VStack {
                     
                        HomeHeaderView(contentHasScrolled: .constant(false), showProfile: .constant(false), profiletype: .constant(0))
                            .padding(.top,40)
                       Rectangle()
                            .fill(.gray.opacity(0.30))
                            .padding(.horizontal)
                            .frame(height:1)
                            .offset(y:-44)
                        typeofprofiles
                            .padding(.top,-45)
                        
                    }.background(Color("offwhiteneo"))
                     
                        .offset(y: userScrolledAmount  ?  -150 : 0)
                    
                        
                    
                    
                    
                    Spacer()
                }
            
        }.edgesIgnoringSafeArea(.all)
    }
    var loading : some View {
        VStack(alignment: .center) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color("black")))
        }
    }
    var topbar : some View {
        VStack {
            // current signed in user card
            HomeProfileHeaderCard()
                .overlay{
                    //app name and right system icons
                navigation
                        .opacity(userScrolledAmount ? 1 : 0)
                        .scaleEffect(userScrolledAmount ? 1 : 0.96)
                    .offset(y:-90)
            }
            Divider()
            // type of profiles cards section
            typeofprofiles
                .opacity(!userScrolledAmount ? 0.30 : 1)
            Divider()
        }.padding(.top,50)
    }
    var nocards: some View {
      NoProfilesView(pageAppeared: $noCardsPageAppeared, profiletype: $profiletype)
    }
    var navigation: some View {
        HomeHeaderView(contentHasScrolled: $contentHasScrolled, showProfile: $showProfile, profiletype: $profiletype)
    }
    
    var typeofprofiles : some View {
        HStack{
            
            
            TypeofMenuRow( tap: $profiletype, selected: 0, placeholder: "COMPATIBLE"){
                
            }
            Spacer()
            Rectangle()
                .frame(width: 1,height: 12)
            TypeofMenuRow(tap: $profiletype, selected: 1, placeholder: "ACTIVE"){
                
            }
            Spacer()
            Rectangle()
                .frame(width: 1,height: 12)
            TypeofMenuRow(tap: $profiletype, selected: 2, placeholder: "NEAR"){
                
            }
            Spacer()
            Rectangle()
                .frame(width: 1,height: 12)
            TypeofMenuRow(tap: $profiletype, selected: 3, placeholder: "NEW HERE"){
                
            }
        }
            .padding(.vertical,5)
            .padding(.horizontal,20)
    }
    
    

}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        ViewController()
        
        
    }
}

