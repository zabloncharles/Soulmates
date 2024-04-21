//
//  SkullProfile.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/27/23.
//
import CoreLocation
import SwiftUI


struct SkullProfile: View {
    @State  var previousOffset: CGFloat = 0
    @State var showblacknav = false
    @AppStorage("currentPage") var selected = 0
    @State var profiles: [UserStruct] = fakeUsers
    @Binding var currentUser: UserStruct?
    @AppStorage("hidemainTab") var hidemainTab = false
    var profile = fakeUsers[0]
    var isAnimated = true
    @State var viewState: CGSize = .zero
    @State var pageAppeared = false
    @Binding var showProfile : Bool
    @FocusState var sendMessageFocused: Bool
    @State var profileImagesLoaded = [false,false,false]
    @State var showHearts = false
    var editingProfile = false
    @State var previewProfile = false
    @State private var isShowingModal = false
    
    @State var showDragProgressView = false
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
    @State var likedtext = false
    @State var likedquote = "I enjoy playing the zumba"
    @State var cancelLike = false
    @State var profileImages = ["","",""]
    @State var likedImageUrl = ""
    @State var report = false
    @State var showMore = false
    @State var hidenav = false
    @State var scrolledItem = 0
    @State var profileNumber = 0
    @Binding var currentIndex : Int
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        
        ZStack {
          
            
          
          
            
            VStack {
                if !outOfMatches && dislike {
                    VStack {
                        LottieView(filename: "girlonphone")
                            .neoButton(isToggle: false) {
                                //
                            }
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    
                                    dislike = false
                                    animategirl = false
                                    
                                    
                                }
                            }
                            .offset(y:-30)
                    }
                    .frame(width: 350, height: 350)
                    .animation(.spring(), value: animategirl)
                    .scaleEffect(animategirl ? 1 : 0.81)
                    .overlay(
                        VStack{
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("Looking for your soulmate..")
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
            
           
                ZStack {
                    

                    ScrollView(.vertical, showsIndicators: false) {
                        
//                        cover
//                            .background(scrollDetection)
                          
                        
                        content
                            .background(scrollDetection)
                          
                        
                    }
                    .coordinateSpace(name: "scroll")
                    
                    
                    .onAppear{
                        // DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
                        profileNumber = profileNumber + 1
                    }
                   
                    .onTapGesture {
                        
                        
                        
                    }
                    .ignoresSafeArea()
                    
                    //the send text view that comes after liking a potential match
                   
                
                   
                           

                  
                                      
                      
                    
                            
                      
                    
                }.animation(.spring(), value: dislike)
               
            nameandheartnav
                .opacity(liked ? 0 : editingProfile ? 1 : 1)
                .offset(y:editingProfile ? -50 : 0)
            
           
            
           
            
            if report {
              ReportCard(report: $report, appeared: $hidemainTab)
            }
             
            
              
            
        }.background(Color("offwhiteneo"))
            .sheet(isPresented: $isShowingModal) {
                likedcontent
            }
           
        .onAppear{
          
            
                // Fetch user data when the view appears
            
                
            
                
            
            withAnimation(.spring()) {
                animateapper = true
            }
        }
        .onDisappear{
            withAnimation(.spring()) {
                animateapper = false
                
            }
        }
        .onChange(of: liked) { V in
            if liked {
                hidemainTab = true
                withAnimation(.spring()) {
                    showHearts = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        showHearts = false
                    }
                }
            } else {
                likedquote = ""
                hidemainTab = false
            }
        }
        
    }
    var nameandheart: some View{
       
            HStack {
                HStack(spacing: 3.0) {
                    
                
                   
                    Text(editingProfile  && !previewProfile ? "Profile" : "Match")
                            .font(.title)
                        .bold()
                
                    
                    Image(systemName:editingProfile   && !previewProfile ?  "person.crop.circle" : "person.2")
                        .font(.title)
                        .fontWeight(.bold)
                        
                    
                    
                 
                    
                    
                }
                    .padding(.vertical, 6)
                 
                
                 
                    
                
                Spacer()
                Button {
                    withAnimation(.spring()) {
                        if editingProfile {
                            showProfile = true
                        } else {
                            showProfile = false
                        }
                        
                        
                    }
                    withAnimation {
                       // if currentIndex != profiles.count - 1 {
                            currentIndex += 1
                       // }
                        
                    }
                
                    
                } label: {
                    if !liked {
                        Image(systemName:editingProfile  && !previewProfile ?  "gear" : "heart.slash")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(editingProfile   && !previewProfile ?  Color("black") : .red)
                    } else {
                        
                        Image(systemName: "heart.slash.fill")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        
                    }
                    
                    
                }
               
                
            }.padding(.horizontal,25)
            .padding(.top,5)
           
        
           
       
    }
    var nameandheartnav: some View{
        VStack {
            HStack {
                HStack {
                    
                    
                    HStack(spacing: 2){
                        Text(profile.firstName)
                            .bold()
                            .font(.title)
                        Image(systemName: "square.and.arrow.down.fill")
                            .foregroundColor(.blue)
                            .font(.title2)
                        
                        
                    }
                    
                    
                    
                }
                    .padding(.vertical, 6)
                    .background(Color("offwhiteneo"))
                  
                   
                
                Spacer()
                Button {
                    withAnimation(.spring()) {
                        if !editingProfile {
                            showProfile = false
                        }
                    }
                  
                    showblacknav = true
                    withAnimation {
                        // if currentIndex != profiles.count - 1 {
                  
                        currentIndex += 1
                        
                        // }
                        
                    }
                    
                    
                } label: {
                    if editingProfile && !previewProfile {
                        Image(systemName: "gear")
                            .font(.title)
                            .fontWeight(.bold)
                        .foregroundColor(.red)
                    }
                    
                    if !dislike && !editingProfile {
                        Image(systemName: "heart.slash")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                    }
                    
                    
                }
            } .offset(y:69)
                .padding(.horizontal,25)
                
                .frame(height: 190)
                
                .background(Color("offwhiteneo"))
                .offset(y:-100)
            Spacer()
        }
        .animation(.spring(), value: showblacknav)
        .opacity(showblacknav ? 1 : 0)
        .offset(y: showblacknav ? 0 : -100)
      
    }
  
