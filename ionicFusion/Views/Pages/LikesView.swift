//
//  LikesView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/14/23.
//

import SwiftUI

struct LikesView: View {
    @AppStorage("currentPage") var selected = 0
    @AppStorage("hidemainTab") var hidemainTab = false
    @State var pageAppeared = false
    @State var profiles: [UserStruct] = compatibleFakeUsers
    @Binding var currentUser: UserStruct?
    @State var profile = userStruct[0]
    @State var userScrolledAmount = 0
    @Namespace var namespace
    @State  var showProfile = false
    @State var profileAppeared = false
    
    var body: some View {
        ZStack {
            background
            //hearts animation
            maintabanimationhearts
            
            //girllottie aniamtion
            // girlanimation
            
            //No Likes Yet
            
            // nolikes
           // likes2
            if filteredProfiles.count != 0 {
            likes
            //topbartitle
            // topbar
            stories
            } else {
                topbar
                girlanimation
                nolikes
            }
          showprofile
        }
        
    }
    var background : some View {
        BackgroundView()
    }
    var showprofile: some View {
        ZStack {
            if showProfile {
                BoneProfile(currentUser: $currentUser, profile: profile, showProfile: $showProfile)
                  //  .background(Color("offwhite"))
                    .background(.ultraThinMaterial)
                    .transition(.asymmetric(
                        insertion: .push(from: .bottom),
                        removal: .push(from: .top)))
                    .animation(.spring(), value: showProfile)
                
                 // .offset(y: showProfile ? 0 : -50)
                    .onAppear{
                        profileAppeared = true
                        hidemainTab = true
                    }
                    .onDisappear{
                        profileAppeared = false
                        hidemainTab = false
                    }
            }
        }
    }
    var topbar: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "fleuron")
                    Text("Likes You")
                    
                }.font(.title3)
                    .fontWeight(.bold)
                Spacer()
                HStack {
                    Image(systemName: "fleuron")
                    Text("Boost")
                }.padding(.horizontal,12)
                    .padding(.vertical,5)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(20)
                
            }.padding(15).offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 15, action:  .constant(false))
                .offset(y: pageAppeared ? 0 : -300)
            Spacer()
        }.padding(20)
            .opacity(pageAppeared ? 1 : 0)
            .onAppear{
                hidemainTab = false
                withAnimation(.spring().speed(0.4)){
                    pageAppeared = true
                }
            }
            .onDisappear{
                
                withAnimation(.spring()){
                    pageAppeared = false
                }
            }
    }
    var girlanimation: some View {
        VStack {
            LottieView(filename: "girllikingstuff" ,loop: true)
                .frame(width: 280)
                .opacity(pageAppeared ? 1 : 0)
            
        }.offset(y:-160)
    }
    var maintabanimationhearts: some View{
        VStack {
            LottieView(filename: "loveflying" ,loop: true)
                .frame(width: 100)
                .opacity(pageAppeared ? 1 : 0)
            
        }.offset( x:-40, y:280)
            .opacity(0.7)
    }
    var nolikes: some View {
        VStack(alignment: .center, spacing: 20.0) {
            
            Text("You're new here! No likes yet")
                .font(.headline)
            Text("Likes are more intentional on Soulmate so don't worry, They'll come in very soon.")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            HStack {
                Text("Try boosting your profile")
                    .font(.body)
                    .fontWeight(.semibold)
            }.padding(.horizontal,15)
                .padding(.vertical,10)
                .background(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
                .cornerRadius(30)
        }.padding(20)
           // .opacity(pageAppeared ? 1 : 0)
        
    }
    var likes: some View {
        
           
                VStack {
                    Rectangle()
                        .frame( height: 0.17)
                        .opacity(0.87)
                        .padding(.horizontal,10)
                        .offset(y:10)
                    ScrollView(.vertical, showsIndicators: false) {
                        scrollDetection
                        VStack(spacing: 25.0) {
                            ForEach(filteredProfiles, id: \.id) { user in
        //                        CompatibleCard(completion: {
        //                            showProfile = true
        //                            profile = user
        //                        }, user: user, namespace: namespace)
                                PostCard(firstname: user.firstname,avatar: user.avatar,poster: user.images[0]){
                                    //tapp does what?
                                    withAnimation(.spring()) {
                                        showProfile = true
                                    }
                                    profile = user
                                }
                            }
                            
                            
                        } .padding(.bottom,115)
                        
                        .padding(.horizontal,0)
                        
                    }
                }.padding(.top,90)
                    .offset(y:30)
                    .padding(.bottom,0)
                    .offset(y: showProfile ? -30 : 0)
                   
                .animation(.spring(), value: showProfile)
            
        
        
        
    }
  
    var stories : some View {
      
            
           
        
        VStack {
            ScrollView(.horizontal,showsIndicators: false){
                        HStack(spacing: 15.0){
                            VStack {
                                
                                Circle()
                                
                                    .fill(.angularGradient(colors: [.purple, .orange, .purple], center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
                                
                                    .overlay(
                                        Image(systemName: "plus")
                                            .font(.headline)
                                            .foregroundColor(Color("black"))
                                    )
                                    .frame(width: 70,height: 70)
                                    .cornerRadius(60)
                                    .neoButton(isToggle: false) {
                                        //Start matching
                                        selected = 0
                                    }
                                
                                Text("Start Matching")
                                    .font(.footnote)
                                    .lineLimit(1)
                                    
                            }
                            ForEach(filteredProfiles, id: \.id) { user in
                                VStack {
                                    
                                    GetImageViewer(url:user.avatar)
                                        .frame(width: 70,height: 70)
                                        .cornerRadius(60)
                                        .overlay (
                                            ZStack {
                                                
                                                CircularView(value: Double(99.9) / 100.0,lineWidth: 1.0,colors: [Color("black")])
                                                    .padding(-1)
                                                
                                                
                                                //This one shows the percentage of match
                                                CircularView(value: Double(56.9) / 100.0,lineWidth: 1.0,colors: [Color.green.opacity(0.67),Color.green])
                                                    .padding(-1)
                                                
                                                
                                            }
                                        )
                                        .neoButton(isToggle: false) {
                                            //when a story is clicked
                                            showProfile = true
                                            profile = user
                                        }
                                    
                                    Text(user.firstname)
                                        .font(.footnote)
                                        .lineLimit(1)
                                }
                            }
                        }
                        
                        .padding(.top,20)
                        .padding(.bottom,10)
                        .offset(x:10)
                        
                        
                        // .background(LinearGradient(colors: [Color("white"),Color("white"),Color.clear], startPoint: .top, endPoint: .bottom))
                        //  .background(Color("offwhite").opacity(0.50))
                        //  .background( .ultraThinMaterial.opacity(userScrolledAmount < 35 ? 1 : 0.0))
                        // .background(Color("white"))
                        
                        
                        
                       
            }
            Spacer()
        }.animation(.easeOut, value: showProfile)
            .opacity(showProfile ? 0 : 1)
           // .offset(y: showProfile ? -60 : 0)
                
            
        
    }
    var filteredProfiles: [UserStruct] {
        guard let currentUser = currentUser
        else {
            return profiles
        }
        let matchingEmails = Set(currentUser.matches)
        return profiles.filter { matchingEmails.contains($0.email) }
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
            
            
//            withAnimation(.spring()) {
//                hidemainTab = true
//            }
//            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
//                withAnimation(.spring()) {
//                    hidemainTab = false
//                }
//            }
            
            
            
            
        }
    }
}

struct LikesView_Previews: PreviewProvider {
    static var previews: some View {
        // LikesView( currentUser: .constant(fakeUser))
        ViewController()
            .preferredColorScheme(.dark)
    }
}
