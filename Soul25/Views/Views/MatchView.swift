//
//  ShuffleMatchView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/22/23.
//


import SwiftUI


struct MatchView: View {
    @AppStorage("hidemainTab") var hidemainTab = false
    @AppStorage("currentPage") var selected = 0
    @State var profiles: [UserStruct] = []
    @Binding var currentUser: UserStruct?
    @State var profile = fakeUsers[0]
    @State var viewState: CGSize = .zero
    @State var pageAppeared = false
    @State var showProfile = true
    @State var noprofiles = false
    @FocusState var sendMessageFocused: Bool
    @State var text = ""
    @State var profilesFetched = 0
    @State var sendMessage = ""
    @State var typeText = ""
    @State var dislike = false
    @State var animateapper = false
    @State var outOfMatches = false
    @State var liked = false
    @State var profileImages = ["","",""]
    @State var likedImage = ""
 
    @State var profileNumber = 0
    
    @State private var cards: [String] = ["Red", "Blue", "Green"]
    @State private var colors: [Color] = [.red, .blue, .green]
    @State private var currentIndex: Int = 0
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            LogoLoadingView()
            //the whole page
            if currentIndex != profiles.count {
                ZStack {
                  
                        ForEach(profiles.indices, id: \.self) { index in
                            SkullProfile(currentUser: $currentUser, profile:  profiles[index], showProfile: .constant(true),currentIndex: $currentIndex)
                               // .cornerRadius(23)
                               
                                .zIndex(Double(index))
                                .offset(y: index == currentIndex ? 0 : index == currentIndex - 1 ? -5 : UIScreen.main.bounds.height * 1.02)
                                
                                .cornerRadius(index == currentIndex - 1 ? 45 : 45)
                                .scaleEffect(index == currentIndex - 1 ? 0.90 : 1)
                            
                                .edgesIgnoringSafeArea(.all)
                               
//                            adjust speed of a new profile showing up
                                .animation(.spring().speed(0.55), value: currentIndex)
//                                .overlay(Text("\(profiles.count)"))
                        }
                }
            }
        } .onAppear {
            // Fetch user data when the view appears
            fetchUserData(parameter: "") { result in
                
                    profiles += result ?? [fakeUser]
                
            }
            noProfilesFunc()
            
        }
      
    }
    

    var outofmatchesView: some View {
        ZStack {
            
            VStack {
                LottieView(filename: "loveflying" ,loop: true)
                    .frame(width: 100)
                    .opacity(pageAppeared ? 1 : 0)
                
            }.offset( x:-40, y:280)
                .opacity(0.7)
            
            VStack {
                LottieView(filename: "sadheart" ,loop: true)
                    .frame(width: 280)
                    .opacity(pageAppeared ? 1 : 0)
                
            }.offset(y:-160)
            
            
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "figure.wave")
                        Text("No More Profiles!")
                        
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
                
                VStack(alignment: .center, spacing: 20.0) {
                    
                    Text("Come back later or adjust your preferences")
                        .font(.headline)
                    Text("Matches are carefully curated on Soulmate so don't worry, They'll come in very soon.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    HStack {
                        Text("Adjust My Preferences")
                            .font(.body)
                            .fontWeight(.semibold)
                    }.padding(.horizontal,15)
                        .padding(.vertical,10)
                        .background(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
                        .cornerRadius(30)
                        .neoButton(isToggle: false) {
                            //code
                            selected = 4
                        }
                }.padding(10)
                    .opacity(pageAppeared ? 1 : 0)
                
                
                
                Spacer()
            }.padding(20)
        }.background(appbackground)
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
   
    var randomProfiles: [UserStruct] {
        guard let currentUser = currentUser else {
            return [] // No current user, return an empty array
        }
        let matchingEmails = Set(currentUser.matched)
        let filteredProfiles = profiles.filter { !matchingEmails.contains($0.email) }
        
        return filteredProfiles
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
                
                if viewState.width > 100 {
                    
                }
            }
            .onEnded { value in
                if viewState.width > 50 {
                    
                } else {
                    withAnimation(.spring()) {
                        viewState = .zero
                    }
                }
            }
    }
    func noProfilesFunc(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            if profiles.isEmpty {
                withAnimation(.spring()){
                    noprofiles = true
                }
            } else {
                withAnimation(.spring()){
                    noprofiles = false
                }
            }
           
        }
    }
    
   
}