    var avatarandthreeinfo: some View {
        VStack {
            HStack {
                ZStack {
                    Circle()
                        .fill(.angularGradient(colors: [.purple, .orange, .purple], center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
                        .frame(height: 95)
                        .frame(width: 95)
                        .cornerRadius(64)
                    GetImageAndUrl(url:profile.avatar, loaded: .constant(true), imageUrl: .constant(""))
                    
                        .frame(height: 91)
                        .frame(width: 91)
                        .cornerRadius(64)
                        .overlay(
                            Text("Active")
                                .font(.caption)
                                .padding(.horizontal,5)
                                .padding(.vertical,2)
                                .background(.black)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .offset(x:30,y:30)
                        )
                }
                .padding(.horizontal,5)
                .padding(.bottom,-20)
                
                Spacer()
                
                VStack {
                    HStack{
                        
                        VStack{
                            Image(systemName: "balloon.fill")
                            Text("24")
                        }
                        .padding(.horizontal,10)
                        .padding(.vertical,4)
                        
                        
                        
                        
                        VStack{
                            Spacer()
                        }.frame(width: 1, height: 12)
                            .background(Color("black"))
                        
                        VStack{
                            Image(systemName: "figure.cooldown")
                            
                            Text("5'6")
                        }
                        .padding(.horizontal,10)
                        .padding(.vertical,4)
                       
                        
                        VStack{
                            Spacer()
                        }.frame(width: 1, height: 12)
                            .background(Color("black"))
                        
                        VStack{
                            Image(systemName: "mappin.and.ellipse")
                            Text("25k")
                        }
                        .padding(.horizontal,10)
                        .padding(.vertical,4)
                        
                    }
                    
                    
                    if (editingProfile){
                        HStack(alignment: .center) {
                            if !previewProfile {
                                HStack{
                                  
                                    Text("Edit")
                                     
                                        .foregroundColor(editingProfile ? .white : Color("black"))
                                    
                                    
                                }
                                .padding(.horizontal,30)
                                .padding(.vertical,5)
                                .background(previewProfile ? Color("white") : editingProfile ? .gray : .blue)
                                .cornerRadius(6)
                                .neoButton(isToggle: false, perform: {
                                  currentIndex = 1
                                    if currentIndex == 1 {
                                        withAnimation(.spring()) {
                                            showProfile = true
                                        }
                                    }
                                    
                                    
                            })
                            }
                        
                            HStack{
                            
                            Text(previewProfile ? "End Preview" : "Preview")
                               
                                .foregroundColor(editingProfile ? .white : Color("black"))
                               
                            
                        }
                            .padding(.horizontal,30)
                            .padding(.vertical,5)
                            .background(previewProfile ? Color("white") : editingProfile ? .blue : .blue)
                            .cornerRadius(6)
                            .neoButton(isToggle: false, perform: {
                               if  editingProfile && !previewProfile {
                                   withAnimation(.spring()) {
                                       previewProfile = true
                                   }
                                } else {
                                    withAnimation(.spring()) {
                                        previewProfile = false
                                    }
                                }
                                
                            })
                        
                        }
                    }
                }
                
               
                
                Spacer()
            }
            Spacer()
            
            VStack {
                HStack(spacing: 2){
                    Text(profile.firstName)
                        .bold()
                        .font(.headline)
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 18, weight: .medium))
                    Text("her/she")
                       
                        .font(.callout)
                    Spacer()
                }
                HStack{
//                    text characters of 131
                    Text("\"Music lover and hopeless romantic. Enjoy quiet nights in with a good book or movie, but also love hitting the dance floor and losing myself in the music.\"")
                        .font(.subheadline)
                        .lineLimit(3)
                    Spacer()
                }
               
            } .padding(.top,20)
        }.padding(.leading,20)
    }
    
