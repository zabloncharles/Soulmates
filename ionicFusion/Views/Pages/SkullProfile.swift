//
//  SkullProfile.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/27/23.
//

import SwiftUI


struct SkullProfile: View {
    @State var showblacknav = false
    @AppStorage("currentPage") var selected = 0
    @State var profiles: [UserStruct] = compatibleFakeUsers
    @Binding var currentUser: UserStruct?
   
    var profile = userStruct[0]
    var isAnimated = true
    @State var viewState: CGSize = .zero
    @State var pageAppeared = false
    @Binding var showProfile : Bool
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
    @State var hidenav = false
    @State var scrolledItem = 0
    @State var profileNumber = 0
    @Binding var currentIndex : Int
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        
        ZStack {
          
            
            Color("offwhiteneo")
          
            
            VStack {
                if !outOfMatches && dislike {
                    VStack {
                        LottieView(filename: "girlonphone")
                            .neoButton(isToggle: false, perform: {
                                //
                            })
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
                                TextWriterAppear(typeText: "Looking for your soulmate..", speed: 0.02)
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
                    

                    ScrollView {
                        
//                        cover
//                            .background(scrollDetection)
                          
                     
                        content
                            .background(scrollDetection)
                          
                        
                    }
                    .coordinateSpace(name: "scroll")
                    .mask(RoundedRectangle(cornerRadius: viewState.width / 3))
                    .scaleEffect(-viewState.width/500 + 1)
                    .gesture(drag)
                    .onAppear{
                        // DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
                        profileNumber = profileNumber + 1
                    }
                    .blur(radius: liked ? 20 : 0)
                    .ignoresSafeArea()
                    
                    //the send text view that comes after liking a potential match
                   
                        ZStack {
                            LinearGradient(colors: [Color("offwhiteneo"),Color.clear], startPoint: .bottom, endPoint: .top)
                                .animation(.easeInOut.speed(0.65), value: liked)
                                .opacity(liked ? 1 : 0)
                            nameandheart
                            
                            likedcontent
                                .animation(.spring(), value: liked)
                                .offset(y:110)
                            
                            
                        }.background(LinearGradient(colors: [Color("offwhiteneo"),Color("offwhiteneo"),Color("offwhiteneo").opacity(0.80)], startPoint: .bottom, endPoint: .top).offset(y: !liked ? UIScreen.main.bounds.height * 1.30 : 0).opacity(liked ? 1 : 0))
                        .cornerRadius(liked ? 0 : 15)
                        .offset(y: !liked ? UIScreen.main.bounds.height * 1.30 : 0)

                  
                                      
                      
                    
                            
                      
                    
                }.animation(.spring(), value: dislike)
               
            nameandheartnav
                .opacity(liked ? 0 : 1)
            
            
       
              
            
        }
        .onAppear{
            withAnimation(.spring()) {
                animateapper = true
            }
        }
        .onDisappear{
            withAnimation(.spring()) {
                animateapper = false
                
            }
        }
    }
    var nameandheart: some View{
        VStack {
            HStack {
                HStack {
                    
                
                    Text("Soulmate")
                        .font(.custom("MrDafoe-Regular", size: 42))
                    
                        .foregroundColor(.clear)
                        .background( LinearGradient(colors: [Color.red,.blue,.purple], startPoint: .leading, endPoint: .trailing))
                        .mask(
                            
                            Text("Soulmate")
                                .font(.custom("MrDafoe-Regular", size:  42))
                            
                            
                        )
                       
                    
                        
                    
                    
                    
                }
                    .padding(.vertical, 6)
                    .background(Color("offwhiteneo"))
                 
                    
                
                Spacer()
                Button {
                    showProfile = false
                    withAnimation {
                       // if currentIndex != profiles.count - 1 {
                            currentIndex += 1
                       // }
                        
                    }
                
                    
                } label: {
                    if !liked {
                        Image(systemName: "heart.slash")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                    } else {
                        
                        Image(systemName: "heart.slash.fill")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        
                    }
                    
                    
                }
            }.padding(.horizontal,15)
            Divider()
        }
    }
    var nameandheartnav: some View{
        VStack {
            HStack {
                HStack {
                    
                    
                    Text(profile.firstname)
                        .font(.title)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    
                    
                    
                }  .padding(.horizontal,12)
                    .padding(.vertical, 6)
                    .background(Color("offwhiteneo"))
                    .cornerRadius(69)
                   
                
                Spacer()
                Button {
                    showProfile = false
                    showblacknav = true
                    withAnimation {
                        // if currentIndex != profiles.count - 1 {
                  
                        currentIndex += 1
                        
                        // }
                        
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
            } .offset(y:69)
                .padding(.horizontal,25)
                
                .frame(height: 199)
                
                .background(Color("offwhiteneo"))
                .offset(y:-100)
            Spacer()
        }
        .animation(.spring(), value: showblacknav)
        .opacity(showblacknav ? 1 : 0)
        .offset(y: showblacknav ? 0 : -100)
      
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
                VStack{
                    GetImageAlert(url:profile.avatar,loaded: $profileLoaded)
                        .offset(y: scrollY > 0 ? -scrollY : 0)
                        .scaleEffect(liked ? 1.4 : scrollY > 0 ? scrollY / 1000 + 1 : 1)
                        .blur(radius: liked ? 14 : scrollY > 0 ? scrollY / 10 : 0)
                        .accessibility(hidden: true)
                        .animation(.spring(), value: liked)
                    
                    
                    
                    
                })
            .overlay {
                VStack{
                    Spacer()
                    Rectangle()
                        .fill(LinearGradient(colors: [Color("offwhiteneo"),Color.clear], startPoint: .bottom, endPoint: .top))
                        .frame(height: 150)
                        
                        .offset(y:20)
                }
            }
        }
        .frame(height: 400)
    }
    
    var content: some View {
        
      
            
            
            
            
            VStack(alignment: .leading, spacing: 20.0) {
                
                nameandheart
                ZStack {
                
                    GetImageAlert(url:profile.avatar,loaded: $profileLoaded)
                        .blur(radius: 90)
                        .frame(height: 461)
                    
                        .cornerRadius(34)
                    
                        .padding(.horizontal,5)
                       
                    
                      
                        .padding(.bottom,-20)
                    
                    GetImageAlert(url:profile.avatar,loaded: $profileLoaded)
                        .frame(height: 450)
                    
                        .cornerRadius(31)
                    
                        .padding(.horizontal,10)
                    
                       
                        .padding(.bottom,-20)
                        .overlay {
                            VStack {
                                Spacer()
                                VStack {
                                    HStack {
                                        Text(profile.firstname)
                                            .font(.title).bold()
                                        Text(profile.age )
                                            .font(.title3).bold()
                                            .padding(5)
                                            .background(Color.orange)
                                            .cornerRadius(60)
                                        Spacer()
                                    }
                                    
                                    
                                    HStack {
                                        TextWriterAppear(typeText: profile.aboutme, speed: 0.02)
                                            .font(.footnote)
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(2)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .foregroundColor(Color("black"))
                                        Spacer()
                                      
                                    }
                              
                                }
                                .padding(.horizontal,20)
                                    .padding(.vertical,15)
                                .background(Rectangle()
                                    .fill(.ultraThinMaterial))
                                .cornerRadius(42)
                                .offset(y:30)
                                .padding(20)
                            }
                        }
                }
              
                    
                
//                About me card
                VStack(alignment: .leading, spacing: 13.0) {
                 
                    
                    HStack{
                        
                        HStack{
                            Image(systemName: "pencil.and.ruler")
                            Text("5'0")
                        }
                            .padding(.horizontal,10)
                            .padding(.vertical,4)
                            .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 6, action: $liked)
                           
                            
                        
                     VStack{
                            Spacer()
                     }.frame(width: 1, height: 12)
                            .background(Color.white)
                        
                        HStack{
                            Image(systemName: "house")
                            Text("Cambridge")
                        }
                        .padding(.horizontal,10)
                        .padding(.vertical,4)
                        .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 6, action: $liked)
                    }
                    
                  
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
                .padding(10)
                .offset(y:10)
//                .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 19, action: $liked)
                .background(Color("offwhiteneo"))
                
               
                
         
                
                VStack(alignment: .leading, spacing: 10.0){
                    
                    HStack {
                        
                        
                        Image(systemName: "sparkles")
                            .font(.title)
                            .foregroundColor(Color("black"))
                        
                        Text("First Date Idea?")
                            .font(.subheadline)
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
                            .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 10, action: $liked)
                        
                        HStack {
                            HStack(spacing: 4.0) {
                                
                                Text("Dinner")
                                Spacer()
                                Image(systemName: "fork.knife")
                                
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                            }
                            
                        }.padding(12)
                            .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 10, action: $liked)
                        
                        HStack {
                            HStack(spacing: 4.0) {
                                
                                Text("Other")
                                Spacer()
                                Image(systemName: "eyes.inverse")
                                
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                            }
                            
                        }.padding(12)
                            .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 10, action: $liked)
                            .padding(.bottom,10)
                    }
                }.padding(10)
                    
                   
                    .background(Color("offwhiteneo").cornerRadius(19).padding(1).cornerRadius(12))
                    .background(Color("black").opacity(0.2).cornerRadius(19))
