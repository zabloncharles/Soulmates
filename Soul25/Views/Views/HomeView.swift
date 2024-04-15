//
//  HomeView.swift
//  iOS15
//
//  Created by Zablon Charles on 2021-06-22.


import SwiftUI
import Lottie

struct HomeView: View {
    @State var profiles: [UserStruct] = compatibleFakeUsers
    @Binding var currentUser: UserStruct?
    @State var profile = userStruct[0]
    @State var profiletype = 0
    @State var userScrolledAmount = 0
    @State var contentHasScrolled = false
    @State private var pageAppeared = false
    @State var profileAppeared = false
    @State private var showProfile = false
    @AppStorage("signInAnimation") var signInAnimation = false
    @AppStorage("hidemainTab") var hidemainTab = false
    
    
    var body: some View {
        
        ZStack {
            
            BackgroundView()
            
            
           
                ScrollView {
                    VStack {
                        
                        topbar
                            .padding(.top,70)
                        
                        
                       
                            
                            
                            
                        if (profiletype == 0) {
                            compatible
                                .tag(0)
                            
                        }
                           
                            
                        if (profiletype == 1) {
                            
                            active
                                .tag(1)
                             
                        }
                            
                           
                            
                        if (profiletype == 2) {
                            
                            near
                                .tag(2)
                               
                        }
                            
                            
                            
                        if (profiletype == 3) {
                            newhere
                                .tag(3)
                               
                            
                        }
                            
                         
                            
                          
                            
                        
                    }
//                  .offset(y: showProfile ? UIScreen.main.bounds.height *  -1.02 : 0)
               
                    .cornerRadius(showProfile ? 25 : 0)
                    .scaleEffect( showProfile ? 0.90 : 1)
                }
          
            
            
            
            
            
            
            
          
                SkullProfile(currentUser: $currentUser, profile: profile, showProfile: $showProfile, currentIndex: .constant(0))
                 .animation(.spring(), value: showProfile)
                    .cornerRadius(showProfile ?  40 : 43)
                    .edgesIgnoringSafeArea(.all)
                    .offset(y: !showProfile ? UIScreen.main.bounds.height *  1.02 : 0)
                    
                   
                
            
            
            
                
            
          
            
            
        }.onAppear{
            
            withAnimation(.spring()){
                pageAppeared = true
                
            }
        }
        .onDisappear{
            withAnimation(.spring()){
                pageAppeared = false
            }
        }
        
    }
    var topbar : some View {
        
        VStack {
         
            HStack(spacing: 16){
                VStack(alignment: .leading, spacing: 5) {
            
                    HStack(spacing:0) {
                       
                        
                        Text(currentUser?.firstname ?? "umm")
                            .bold()
                            .font(.title)
                        
                    }
                    
                    VStack {
                        
                        
                        
                        VStack {
                            HStack(spacing: 2.0) {
                                Image(systemName: "bell")
                                    .opacity(0.67)
                              Text("You have \(currentUser?.notifications ?? "0" ) notifications!")
                                    .opacity(0.67)
                                    .lineLimit(1)
                            }
                        }
                    }.font(.subheadline)
                }
                
                
                
                Spacer()
                GetImageAndUrl(url:"", loaded: .constant(true), imageUrl: .constant(""))
                // .resizable()
                // .aspectRatio(contentMode: .fill)
                //  ImageViewer(url: currentUser?.avatar ?? "")
                    .clipShape(Circle())
                    .frame(width: 70, height: 70)
                
                    .background(
                        Circle()
                            .fill(Color("offWhite"))
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(Circle().fill(LinearGradient(Color("black"), Color.clear)))
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color("offWhite"), lineWidth: 8)
                                    .blur(radius: 4)
                                    .offset(x: -2, y: -2)
                                    .mask(Circle().fill(LinearGradient(Color.clear, Color("black"))))
                            )
                            .padding(-1.3)
                    )
            }
            
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    .background(Color("offwhite"))
             
                
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color("black"), lineWidth: 1)
                
            )
            .cornerRadius(14)
            .padding(.horizontal,15)
            .padding(.bottom, 5)
          
            
            
            Divider()
            
            typeofprofiles
            
            Divider()
            
            
        }.overlay{
            navigation
                .offset(y:-50)
            
        }
        
    }
    var compatible: some View {
        VStack {
       
                if !filteredProfiles.isEmpty {
                 
                        scrollDetection
                        VStack(spacing: 25.0) {
                            ForEach(filteredProfiles, id: \.id) { user in
                                HomeCard(firstname: user.firstname,avatar: user.avatar,poster: user.images[0]){
                                    //tapp does what?
                                    withAnimation(.spring()) {
                                        showProfile = true
                                        hidemainTab = true
                                    }
                                    profile = user
                                }
                            }


                        }
                        .padding(.bottom,85)

                
                } else {
                    nocards
                }
                
              
          
        }
        
        
        
    }
    var filteredProfiles: [UserStruct] {
        guard let currentUser = currentUser
        else {
            return profiles
        }
        let matchingEmails = Set(currentUser.matches)
        return profiles.filter { !matchingEmails.contains($0.email) }
    }
    var active: some View {
        ZStack {
            
            if !filteredProfiles.isEmpty {
                
                scrollDetection
                VStack(spacing: 25.0) {
                    ForEach(filteredProfiles, id: \.id) { user in
                        HomeCard(firstname: user.firstname,avatar: user.avatar,poster: user.images[0]){
                            //tapp does what?
                            withAnimation(.spring()) {
                                showProfile = true
                            }
                            profile = user
                        }
                    }
                    
                    
                }.padding(.top,20)
                    .padding(.bottom,85)
                
                
            } else {
                nocards
            }
        }.onAppear{
            
        }
    }
    
    var near : some View {
        ZStack {
          
            if !filteredProfiles.isEmpty {
                
                scrollDetection
                VStack(spacing: 25.0) {
                    ForEach(filteredProfiles, id: \.id) { user in
                        HomeCard(firstname: user.firstname,avatar: user.avatar,poster: user.images[0]){
                            //tapp does what?
                            withAnimation(.spring()) {
                                showProfile = true
                            }
                            profile = user
                        }
                    }
                    
                    
                }.padding(.top,20)
                .padding(.bottom,85)
                
                
            } else {
                nocards
            }
        }.onAppear{
            
        }
    }
    var newhere : some View {
        ZStack {
            
            if !filteredProfiles.isEmpty {
                
                scrollDetection
                VStack(spacing: 25.0) {
                    ForEach(filteredProfiles, id: \.id) { user in
                        HomeCard(firstname: user.firstname,avatar: user.avatar,poster: user.images[0]){
                            //tapp does what?
                            withAnimation(.spring()) {
                                showProfile = true
                            }
                            profile = user
                        }
                    }
                    
                    
                }.padding(.top,20)
                    .padding(.bottom,85)
                
                
            } else {
                nocards
            }
        }.onAppear{
            
        }
    }
    var nocards: some View {
        VStack {
            VStack {
                LottieView(filename: "loveflying" ,loop: true)
                    .frame(width: 100)
                    .opacity(pageAppeared ? 1 : 0)
                
            }.offset( x:-40, y:280)
                .opacity(0.7)
            
            VStack {
                LottieView(filename: "girllikingstuff" ,loop: true)
                    .frame(width: 280)
                    .opacity(pageAppeared ? 1 : 0)
                
            }
            
            VStack(alignment: .center, spacing: 20.0) {
                
                Text("Opps! No profiles yet")
                    .font(.headline)
                Text("Nothing to seee here. Matches are more intentional on Soulmate so don't worry, They'll come in very soon.")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,25)
                HStack {
                    Text(profiletype == 0 ? "Try adjusting preferences" : profiletype == 1 ? "Nobody is active atm :(" : profiletype == 2 ? "Try adjusting preferences" : "Boost profile to be first to see new people!")
                        .font(.body)
                        .fontWeight(.semibold)
                }.padding(.horizontal,15)
                    .padding(.vertical,10)
                    .background(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
                    .cornerRadius(30)
            }.padding(10)
                .opacity(pageAppeared ? 1 : 0)
        }.offset(y:-210)
    }
    var navigation: some View {
        HStack {
            NavigationBar( title: "Soulmate",
                           contentHasScrolled: $contentHasScrolled)
            .overlay {
                if !showProfile {
                    VStack{
                        HStack{
                            Spacer()
                            VStack {
                                Image(systemName: profiletype == 0 ? "figure.2.arms.open" : profiletype == 1 ? "figure.cooldown" : profiletype == 2 ? "figure.stand.line.dotted.figure.stand" : profiletype == 3 ? "person.fill.badge.plus" : "person.fill.badge.plus")
                                    .font(.system(size:  17, weight: .bold))
                                    .frame(width: 36, height: 36)
                                    .foregroundColor( .secondary)
                                    .background( Color("offwhite"))
                                    .cornerRadius(30)
                                    .scaleEffect( 1)
                                    .overlay(
                                        VStack{
                                            
                                            Text(currentUser?.notifications ?? "0")
                                                .foregroundColor(.white)
                                                .font(.caption)
                                                .padding(2)
                                                .background(
                                                    Circle()
                                                    
                                                        .fill(.red)
                                                        .padding(-3)
                                                )
                                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                                .offset(x:6, y: -5)
                                            
                                        }.opacity(profiletype == 0 ? 1:0)
                                    )
                                
                            }
                        }.padding(.top,12)
                            .padding(.horizontal,26)
                        Spacer()
                    }
                }
            }
        }
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
            
            
            
            
            
            
            
            
            
        }.padding(.horizontal)
            .padding(.vertical,5)
       
            .cornerRadius(10)
            .padding(.horizontal)
          
        
    }
    var scrollDetection: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
            
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { offset in
            
            withAnimation(.easeInOut) {
                userScrolledAmount = Int(offset)
            }
        }
        .onChange(of: userScrolledAmount) { newValue in
            
            
            withAnimation(.spring()) {
              
            }
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                withAnimation(.spring()) {
                    
                }
            }
            
            
            
            
        }
    }
    
    
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        ViewController()
        
        
    }
}