    var moreinfohorizontalcards: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack {
               
                
                InfoButton(icon: "globe.europe.africa", label: calculateDistance())
                    .neoDoubleTapButton(isToggle: false, perform: {
                        likedtext = true
                    })
                VStack{
                    Spacer()
                }.frame(width: 1, height: 12)
                    .background(Color("black"))
                InfoButton(icon: "graduationcap", label: profile.education)
                    .neoDoubleTapButton(isToggle: false, perform: {
                        likedtext = true
                    })
                VStack{
                    Spacer()
                }.frame(width: 1, height: 12)
                    .background(Color("black"))
                
                InfoButton(icon: "building", label: profile.occupation)
                    .neoDoubleTapButton(isToggle: false, perform: {
                        likedtext = true
                    })
                   
                VStack{
                    Spacer()
                }.frame(width: 1, height: 12)
                    .background(Color("black"))
                
                InfoButton(icon: "location", label: profile.location[2])
                    .neoDoubleTapButton(isToggle: false, perform: {
                        likedtext = true
                    })
                
                  
                
            
            }.padding(.trailing,20)
            .padding(.leading,20)
            
          
            
        }
    }
    var whatilike: some View{
        QuotePillsCard(name: profile.firstName, caption: "Finding out what your matches like to do for fun shouldn't feel like a chore. With Match Interests, exploring hobbies and activities is enjoyable and interactive", report: $report)
            .neoDoubleTapButton(isToggle: false, perform: {
                //
                likedImageUrl = ""
                likedtext = true
                //                withAnimation(.spring()) {
                //                    liked = true
                //                }
                isShowingModal.toggle()
                likedquote = "What do you like to do for fun?"
            })
            .padding(.leading,20)
         
    }
    var content: some View {
        
      
            
            
            
            
            VStack( spacing: 20.0) {
                if showDragProgressView {
                    VStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color("black")))
                    }.padding(.top,30)
                }
                
                nameandheart
             
                
               avatarandthreeinfo
                   
                 
               
          
                if editingProfile  && !previewProfile {
                    ScrollView(.horizontal) {
                            HStack(spacing: 10.0) {
                                AddCards(icon: "text.bubble.fill" ,caption: "prompt")
                                    .neoButton(isToggle: false) {
                                        //
                                        likedImageUrl = ""
                                        likedtext = true
                                        //                withAnimation(.spring()) {
                                        //                    liked = true
                                        //                }
                                        isShowingModal.toggle()
                                        likedquote = "What do you like to do for fun?"
                                    }
                                
                                Divider()
                                AddCards(icon: "photo.circle.fill", caption: "photo")
                                    .neoButton(isToggle: false) {
                                        //
                                    }
                                Divider()
                                AddCards(icon: "quote.bubble", caption: "quote")
                                    .neoButton(isToggle: false) {
                                        //
                                    }
                            }
                          
                    }.offset(x:20)
                }
             
                
