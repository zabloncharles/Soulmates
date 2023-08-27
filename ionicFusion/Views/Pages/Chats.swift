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
import Firebase
import FirebaseFirestore
import FirebaseAuth

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
            NavigationView  {
                VStack {
                    ScrollView(showsIndicators: false) {
                        cover
                        
                        
                        
                    }
                    .coordinateSpace(name: "scroll")
                    .background(BackgroundView())
                    .mask(RoundedRectangle(cornerRadius: appear[0] ? 0 : 30))
                    .mask(RoundedRectangle(cornerRadius: viewState.width / 3))
                    .scaleEffect(-viewState.width/500 + 1)
                    .gesture(isAnimated ? drag : nil)
                    .ignoresSafeArea()}
                
                
            }
            if showProfile {
                ViewProfileView(namespace: namespace, profile: profile, dislike: $showProfile, scrolling: $showProfile)
                // .matchedGeometryEffect(id: profile.avatar, in: namespace)
                
                
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
        .zIndex(1)
        
    }
    
    var cover: some View {
        VStack {
            GeometryReader { proxy in
                let scrollY = proxy.frame(in: .named("scroll")).minY
                
                VStack {
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height:220)
                
                //                .background(
                //                   // Image(course.background)
                //                  //  Image(wallpaper)
                //                   Rectangle()
                //                    .fill(Color("offwhiteneo"))
                //
                //                      //  .resizable()
                //                      //  .aspectRatio(contentMode: .fill)
                //
                //  .offset(y: scrollY > 0 ? -scrollY : 0)
                //                        .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                //                        .blur(radius: scrollY > 0 ? scrollY / 10 : 0)
                //                        .accessibility(hidden: true)
                //
                //                )
                .mask(
                    RoundedRectangle(cornerRadius: 0)
                    
                    // .offset(y: scrollY > 0 ? -scrollY : 0)
                )
                
                .overlay(
                    VStack(alignment: .trailing, spacing: 8) {
                        HStack {
                            HStack {
                                Image(systemName: "fleuron")
                                   
                                Text(texter.isEmpty ? "Messages" : texter)
                                
                            }.font(.title3)
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
                            .offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 15, action:  .constant(false))
                        
                        
                        
                        Text("By default, Fusion alerts you whenever someone, or extension wants to send you notifications. You can change this setting at any time.")
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(Color("black"))
                            .padding(.horizontal,10)
                            .padding(.top,10)
                        
                        
                        
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
                        .offset(y: 15)
                        .padding(20)
                )
            }
            .frame(height: 150)
            .offset(y: pageAppeared ?  0 : -120)
            
            //if  {
                sectionsSection
                    .offset(y: pageAppeared ?  0 : 520)
                    .opacity(pageAppeared ?  1 : 0 )
                .padding(.bottom, 30)
          //  } else {
                
          //  }
            
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
        .padding(20)
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
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged { value in
                guard value.translation.width > 0 else { return }
                
                if value.startLocation.x < 100 {
                    withAnimation {
                        viewState = value.translation
                    }
                }
                
                if viewState.width > 120 {
                    close()
                }
            }
            .onEnded { value in
                if viewState.width > 80 {
                    close()
                } else {
                    withAnimation(.openCard) {
                        viewState = .zero
                    }
                }
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

struct NotificationsDetail_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        ViewController()
    }
}


