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


struct NotificationsDetail: View {
    @State var profiles: [UserStruct] = compatibleFakeUsers// Array to hold the user data
    @State var profile = userStruct[0]
    @State var currentUser: UserStruct? = fakeUser
    @AppStorage("hidemainTab") var hidemainTab = false
    @AppStorage("wallpaper") var wallpaper = "ob1"
    var namespace: Namespace.ID
    var isAnimated = true
    @State var viewState: CGSize = .zero
    @State var showSection = false
    @State var showProfile = false
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
                        cover
                        
                        
                        
                    }
                    .coordinateSpace(name: "scroll")
                    .background(BackgroundView())
                  
                }
                
                
            
            if showProfile {
               
                    
                
                
            }
            
        }.onAppear{
            hidemainTab = false
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
    
    var cover: some View {
        VStack {
            GeometryReader { proxy in
                let scrollY = proxy.frame(in: .named("scroll")).minY
                
                VStack {
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height:50)
            
              
                
                .overlay(
                    VStack(alignment: .trailing, spacing: 8) {
                        HStack {
                            HStack {
                                Text(texter.isEmpty ? "Messages" : texter)
//                                Image(systemName: "fleuron")
                                   
                               
                                
                            }.font(.title)
                                .fontWeight(.bold)
                            Spacer()
                            HStack {
                                Image(systemName: profiles.count > 0 ? "bell.badge.fill" : "bell")
                                
                                
                                //number of messages
                                Text("\(filteredProfiles.count)")
                            }.padding(.horizontal,12)
                                .padding(.vertical,5)
                                .background(Color.blue.opacity(0.3))
                                .cornerRadius(20)
                            
                        }.padding(15)
//                            .offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 15, action:  .constant(false))
                        
                        
                        
                       
                        
                        
                        
                        Divider()
                            .foregroundColor(.secondary)
                            .opacity(0.9)
                        
                        
                            .accessibilityElement(children: .combine)
                    }
                    
                        .background(
                            Rectangle()
                                .fill(Color("offWhite"))
                                .opacity(appear[0] ? 1 : 0)
                        )
                    
                    // .offset(y:scrollY > 0 ? -scrollY  : scrollY)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        
                        .padding(10)
                )
            }
            .frame(height: 10)
            .offset(y: pageAppeared ?  0 : -150)
            
           
                sectionsSection
                    .offset(y: pageAppeared ?  0 : 520)
                    .opacity(pageAppeared ?  1 : 0 )
                .padding(.bottom, 30)
         
            
        }.onAppear{
            // fetchIncomingMessages()
            fetchFakeMessages()
        }
    }
    
    
    var sectionsSection: some View {
        
        VStack(spacing: 10) {
            if !filteredProfiles.isEmpty {
                ForEach(filteredProfiles, id: \.id) { user in

                    NavigationLink(destination:
                                    MessageDetailView(log: user)
                    ) {
                        MessageCard(section: user, profile: $profile, showProfile: $showProfile)
                        
                    }
                }
            } else {
                nomessages
            }
           

        }
        .padding(.horizontal,10)
        .padding(.vertical, 60)
        
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
        let matchingEmails = Set(currentUser.matches)
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
    
    //    func fetchIncomingMessages() {
    //        let user = Auth.auth().currentUser
    //        let db = Firestore.firestore()
    //
    //        db.collection("messages").getDocuments { snapshot, error in
    //            if let error = error {
    //                // Handle the error
    //                print("Error fetching messages: \(error.localizedDescription)")
    //                return
    //            }
    //
    //            guard let documents = snapshot?.documents else {
    //                // Handle no documents found
    //                return
    //            }
    //
    //            var emailu = documents.compactMap { $0.data()["email"] as? [String] }
    //                .filter { $0.contains(user?.email ?? "") }
    //                .flatMap { $0 }
    //
    //            let newEmail = emailu
    //                .filter { $0 != user?.email }
    //
    //            db.collection("users").whereField("email", in: newEmail).getDocuments { snapshot, error in
    //                if let error = error {
    //                    // Handle the error
    //                    print("Error fetching users: \(error.localizedDescription)")
    //                    return
    //                }
    //
    //                guard let documents = snapshot?.documents else {
    //                    // Handle no documents found
    //                    return
    //                }
    //
    //
    //                self.someUsers = documents.compactMap { document in
    //                    let data = document.data()
    //                    let docid = document.documentID
    //                    let firstname = data["firstname"] as? String ?? ""
    //                    return SomeUsers(name: firstname, docid: docid)
    //                }
    //            }
    //        }
    //    }
    
    
}



