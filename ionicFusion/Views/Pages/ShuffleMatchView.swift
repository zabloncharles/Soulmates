//
//  ShuffleMatchView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/22/23.
//


import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct FullProfileView: View {
    @AppStorage("hidemainTab") var hidemainTab = false
    @AppStorage("currentPage") var selected = 0
    @State var profiles: [UserStruct] = compatibleFakeUsers
    @Binding var currentUser: UserStruct?
    @State var profile = userStruct[0]
    var isAnimated = true
    @State var viewState: CGSize = .zero
    @State var pageAppeared = false
    @State var showProfile = true
    @FocusState var sendMessageFocused: Bool
    @State var text = ""
    @State var erro = ""
    @State var sendMessage = ""
    @State var typeText = ""
    @State var dislike = false
    @State var animateMatchImage = false
    @State var animateapper = false
    @State var profileLoaded = false
    @State var outOfMatches = false
    @State var animategirl = false
    @State var liked = false
    @State var cancelLike = false
    @State var profileImages = ["","",""]
    @State var likedImage = ""
    @State var showMore = false
    @State var slide = false
    @State var godown = false
    @State var scrolledItem = 0
    @State var profileNumber = 0
    
    @State private var cards: [String] = ["Red", "Blue", "Green"]
    @State private var colors: [Color] = [.red, .blue, .green]
    @State private var currentIndex: Int = 0
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        
        ZStack {
            
            appbackground
            // .offset(y: CGFloat(scrolledItem) / 3)
          
            
            VStack {
               if !outOfMatches && dislike {
               
                   VStack {
                       LottieView(filename: "earth",loop:true)
                           .colorMultiply(.pink)
                           .frame(width: 450, height: 450)
                       
                       
                       
                           .neoButton(isToggle: false, perform: {
                               //
                           })
                           .onAppear{
                               DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                   
                                   dislike = false
                                   animategirl = false
                                   
                                   
                               }
                           }
                       // .offset(y:-30)
                   }
                   .frame(width: 250, height: 250)
                   
                   
                   .mask(
                    ZStack {
                        Circle()
                        
                    }
                   )
                   .neoButton(isToggle: false, perform: {
                       //code
                   })
                   .overlay(
                    CircleText(radius: 100, text: "Looking for your soulmate...",kerning: 8)
                        .rotationEffect(.degrees(animategirl ? 180 : 0))
                        .scaleEffect(0.70)
                   )
                    .animation(.spring(), value: animategirl)
                    .scaleEffect(animategirl ? 1 : 0.81)
                    //.opacity(0.03)
                    // .background(.ultraThinMaterial)
                    
                    //.offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 20, action: .constant(false))
                    .overlay(
                        VStack{
                            Spacer()
                            VStack(alignment: .leading) {
                               // TextWriterAppear(typeText: "Looking for your soulmate..", speed: 0.02)
                            }
                        }.padding()
                            .offset(y:-20)
                    )
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.spring()) {
                                animategirl = true
                            }
                        }
                    }
                }
            }
            
            
            //the whole page
           // if !outOfMatches && showProfile{
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
                                .transition(.slide)
                                .animation(.spring().speed(0.45), value: currentIndex)