//                    .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 18, action: .constant(false))
                
                
                
                
                
                
                
                    
                HStack {
                    Spacer()
                    GetImageAndUrl(url:"https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1064&q=80", imageUrl: $profileImages[0])
                            .frame(width: UIScreen.main.bounds.width - 20, height: 400)
                        
                            .cornerRadius(20)
                            
                            .neoDoubleTapButton(isToggle: false, perform: {
                                //when first image is clicked
                                liked = true
                                likedImage = profileImages[0]
                                
                        })
                    Spacer()
                }.scaleEffect(1.035)
                    .padding(.vertical,10)
                
                
                
                
                
                
                
                VStack(alignment: .leading, spacing: 15.0){
                    HStack {
                        
                        
                        Image(systemName: "hand.thumbsup")
                            .font(.title)
                        
                        
                        Text("Likes")
                            .font(.subheadline)
                        Spacer()
                    }
                    Text("\"Fun loving and looking to settle up with this stuff and do me. its really not like that said no one ever.\"")

                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                    
                    
                    
                    HStack {
                        ForEach(profile.likes, id: \.self) { like in
                            LikesPill(placeholder: like)
                        }
                        
                        
                    }
                }.foregroundColor(Color("black"))
                    .padding(10)
                  
//                    .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 18, action: $liked)
                    .background(Color("offwhiteneo").cornerRadius(19).padding(1).cornerRadius(12))
                    .background(Color("black").opacity(0.2).cornerRadius(19))
          
                
                HStack {
                    Spacer()
                    GetImageAndUrl(url:profile.images[1], imageUrl: $profileImages[1])
                        .frame(width: UIScreen.main.bounds.width - 20, height: 400)
                    
                        .cornerRadius(20)
                    
                        .neoDoubleTapButton(isToggle: false, perform: {
                            //when first image is clicked
                            liked = true
                            likedImage = profileImages[0]
                            
                        })
                    Spacer()
                }.scaleEffect(1.035)
                    .padding(.vertical,10)
                   
                
                
                
                
                VStack(alignment: .leading, spacing: 15.0){
                    HStack {
                        
                        
                        Image(systemName: "teddybear")
                            .font(.title)
                        
                        Text("The best way to ask me out is by")
                            .font(.subheadline)
                        
                        Spacer()
                    }
                    
                    Text("\"\(profile.lifestyledesc)\"")
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .lineLimit(showMore ? 10 : 3)
                    
                    
                    
                    
                  
                }.foregroundColor(Color("black"))
                    .padding(10)
                