//                About me card
                
                if !profileImagesLoaded[0] {
                    VStack(alignment: .center) {
                        Divider()
                        
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .padding(.top,70)
                    }
                }
               
                VStack(alignment: .leading, spacing: 13.0) {
                    
                   
                   
                        moreinfohorizontalcards
                       
                    
                        Divider()
                     
                    
                       
                        
                    QuoteImageCard(name: profile.firstName, caption: "Life is too short to worry about thigh gaps, focus on making memories",url: profile.photos[0], urlReturned: $profileImages[0], loaded: $profileImagesLoaded[0], report: $report)
                        .neoDoubleTapButton(isToggle: false, perform: {
                            //when first image is clicked
                           likedquote = "Life is too short to worry about thigh gaps, focus on making memories"
                            likedImageUrl = profileImages[0]
                            if profileImagesLoaded[0] {
//                                withAnimation(.spring()) {
//                                    liked = true
//                                }
                                isShowingModal.toggle()
                            }
                            
                        })
                 
                   
//                    Likes Pill
                  whatilike
                    
                    Divider()
                    
                    QuoteImageCard(name: profile.firstName, caption: "Life's a beach, enjoy the waves and soak up the sun", url: profile.photos[1], urlReturned: $profileImages[1], loaded: $profileImagesLoaded[1], report: $report)
                        .neoDoubleTapButton(isToggle: false, perform: {
                            //when first image is clicked
                            likedquote = "Life's a beach, enjoy the waves and soak up the sun"
                            likedImageUrl = profileImages[1]
                            
                            if profileImagesLoaded[1] {
                               
                                isShowingModal.toggle()
                            }
                            
                            
                        })
                    
                    
                   answerprompt
                    
                    
                    
                    
                    
                }.offset(y:  !profileImagesLoaded[0] && !profileImagesLoaded[1] ? UIScreen.main.bounds.height : 0)
                
                
                
             
                    
            }
            
            .padding(.top,40)
           
            .padding(.bottom,120)
            
        
    }
    
    var answerprompt: some View{
        QuoteAnswerCard(name: profile.firstName,day: "1",caption: "I'm a professional couch potato. Netflix marathons are my specialty!", question: "What do you do for fun?", report: $report)
            .padding(.leading,20)
            .neoDoubleTapButton(isToggle: false, perform: {
                likedImageUrl = ""
                likedtext = true
//                withAnimation(.spring()) {
//                    liked = true
//                }
                isShowingModal.toggle()
                likedquote = "I'm a professional couch potato. Netflix marathons are my specialty!"
            })
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
        
        ScrollView(.vertical) {
            VStack(spacing: 20.0) {
                Text("Message")
                    .font(.body)
                    .bold()
                    .padding()
                    .padding(.bottom,-40)
                
                
               
          
               
                VStack(alignment: .leading) {
                    
                        
                        
                        
                        
                        HStack {
                           
                                GetImageAndUrl(url:likedImageUrl, width: 40 , height: 40, loaded: .constant(true), imageUrl: .constant(likedImageUrl))
                                    .frame(width: 40 , height: 40)
                                    .cornerRadius(36)
                                VStack {
                                    Text(profile.firstName)
                                        .bold()
                                    .font(.title3)
                                  
                                }
                                
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 18, weight: .medium))
                            
                            Text("2d")
                            
                                .font(.callout)
                            
                            Spacer()
                            HStack (spacing: 4.0){
                               
                               
                                    Image(systemName: "fleuron.fill")
                                        .foregroundColor(.red)
                                        .font(.title3)
                                        .padding(.trailing,10)
                                
                            
                               
                                
                            }
                           
                        }
                     
                        
                        HStack(spacing: 6.0) {
                           
                            
                            
                            VStack {
                                Text("\"\(likedquote)\"")
                                    .font(.callout)
                                    .italic()
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading,40)
                                    .overlay{
                                        HStack {
                                            Rectangle()
                                                .fill(.red)
                                                .frame(width:1)
                                                .offset(x:20)
                                            Spacer()
                                        }
                                    }
                                
                                if !likedImageUrl.isEmpty {
                                    GetImageAndUrl(url:likedImageUrl, width:UIScreen.main.bounds.width - 80 , height: UIScreen.main.bounds.width - 80, loaded: .constant(true), imageUrl: .constant(likedImageUrl))
                                        .frame(width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.width - 80)
                                        .cornerRadius(13)
                                        .padding(.leading,40)
                                        .overlay{
                                            ZStack {
                                                HStack {
                                                    Rectangle()
                                                        .fill(.gray)
                                                        .frame(width:1)
                                                        .offset(x:20)
                                                    Spacer()
                                                }
                                                if showHearts {
                                                    
                                                    LottieView(filename: "loveflying",loop: false)
                                                        .frame(width: 299, height: 250)
                                                        .colorMultiply(.white)
                                                        .opacity(0.57)
                                                    
                                                }
                                            }
                                    }
                                }
                            }.overlay{
                                HStack {
                                    Rectangle()
                                        .fill(.gray)
                                        .frame(width:1)
                                        .offset(x:20)
                                    Spacer()
                                }
                            }
                            
                            
                        }
                    
                  
                        
                    
                   
                }
 
                
                
                   
                    .padding(.top, 30)
                   
                
             
            
                HStack {
                    GetImageAndUrl(url:currentUser?.avatar ?? "", width: 40 , height: 40, loaded: .constant(true), imageUrl: .constant(likedImageUrl))
                        .frame(width: 40 , height: 40)
                        .cornerRadius(36)
                    
                    VStack(spacing: 8.0) {
                        HStack{
                           
                            Text(currentUser?.firstName ?? "")
                                    .bold()
                                    .font(.title3)
                                
                           
                            
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                                .font(.system(size: 18, weight: .medium))
                            
                            Text("2d")
                            
                                .font(.callout)
                        Spacer()
                     
                        }
                        TextField("What do you think...", text: $sendMessage)
                            
                                .focused($sendMessageFocused)
                                .italic()
                                .foregroundColor(Color("black"))
                                
                                .padding(.trailing,70)
                                .overlay{
                                    
                                       
                                    HStack(alignment: .center, spacing: 0.0) {
                                            Spacer()
                                            Image(systemName: "paperplane")
                                                .padding(.vertical,12)
                                                .padding(.horizontal,12)
                                                .foregroundColor(.white)
                                                .background(Color.blue)
                                                .cornerRadius(29)
                                            
                                        }
                                    .offset(x: -10,y:-10)
                                    .neoButton(isToggle: false) {
                                        isShowingModal.toggle()
                                    }
                                        
                                    
                                }
                                .onAppear{
                                    sendMessageFocused = true
                                }
                           
                            
                    }
                }
                
                       
                        
                      
                        
                        
                        
                        
              
                Spacer()
                
                
            }.padding(.horizontal, 10)
                .padding(.bottom,10)
                
                
                .onTapGesture {
                    withAnimation(.spring()) {
                        liked = false
                        
                        
                    }
                }
                .onAppear{
                    
                    withAnimation(.spring()) {
                        showblacknav = false
                        
                        heartsFunc()
                        
                    }
                }
                .onDisappear{
                    
                    withAnimation(.spring()) {
    //                    showblacknav = false
                    }
            }
            
           