//                                .overlay(Text("\(currentIndex)"))
                        }
                    
                }.onAppear{
                    
                }
                }
            else  {
                outofmatchesView
            }
        }
        
        
        
        
        
        
        
        
        
    }
    var nameandheart: some View{
        VStack {
            HStack {
                HStack {
                    
                    // TextWriterAppear(typeText:profile.firstname)
                    Text(dislike ? "Disliked" : profile.firstname)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    
                } .padding(10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                    .opacity(dislike ? 0 : 1)
                
                Spacer()
                Button {
//                    dislike = true
//                    showProfile = false
//
//                    withAnimation(.spring()) {
//                        slide.toggle()
//                    }
                    withAnimation {
                        if currentIndex != profiles.count - 1 {
                            currentIndex += 1
                        }
                        
                    }
                    
                    // Looks like the count starts at 1 so i minus here to start it from 0
                    if profileNumber > randomProfiles.count - 1{
                        //  profile = userStruct[0]
                        //Blank screen because user is out of matches
                        outOfMatches = true
                    } else {
                        profile = randomProfiles[profileNumber]
                        
                    }
                    withAnimation(.spring()) {
                        
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)  {
                            showProfile = true
                        }
                        
                        liked = false
                        //  unMatch()
                    }
                    
                } label: {
                    if !dislike {
                        Image(systemName: "heart.slash")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                    } else {
                        
                        LottieView(filename: "heartbeat")
                            .frame(width: 99, height: 50)
                            .offset(x:30)
                            .opacity(0.57)
                        
                    }
                    
                    
                }
            }.padding(.horizontal,25)
            Spacer()
        }//.blur(radius: liked ? 50 : 0)
    }
    var cover: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            
            VStack {
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: scrollY > 0 ? 500 + scrollY : 500)
            
            .overlay(
                // Image("image_09")
                //    .resizable()
                //  .aspectRatio(contentMode: .fill)
                VStack{
                    GetImageAlert(url:profile.avatar,loaded: $profileLoaded)
                    //  GetImageAlert(url: "",loaded: .constant(false))
                       // .matchedGeometryEffect(id: profile.avatar, in: namespace)
                        .offset(y: scrollY > 0 ? -scrollY : 0)
                        .scaleEffect(liked ? 1.4 : scrollY > 0 ? scrollY / 1000 + 1 : 1)
                        .blur(radius: liked ? 14 : scrollY > 0 ? scrollY / 10 : 0)
                        .accessibility(hidden: true)
                        .animation(.spring(), value: liked)
                    
                    
                    
                    
                })
            //  .cornerRadius(8)
            
        }
        .frame(height: 400)
    }
    
    var content: some View {
        
        VStack {
            
            
            
            
            VStack(alignment: .leading, spacing: 30.0) {
                
                
                
                VStack(alignment: .leading, spacing: 13.0) {
                    
                    
                    HStack {
                        Text("About Me")
                            .font(.title).bold()
                        
                        
                        Text(profile.age )
                            .font(.title3).bold()
                            .padding(5)
                            .background(Color.orange)
                            .cornerRadius(60)
                    }
                    
                    TextWriterAppear(typeText: profile.aboutme, speed: 0.02)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color("black"))
                    Spacer(minLength: 0.1)
                    
                    
                    HStack(spacing: 3.9){
                        Image(systemName: "graduationcap")
                            .font(.system(size: 18, weight: .medium))
                        
                        
                        TextWriterAppear(typeText: profile.education, speed: 0.02)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                        
                    }.foregroundColor(Color("black"))
                    
                    HStack {
                        Image(systemName: "building")
                            .font(.system(size: 18, weight: .medium))
                        
                        TextWriterAppear(typeText: "Works in \(profile.work)", speed: 0.02)
                        // Text("Works in \(profile.work)")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                    }.foregroundColor(Color("black"))
                    
                    HStack {
                        Image(systemName: "location")
                            .font(.system(size: 18, weight: .medium))
                        
                        
                        HStack {
                            //  DistanceView()
                            TextWriterAppear(typeText: profile.location[0], speed: 0.02)
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .lineLimit(2)
                            
                        }
                        
                    }.foregroundColor(Color("black"))
                }
                .padding(20)
                .background(Color("offwhite"))
                .cornerRadius(19)
                
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 0.1)
                
                VStack(alignment: .leading, spacing: 15.0){
                    
                    HStack {
                        
                        
                        Image(systemName: "hand.thumbsup")
                            .font(.title).bold()
                            .foregroundColor(Color("black"))
                        
                        Text("First Date Idea?")
                            .font(.title2).bold()
                    }
                    Text("What would you like to do with siri on a first date? :)")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                        .foregroundColor(Color("black"))
                    
                    
                    VStack(spacing: 26.0) {
                        HStack {
                            HStack(spacing: 4.0) {
                                Text("Bar")
                                Spacer()
                                
                                Image(systemName: "wineglass")
                                
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                            }
                            
                        }.padding(12)
                            .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 14, action: $liked)
                        
                        HStack {
                            HStack(spacing: 4.0) {
                                
                                Text("Dinner")
                                Spacer()
                                Image(systemName: "fork.knife")
                                
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                            }
                            
                        }.padding(12)
                            .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 14, action: $liked)
                        
                        HStack {
                            HStack(spacing: 4.0) {
                                
                                Text("Other")
                                Spacer()
                                Image(systemName: "eyes.inverse")
                                
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                            }
                            
                        }.padding(12)
                            .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 14, action: $liked)
                    }
                }.padding()
                    .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 18, action: .constant(false))
                
                
                
                
                
                
                ZStack {
                    VStack {
                       // ImageViewer(url: profile.images[0] )
                        GetImageAndUrl(url:profile.images[0], imageUrl: $profileImages[0])
                            .frame(minHeight:  400)
                        
                    }
                    
                }.padding(-20)
                    .padding(.bottom,20)
                    .cornerRadius(13)
                    .neoButton(isToggle: false, perform: {
                        //when first image is clicked
                        liked = true
                        likedImage = profileImages[0]
                        
                    })
                   // .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 14, action: $liked)
                    .overlay(
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Image(systemName: "heart.circle.fill")
                                
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            }.padding(10)
                            
                        }
                    )
                
                
                
                
                
                
                VStack(alignment: .leading, spacing: 15.0){
                    HStack {
                        
                        
                        Image(systemName: "hand.thumbsup")
                            .font(.title).bold()
                        
                        
                        Text("Likes")
                            .font(.title).bold()
                        Spacer()
                    }
                    Text("Fun loving and looking to settle up with this stuff and do me. its really not like that said no one ever.")
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                    
                    
                    
                    HStack {
                        ForEach(profile.likes, id: \.self) { like in
                            LikesPill(placeholder: like)
                        }
                        
                        
                    }
                }.foregroundColor(Color("black"))
                    .padding()
                    .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 18, action: $liked)
                    .padding(.bottom,25)
                
                
                
                ZStack {
                    VStack {
                        // ImageViewer(url: profile.images[0] )
                        GetImageAndUrl(url:profile.images[1], imageUrl: $profileImages[1])
                            .frame(minHeight:  400)
                        
                    }
                    
                }.padding(-20)
                    .padding(.bottom,20)
                    .cornerRadius(13)
                    .neoButton(isToggle: false, perform: {
                        //when first image is clicked
                        liked = true
                        likedImage = profileImages[1]
                        
                    })
                    .overlay(
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Image(systemName: "heart.circle.fill")
                                
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            }.padding(10)
                            
                        }
                    )
                
                
                
                
                VStack(alignment: .leading, spacing: 15.0){
                    HStack {
                        
                        
                        Image(systemName: "teddybear")
                            .font(.title).bold()
                        
                        Text("Lifestyle")
                            .font(.title).bold()
                        
                        Spacer()
                    }
                    
                    Text(profile.lifestyledesc )
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .lineLimit(showMore ? 10 : 3)
                    
                    
                    
                    
                    HStack {
                        ForEach(profile.lifestyle, id: \.self) { like in
                            LikesPill(placeholder: like)
                        }
                        
                        
                    }
                }.foregroundColor(Color("black"))
                    .padding(20)
                
                    .offwhitebutton(isTapped: liked, isToggle: true, cornerRadius: 20, action: $showMore)
                
                    .padding(.bottom,95)
                
                
            }
            
            .padding(.top,-10)
            .padding(10)
            
            
            
            
            
            
        }.padding(.bottom,-70)
        
        
        
        
        
        
        
    }
    var wholepage: some View {
        
            ZStack {
                
                
                ScrollView {
                    
                    cover
                        .background(scrollDetection)
                    //  .offset(y:dislike ? -570 : 0)
                    //  .matchedGeometryEffect(id: "som\(matchcard.usernumber)", in: namespace)
                    
                    content
                        .offset(y: dislike ? 650 : 0)
                    
                    
                }
                .coordinateSpace(name: "scroll")
                .mask(RoundedRectangle(cornerRadius: viewState.width / 3))
                .scaleEffect(-viewState.width/500 + 1)
                .gesture(drag)
                .onAppear{
                    // DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    // withAnimation(.spring()) {
                    //  profile = userStruct.randomElement() ?? userStruct[0]
                    // profile = userStruct[profileNumber]
                    profileNumber = profileNumber + 1
                    // showProfile = true
                    // }
                    // }
                }
                
                
                .ignoresSafeArea()
                
                
                
                
                
                
                //the send text view that comes after liking a potential match
                if liked  {
                    ZStack {
                        LinearGradient(colors: [Color("white").opacity(0.94), Color.clear,Color.clear], startPoint: .bottom, endPoint: .top)
                            .animation(.easeInOut.speed(0.65), value: hidemainTab)
                            .opacity(hidemainTab ? 1 : 0)
                        likedcontent
                            .animation(.easeInOut.delay(0.05), value: hidemainTab)
                            .offset(y: !hidemainTab ? UIScreen.main.bounds.height * 1.02 : 0)
                        
                        
                    }.background(.ultraThinMaterial)
                        .edgesIgnoringSafeArea(.all)
                }
                
              //if  !outOfMatches && showProfile {
                    nameandheart
               // }
                
            }.animation(.spring(), value: dislike)
            //.opacity(dislike ? 0 :1 )
                .offset(y: dislike ? UIScreen.main.bounds.height * 1.02 : 0)
            
                .onAppear{
                    withAnimation(.spring()) {
                        animateapper = true
                    }
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
        }
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
    var likedcontent: some View {
        
        VStack(spacing: 20.0) {
            
            
            
            VStack(alignment: .leading) {
                HStack {
                    HStack {
                        Image(systemName: "person.2.fill")
                        Text(erro.isEmpty ? "You Liked :)" : erro)
                        
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
                    
                }
                HStack { Image(systemName: "quote.opening")
                    Text(profile.aboutme)
                        .lineLimit(1)
                    Image(systemName: "quote.closing")
                }
            }.padding(15)
                .neoButtonOff(isToggle: false, cornerRadius: 15, perform: {
                //clikced you liked
                sendMessageFocused = false
            })
                .padding(.top, 30)
                .offset(y: liked ? 0 : -20)
            
            
            VStack {
                ZStack{
                    VStack{
                        Color.black.opacity(0.25)
                    }
                    ImageViewer(url: likedImage.isEmpty ? profile.avatar.isEmpty ? "" : profile.avatar : likedImage)
                       // .matchedGeometryEffect(id: profile.avatar, in: namespace)
                       
                    
                    
                }
                
                .frame(width: 400 , height: 400)
            }
            .animation(.spring(), value: hidemainTab)
            .neoButtonOff(isToggle: false, cornerRadius: 15, perform: {
                //clikced you liked
                sendMessageFocused = false
            })
            //.matchedGeometryEffect(id: "profileimage", in: namespace)
            
            
            
            
            
            
            HStack {
                TextField("Message...", text: $sendMessage)
                   
                    .focused($sendMessageFocused)
                    .padding(.vertical,16)
                    .padding(.leading, 15)
                    .foregroundColor(Color("black"))
                    .background(Color("offwhite"))
                    .cornerRadius(25)
                    .overlay(
                        HStack(spacing: 0.0) {
                            Image(systemName: "paperplane")
                            Text("Match")
                                .font(.subheadline)
                            
                        }    .padding(.vertical,10)
                            .padding(.horizontal,10)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(29)
                            .onTapGesture {
                                //
                                liked = false
                                sendMatch()
                            }
                            .offset(x: 150)
                    )
                    .offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 25, action:  .constant(false))
                    .padding(.horizontal,0)
                    .keyboardAvoider()
                
                
                
                
                
            }
            
            
            if !sendMessageFocused {
                VStack {
                  
                    
                    Image(systemName: "xmark")
                        .padding(.vertical,20)
                        .padding(.horizontal,20)
                        .background(Color("offwhite"))
                        .cornerRadius(60)
                        .neoButton(isToggle: false) {
                            //
                            hidemainTab = false
                            withAnimation(.spring()) {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    liked = false
                                }
                            }
                        }
                        .padding(.top,10)
                }
            }
            Spacer()
        }.padding(.horizontal, 20)
            .offset(y:hidemainTab ? 110 : 220)
           // .background(Color.black.opacity(0.65))
      
            .onAppear{
                
                withAnimation(.spring()) {
                    hidemainTab = true
                    
                }
            }
            .onDisappear{
                
                withAnimation(.spring()) {
                    hidemainTab = false
                }
            }
        
        
    }
    var randomProfiles: [UserStruct] {
        guard let currentUser = currentUser else {
            return [] // No current user, return an empty array
        }
        let matchingEmails = Set(currentUser.matches)
        let filteredProfiles = profiles.filter { !matchingEmails.contains($0.email) }
        
        return filteredProfiles
    }
    var scrollDetection: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { offset in
            withAnimation(.easeInOut) {
                scrolledItem = Int(offset)
                
                
                
                
                
                if offset < -15 {
                    
                    withAnimation(.spring()) {
                        hidemainTab = true
                        
                    }
                    
                }
                
                else {
                    withAnimation(.spring()) {
                        hidemainTab = false
                    }
                    
                    
                }
                
            }
        }
    }
    
    //    func sendMatchMessage(text: String) {
    //
    //
    //        let user = Auth.auth().currentUser
    //        let db = Firestore.firestore()
    //
    //        // Data for the new document
    //
    //
    //        // Add a placeholder for the document ID
    //        let docRef = db.collection("messages").document()
    //
    //
    //        // Add the document with the modified data
    //        docRef.setData(["docid": docRef.documentID,
    //                        "matched": true,
    //                        "time":  Date(),
    //                        "email": [user?.email ?? "" , "zab.charles@gmail.com"]
    //                        // Add other fields as needed
    //                       ], merge: false) { error in
    //            if let error = error {
    //                // Handle error
    //            } else {
    //                // Data added successfully
    //            }
    //        }
    //
    //    }
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
                    withAnimation(.openCard) {
                        viewState = .zero
                    }
                }
            }
    }
    func typeWriter(_ text: String, completion: @escaping () -> Void) {
        let original = typeText
        //typeText = ""
        var currentIndex = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            if currentIndex < text.count {
                let index = text.index(text.startIndex, offsetBy: currentIndex)
                let character = text[index]
                
                DispatchQueue.main.async {
                    withAnimation(.easeIn) {
                        typeText += String(character)
                    } // Update the typedText property on the main queue
                }
                
                currentIndex += 1
            } else {
                
                timer.invalidate()
                completion()
                // Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
                //   withAnimation(.easeInOut) {
                //  typeText = original
                //
                //   }
                // }
                
            }
        }
    }
    
    
    func unMatch(){
        
        //xzv  x      zn                     let db = Firestore.firestore()
        //    let user = Auth.auth().currentUser
        //save the dounload url to database key
        
        //We look for the user id of the current user
        //    db.collection("users").whereField("email", isEqualTo: profile.email)
        //            .getDocuments() { (querySnapshot, error) in
        //                if error != nil {
        //                    //there is an error
        //                } else {
        //                    for document in querySnapshot!.documents {
        //
        //                        //We add that user id to our unmatch collection
        //                        //erro = "\(user?.uid ?? "")"
        //                        db.collection("users").whereField("email", isEqualTo: user?.email)
        //                            .getDocuments() { (querySnapshot, error) in
        //                                if error != nil {
        //                                    //there is an error
        //                                } else {
        //                                    for myinfo in querySnapshot!.documents {
        //
        //                                        //We add that user id to our unmatch collection
        //                                        //erro = "\(user?.uid ?? "")"
        //                                        db.collection("users").document(myinfo.documentID)
        //                                            .collection("notamatch").document(document.documentID).setData(["date": Date()], merge: true) { error in
        //
        //                                                if error == nil {
        //
        //
        //                                                }
        //                                            }
        //                                    }
        //                                }
        //                            }
        //
        //                    }
        //                }
        //            }
        
    }
    func sendMatch() {
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        
        
        
        let docRef = db.collection("messages").document()
        let docid = docRef.documentID
        
        // Add the document with the modified data
        
        if sendMessage.isEmpty {
            docRef.setData(["matched": true,
                            "time":  Date(),
                            "email": [user?.email ?? "" , profile.email],
                            "matchid": docRef.documentID
                            // Add other fields as needed
                           ], merge: true) { error in
                if let error = error {
                    // Handle the error
                    print("Error updating message data: \(error.localizedDescription)")
                    return
                }
            }
        } else {
            docRef.setData(["matched": true,
                            "time":  Date(),
                            "email": [user?.email ?? "" , profile.email],
                            "matchid": docRef.documentID
                            
                            // Add other fields as needed
                           ], merge: true) { error in
                if let error = error {
                    // Handle the error
                    print("Error updating message data: \(error.localizedDescription)")
                    return
                }
            }
            
            docRef.collection("log").document().setData([
                "text": sendMessage,
                "time":  Date(),
                "email": user?.email
                
                // Add other fields as needed
            ], merge: true) { error in
                if let error = error {
                    // Handle the error
                    print("Error updating message data: \(error.localizedDescription)")
                    return
                }
            }
            
            
        }
    }
    func getLocation(){
        
    }
}

struct FullMatchProfileView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        // FullProfileView(namespace: namespace, matchcard: .constant(matchCardData[0]), showProfile: .constant(false))
        ViewController()
        
    }
}

