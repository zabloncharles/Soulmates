//
//  LikesView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/14/23.
//

import SwiftUI

struct LikesView: View {
    @AppStorage("hidemainTab") var hidemainTab = false
    @State var pageAppeared = false
    @State var profiles: [UserStruct] = compatibleFakeUsers
    @Binding var currentUser: UserStruct?
    @State var profile = userStruct[0]
    @State var userScrolledAmount = 0
    @Namespace var namespace
    @State  var showProfile = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            //hearts animation
            maintabanimationhearts
            
            //girllottie aniamtion
            // girlanimation
            
            //No Likes Yet
            
            // nolikes
           // likes2
            likes
            //topbartitle
            // topbar
            stories
          showprofile
        }
        
    }
    var showprofile: some View {
        ZStack {
            if showProfile {
                BoneProfile(currentUser: $currentUser, profile: profile, showProfile: $showProfile)
                  //  .background(Color("offwhite"))
                    .background(.ultraThinMaterial)
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
            .opacity(pageAppeared ? 1 : 0)
        
    }
    var likes: some View {
        VStack {
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
                            showProfile = true
                            profile = user
                        }
                    }
                    
                    
                }
                
                .padding(.horizontal,0)
                
            }
        }.padding(.top,90)
            .offset(y:30)
            .padding(.bottom,0)
        
        
    }
  

    var postcard: some View {
        HStack {
            VStack(spacing: 15.0){
                VStack {
                    Image(systemName: "heart.fill")
                        .font(.title)
                        .foregroundColor(.red)
                    Text("734")
                        .fontWeight(.semibold)
                }
                Image(systemName: "paperplane")
                    .font(.title)
                Image(systemName: "bookmark")
                    .font(.title)
                Spacer()
            }.padding()
            
            
            //The image is this
            ZStack {
                Image("image_01")
                    .resizable()
                    .frame(width: 340, height: 500)
                    .cornerRadius(34)
                    .padding(.horizontal,0)
                    .padding(.trailing,5)
                
                
                //Bottom card avatar and quote
                VStack {
                    Spacer()
                    HStack {
                        Image("image_05")
                            .resizable()
                            .frame(width: 60,height: 60)
                            .cornerRadius(60)
                        
                        HStack {
                            Text("Michelle:")
                                .font(.headline)
                            +
                            Text(" California weather is the best weather period")
                                .font(.subheadline)
                            
                        }.lineLimit(2)
                    }
                    .padding(5)
                    .padding(.trailing,15)
                    .background(Color("offwhite"))
                    .cornerRadius(45)
                    .padding()
                }
            }.neoButton(isToggle: false) {
                //code here
            }
        }//the whole two crds right and left individual
        .frame(height: 500)
    }
    var stories : some View {
        VStack {
            
            //the stories
            
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
                        
                        Text("Start Matching")
                            .font(.footnote)
                            .lineLimit(1)
                    }
                    ForEach(0 ..< 15) { item in
                        VStack {
                            
                            Image("image_02")
                                .resizable()
                                .frame(width: 70,height: 70)
                                .cornerRadius(60)
                            
                            Text("grandpa")
                                .font(.footnote)
                                .lineLimit(1)
                        }
                    }
                }
                
                .padding(.top,20)
                .padding(.bottom,10)
                .offset(x:10)
                
            }
           // .background(LinearGradient(colors: [Color("white"),Color("white"),Color.clear], startPoint: .top, endPoint: .bottom))
          //  .background(Color("offwhite").opacity(0.50))
          //  .background( .ultraThinMaterial.opacity(userScrolledAmount < 35 ? 1 : 0.0))
           // .background(Color("white"))
            
            
            
            Spacer()
        }
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