//
        }.background(Color("offwhiteneo"))
            .modifier(KeyboardAwareModifier())
        
        
    }
   
   
    func roundDistance(distanceInMiles: Double) -> String {
        if distanceInMiles >= 1000 {
            let roundedDistance = Int(distanceInMiles / 1000)
            return "\(roundedDistance)k miles"
        } else if distanceInMiles >= 100 {
            let roundedDistance = Int(distanceInMiles / 100) * 100
            return "\(roundedDistance) miles"
        } else if distanceInMiles >= 10 {
            let roundedDistance = Int(distanceInMiles / 10) * 10
            return "\(roundedDistance) miles"
        } else {
            let roundedDistance = Int(distanceInMiles)
            return "\(roundedDistance)"
        }
    }
    
func calculateDistance() -> String {
   
 
    
    let coordinatesA = (latitude: Double(profile.coordinates[0]), longitude: Double(profile.coordinates[1]))
    let coordinatesB = (latitude: Double(fakeUser.coordinates[0]), longitude: Double(fakeUser.coordinates[1]))
    
    let locationA = CLLocation(latitude: coordinatesA.latitude ?? 0.0, longitude: coordinatesA.longitude ?? 0.0)
    let locationB = CLLocation(latitude: coordinatesB.latitude ?? 0.0, longitude: coordinatesB.longitude ?? 0.0)
    
//    let distance = locationA.distance(from: locationB)
//    return String(format: "%.2f meters", distance)
    let distanceInMeters = locationA.distance(from: locationB)
    let distanceInMiles = distanceInMeters * 0.000621371
    return roundDistance(distanceInMiles: distanceInMiles)
}
    var scrollDetection: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { offset in
            
            if offset > 60 {
                //hide profile after pulling down cover
                withAnimation(.spring()) {
                    showProfile = false
                    hidemainTab = false
                    if profiles.count == 1 {
                        topDragFunc()
                    }
                }
            }
            
            if offset < -110 {
                
                withAnimation(.spring()) {
                    showblacknav = true
                    
                }
                if offset < previousOffset {
                    // Scrolling up
                    withAnimation(.spring()) {
                        hidemainTab = true
                    }
                } else {
                    // Scrolling down
                    withAnimation(.spring()) {
                        hidemainTab = false
                    }
                }
                
            }
            
            else {
                withAnimation(.spring()) {
                    showblacknav = false
                
                    
                }
                
                
            }
            
          
            
            previousOffset = offset
        }
    }
    
    func heartsFunc(){
        withAnimation(.spring()){
            showHearts = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.spring()){
                showHearts = false
            }
        }
    }
    func topDragFunc(){
        withAnimation(.spring()){
            showDragProgressView = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.spring()){
                showDragProgressView = false
            }
        }
    }
    
    func typeWriter(_ text: String, completion: @escaping () -> Void) {
      
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
    

   
}