//                    .offwhitebutton(isTapped: liked, isToggle: true, cornerRadius: 20, action: $showMore)
                    .background(Color("offwhiteneo").cornerRadius(19).padding(1).cornerRadius(12))
                    .background(Color("black").opacity(0.2).cornerRadius(19))
                    
                    
                    
              
                
                
                
            }
            
            .padding(.top,40)
            .padding(.horizontal,20)
            .padding(.bottom,120)
            
            
            
            
            
            
        
        
        
        
        
        
        
        
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
//                .neoButtonOff(isToggle: false, cornerRadius: 15, perform: {
//                    //clikced you liked
//                    sendMessageFocused = false
//                })
                .background(Color("offwhiteneo"))
                .cornerRadius(15)
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
            .animation(.spring(), value: showblacknav)
//            .neoButtonOff(isToggle: false, cornerRadius: 15, perform: {
//                //clikced you liked
//                sendMessageFocused = false
//            })
            .cornerRadius(15)
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
                              
                            }
                            .offset(x: 155)
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
                          
                            withAnimation(.spring()) {
                               
                                    liked = false
                              
                            }
                        }
                        .padding(.top,10)
                }
            }
            Spacer()
        }.padding(.horizontal, 20)

        
            .onAppear{
                
                withAnimation(.spring()) {
                    showblacknav = false
                    
                }
            }
            .onDisappear{
                
                withAnimation(.spring()) {
//                    showblacknav = false
                }
            }
        
        
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
                }
            }
            
            if offset < -110 {
                
                withAnimation(.spring()) {
                    showblacknav = true
                  
                }
                
            }
            
            else {
                withAnimation(.spring()) {
                    showblacknav = false
                    
                }
                
                
            }
            
            
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
                
                if viewState.height > 10 {
                   
                   
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
    

   
}
