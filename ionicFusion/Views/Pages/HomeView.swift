//
//  HomeView.swift
//  iOS15
//
//  Created by Zablon Charles on 2021-06-22.


import SwiftUI
import Lottie
import FirebaseFirestore
import Firebase
struct HomeView: View {
    @State var profiles: [UserStruct] = compatibleFakeUsers// Array to hold the user data
    @Binding var currentUser: UserStruct?// Variable to hold the user data
    @State var profile = userStruct[0]
    @Namespace var namespace
    @State var clockisTapped = false
    @State var cycleChangeSoon = false
    @AppStorage("signInAnimation") var signInAnimation = false
    @AppStorage("hidemainTab") var hidemainTab = false
    @State private var offset = CGSize.zero
    @State var hideCard = false
    @State var contentHasScrolled = false
    @State var pageAppeared = false
    @State var showProfile = false
    @State var nomorecards = false
    @State var profiletype = 0
    @State var number = matchCardData.count
    @State var backViewSize: CGFloat = 80
    @State var profileScrolledAmount = 0
    @State var dragsize = CGSize.zero
    @State var menupressed = false
    @State var differentpage = false
    @State var slidecardsfromright = false
    @State var dislike = false
    
    
    var body: some View {
        
            ZStack {
                
                BackgroundView()
              //  ScrollView {
                       
                 
                VStack {
                    
                    welcoming
                        .opacity(showProfile || !pageAppeared ? 0 : 1)
                        .animation(.spring(), value: showProfile)
                        .padding(.top,70)
                    
                    
                    TabView(selection: $profiletype){
                        
                        
                        
                       
                            compatible
                                .tag(0)
                        
                      
                            
                            active
                                .tag(1)
                        
                        
                            
                            near
                                .tag(2)
                        
                       
                            
                            newhere
                                .tag(3)
                       
                        Spacer()
                        
                    }.edgesIgnoringSafeArea(.bottom)
                    
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            
                    
                                
                 
                
                
                if showProfile {
                    ViewProfileView(namespace: namespace, profile: profile, dislike: $showProfile, scrolling: $showProfile)
                      //  .matchedGeometryEffect(id: "page", in: namespace, isSource: showProfile)
                   
                 
                }
                

                
               
                
                
          //  }
                
                navigation
                    .offset(y:!pageAppeared ? -200 : 0)
                    .animation(.spring(), value: showProfile)
                    .opacity(showProfile ? 0 : 1)
                
                
                
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
                                          
                                                Text("4")
                                                    .foregroundColor(.white)
                                                    .font(.caption)
                                                    .padding(2)
                                                    .background(
                                                        Circle()
                                                        
                                                            .fill(.red)
                                                            .padding(-3)
                                                    )
                                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                            
                                        }
                                    )
                                  
                            }
                        }.padding(.top,15)
                            .padding(.horizontal,25)
                        Spacer()
                    }
                }
                
                
            }.onAppear{
                getfakeCurrentUser()
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
    
    var compatible: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 25.0) {
                    ForEach(Array(profiles.enumerated()), id: \.element.id) { index, user in
                        CompatibleCard(completion: {
                            showProfile = true
                            profile = user
                        }, user: user)
                    }

                    
                }
                
                .padding(.horizontal)
                
            }
        }.offset(y:-50)
    }
    var active: some View {
        ZStack {
            ScrollView {
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing:20) {
                    ForEach(Array(profiles.enumerated()), id: \.element.id) { index, user in
                        ActiveCard(completion: {
                            showProfile = true
                            profile = user
                        }, user: user)
                    }
                }.padding(.bottom,90)
                    .padding(.top,24)
                    .padding(.horizontal,5)
            }
            
            VStack {
                Spacer()
                Rectangle()
                    .fill(LinearGradient(colors: [Color("offwhiteneo"), Color.clear], startPoint: .bottom, endPoint: .top))
                    .frame(height: 120)
                    .padding(.top,0)
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
  
    var near : some View {
        ZStack {
            ScrollView {
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing:20) {
                    ForEach(Array(profiles.enumerated()), id: \.element.id) { index, user in
                        ActiveCard(completion: {
                            showProfile = true
                            profile = user
                        }, user: user)
                    }
                }.padding(.bottom,90)
                    .padding(.top,24)
                    .padding(.horizontal,5)
            }
            
            VStack {
                Spacer()
                Rectangle()
                    .fill(LinearGradient(colors: [Color("offwhiteneo"), Color.clear], startPoint: .bottom, endPoint: .top))
                    .frame(height: 120)
                    .padding(.top,0)
            }.edgesIgnoringSafeArea(.bottom)
        }.onAppear{
            
        }
    }
    var newhere : some View {
        ZStack {
            ScrollView {
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing:20) {
                    ForEach(Array(profiles.enumerated()), id: \.element.id) { index, data in
                        ActiveCard(completion: {
                            showProfile = true
                            profile = data
                        }, user: data)
                    }
                }.padding(.bottom,90)
                    .padding(.top,24)
                    .padding(.horizontal,5)
            }
            
            VStack {
                Spacer()
                Rectangle()
                    .fill(LinearGradient(colors: [Color("offwhiteneo"), Color.clear], startPoint: .bottom, endPoint: .top))
                    .frame(height: 120)
                    .padding(.top,0)
            }.edgesIgnoringSafeArea(.bottom)
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
                Text("Nothing to seee here. Likes are more intentional on Soulmate so don't worry, They'll come in very soon.")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,25)
                HStack {
                    Text("Try boosting your profile")
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
        NavigationBar( title: "Soulmate",
                       contentHasScrolled: $contentHasScrolled)
    }
    
 
    var welcoming : some View {
        
        VStack {
           
            HStack(spacing: 16){
                VStack(alignment: .leading, spacing: 5) {
                    
                   
                    TextWriterAppear(typeText: "Welcome back \(currentUser?.firstname ?? "umm...")", speed: 0.03)
                        .font(.title3)
                    
                    VStack {
                       
                            
                            
                            VStack {
                                TextWriterAppear(typeText: "You have 4 matches today :)", speed: 0.03)
                            }
                    }.font(.subheadline)
                }
                
                
                
                Spacer()
                Image("Avatar 3")
                   .resizable()
                   .aspectRatio(contentMode: .fill)
              //  ImageViewer(url: currentUser?.avatar ?? "")
                    .clipShape(Circle())
                    .frame(width: 70, height: 70)
                    .overlay(
                        VStack {
                            //days left
                            Text("5")
                                .font(.subheadline)
                            //Text(Int(data()[3]) ?? 0 < 1 ? "Day" :"Days")
                            Text("Matches")
                                .font(.caption2)
                                .fontWeight(.light)
                                .foregroundColor(.primary)
                        }
                    )
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
            .background(Color("offwhite"))
            .cornerRadius(11)
            .neoButton(isToggle: false, perform: {
                //do something
            })
            .padding(.horizontal,20)
            .padding(.bottom, 5)
          
           
            
            typeofprofiles
                
            
            
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
            .background(Color("offwhite"))
            .cornerRadius(12)
            .padding(.horizontal)
            .padding(.top,10)
         
    }
    
    func getfakeCurrentUser(){
        currentUser = fakeUser
    }
  
//    private func fetchUsers() {
//        let db = Firestore.firestore()
//        let user = Auth.auth().currentUser
//        let usersRef = db.collection("users").whereField("email", isNotEqualTo: user?.email ?? "")
//
//        usersRef.getDocuments { (querySnapshot, error) in
//            if let error = error {
//                print("Error fetching users: \(error.localizedDescription)")
//                return
//            }
//
//            guard let documents = querySnapshot?.documents else {
//                print("No documents found.")
//                return
//            }
//
//            let users = documents.compactMap { document in
//                let documentData = document.data()
//
//                return UserStruct(
//                    firstname: documentData["firstname"] as? String ?? "",
//                    lastname: documentData["lastname"] as? String ?? "",
//                    notifications: documentData["notifications"] as? String ?? "",
//                    avatar: documentData["avatar"] as? String ?? "",
//                    cyclechange: documentData["cyclechange"] as? String ?? "",
//                    birthday: documentData["birthday"] as? String ?? "",
//                    email: documentData["email"] as? String ?? "",
//                    aboutme: documentData["aboutme"] as? String ?? "",
//                    education: documentData["education"] as? String ?? "",
//                    work: documentData["work"] as? String ?? "",
//                    images: documentData["images"] as? [String] ?? [],
//                    likes: documentData["likes"] as? [String] ?? [],
//                    location: documentData["location"] as? [String] ?? [],
//                    lookingfor: documentData["lookingfor"] as? String ?? "",
//                    online: documentData["online"] as? Bool ?? false,
//                    password: documentData["password"] as? String ?? "",
//                    matches: documentData["matches"] as? Int ?? 0,
//                    age: documentData["age"] as? String ?? "", lifestyle: documentData["lifestyle"] as? [String] ?? [],
//                    lifestyledesc: documentData["lifestyledesc"] as? String ?? ""
//                )
//            }
//
//            self.profiles = users
//        }
//    }
 
    
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        ViewController()
        
        
    }
}


struct TypeofMenuRow:  View {
    @Binding var tap : Int
    var selected = 0
    var placeholder = "name?"
    let completion: () -> Void
    
    
    var body: some View {
        VStack {
            ZStack {
                if tap == selected  {
                    VStack {
                        Text(placeholder)
                            .font(.footnote)
                            .padding(.vertical,5)
                            .padding(.horizontal,8)
                            .foregroundColor(.red)
                            .background(Color("offwhite"))
                            .cornerRadius(10)
                       
                    
                    }
                }
                
               else {
                   Text(placeholder)
                       .font(.footnote)
                    .padding(.vertical,5)
                    .padding(.horizontal,8)
                   
                  
                }
            }
            .onTapGesture {
                completion()
                
                withAnimation(.spring()){
                    tap = selected
                }
            }
            
         
         
           
        }
        
       
    }
  
}
