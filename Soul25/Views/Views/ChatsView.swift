//
//  ChatsView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/20/23.
//

//
//  Walls.swift
//  Fusion
//
//  Created by Zablon Charles on 2/20/22.
//

import SwiftUI


struct ChatsView: View {
    @State var profiles: [UserStruct] = fakeUsers// Array to hold the user data
    @State var profile = fakeUsers[0]
    @State var currentUser: UserStruct? = fakeUser
    @State var userScrolledAmount : CGFloat = 0
    @AppStorage("hidemainTab") var hidemainTab = false
    var isAnimated = true
    @State var viewState: CGSize = .zero
    @State var showMessages = false
    @State var showProfile = false
    @State var userAvatarsLoaded = false
    @State var appear = [false, false, false]
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var pageAppeared = false
    @State private var chatMessages: [MessageModel] = []
    @State var currentViewed = ""
    @State var texter = ""
    
    
    //  @State var fakeincomingMessages = IncomingMessage(name: "", text: "", timestamp: "")
    
    var body: some View {
        ZStack {
                VStack {
                    ScrollView(showsIndicators: false) {
                        ScrollDetectionView(userScrolledAmount: $userScrolledAmount)
                        navandmessages
                    }
                    .coordinateSpace(name: "scroll")
                    .background(BackgroundView())
                  
                }
                
            if !showMessages {
                gettingmessages
                    .transition(.opacity)
            }
        }.onAppear{
            hidemainTab = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.spring()){
                        if userAvatarsLoaded {
                            showMessages = true
                        }
                }
                
            }
        }
        .onDisappear{
            withAnimation(.spring()){
                pageAppeared = false
            }
        }
    }
    
    var navandmessages: some View {
        VStack {
  // top nav
            DynamicTopBar()
          
                sectionsSection
                .padding(.bottom, 30)
                .offset(y: !showMessages ? UIScreen.main.bounds.height *  1.02 : 0)
                
        }.onAppear{
            // fetchIncomingMessages()
            fetchFakeMessages()
        }
    }
    
    
    var sectionsSection: some View {
        
        VStack(spacing: 10) {
            if !profiles.isEmpty {
                ForEach(profiles, id: \.id) { user in

                    NavigationLink(destination:
                                    MessageDetailView(log: user)
                    ) {
                        MessageCard(section: user, profile: $profile, showProfile: $showProfile, userAvatarLoaded: $userAvatarsLoaded)
                        
                    }
                }
            } else {
                nomessages
            }
           

        }
        .padding(.horizontal,10)
        .padding(.vertical, 40)
        
    }
    var gettingmessages: some View {
        VStack {
            Spacer()
            VStack(alignment: .center) {
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                   
            }
          
            VStack(alignment: .center, spacing: 20.0) {
                
                Text("Getting your messages")
                    .font(.headline)
                Text("Oops well this is embarrassing. Making sure we have every message, They'll come in very soon.")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,25)
                HStack {
                    Text("Just a second :)")
                        .font(.body)
                        .fontWeight(.semibold)
                }.padding(.horizontal,15)
                    .padding(.vertical,10)
                    .background(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
                    .cornerRadius(30)
            }.padding(10)
                
                .offset(y: showMessages ? UIScreen.main.bounds.height *  1.02 : 0)
            Spacer()
        }
    }
    var nomessages: some View {
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
                    .opacity(pageAppeared ? 1 : 1)
                
            }
            
            VStack(alignment: .center, spacing: 20.0) {
                
                Text("Opps! No messages yet")
                    .font(.headline)
                Text("Nothing to seee here. Messages are more intentional on Soulmate so don't worry, They'll come in very soon.")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,25)
                HStack {
                    Text("Try adjusting preferences")
                        .font(.body)
                        .fontWeight(.semibold)
                }.padding(.horizontal,15)
                    .padding(.vertical,10)
                    .background(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
                    .cornerRadius(30)
            }.padding(10)
                .opacity(pageAppeared ? 1 : 0)
        }.offset(y:150)
    }
    var filteredProfiles: [UserStruct] {
        guard let currentUser = currentUser
        else {
            return profiles
        }
        let matchingEmails = Set(currentUser.matched)
        return profiles.filter { !matchingEmails.contains($0.email) }
    }
    func close() {
        withAnimation {
            viewState = .zero
        }
        
    }
    
  
    
    func fetchFakeMessages() {
       // userMessages = messageContent
    }
   
}



struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
        
        
    }
    }
