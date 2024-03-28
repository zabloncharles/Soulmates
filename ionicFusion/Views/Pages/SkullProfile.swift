//
//  SkullProfile.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/27/23.
//

import SwiftUI


struct SkullProfile: View {
    @AppStorage("hidemainTab") var hidemainTab = false
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
    @State var scrolledItem = 0
    @State var profileNumber = 0
    @Binding var currentIndex : Int
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        
        ZStack {
          
            
            Color("offwhite")
          
            
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
                        
                        cover
                            .background(scrollDetection)
                        
                        content
                        
                        
                    }
                    .coordinateSpace(name: "scroll")
                    .mask(RoundedRectangle(cornerRadius: viewState.width / 3))
                    .scaleEffect(-viewState.width/500 + 1)
                    .gesture(drag)
                    .onAppear{
                        // DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
                        profileNumber = profileNumber + 1
                    }.ignoresSafeArea()
                    
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
                    
                    
                }.animation(.spring(), value: dislike)
               
//            the name of the profile and the heart icon
                nameandheart
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
                    
                   // TextWriterAppear(typeText:animateapper ? "Loading..." : profile.firstname)
                   Text(profile.firstname)
                        .font(.title)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    
                    
                    
                }  .padding(.horizontal,12)
                    .padding(.vertical, 6)
                    .background(.ultraThinMaterial)
                    .cornerRadius(69)
                    
                
                Spacer()
                Button {
                    showProfile = false
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
            }.padding(.horizontal,25)
            Spacer()
        }.offset(y:60)
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
        
        VStack {
            
            
            
            
            VStack(alignment: .leading, spacing: 30.0) {
                
                
                
//                About me card
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
                .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 19, action: $liked)
                
               
                
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 0.1)
                
                VStack(alignment: .leading, spacing: 15.0){
                    
                    HStack {
                        
                        
                        Image(systemName: "hand.thumbsup")
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
                
                
                
                
                
                
                
                    
                    GetImageAndUrl(url:profile.images[0], imageUrl: $profileImages[0])
                        .frame(width: UIScreen.main.bounds.width - 22, height: 400)
                    
                        .cornerRadius(13)
                        .neoDoubleTapButton(isToggle: false, perform: {
                            //when first image is clicked
                            liked = true
                            likedImage = profileImages[0]
                            
                        })
                
                
                
                
                
                
                
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
                    .padding()
                    .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 18, action: $liked)
                    .padding(.bottom,5)
                
                
                
               
                                  
                    GetImageAndUrl(url:profile.images[1], imageUrl: $profileImages[1])
                 .frame(width: UIScreen.main.bounds.width - 22, height: 400)
                
                    .cornerRadius(13)
                    .neoDoubleTapButton(isToggle: false, perform: {
                        //when first image is clicked
                        liked = true
                        likedImage = profileImages[0]
                        
                    })
                   
                
                
                
                
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
                    .padding(20)
                
                    .offwhitebutton(isTapped: liked, isToggle: true, cornerRadius: 20, action: $showMore)
                
                    .padding(.bottom,95)
                
                
            }
            
            .padding(.top,-10)
            .padding(10)
            
            
            
            
            
            
        }.padding(.bottom,-70)
        
        
        
        
        
        
        
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
    

   
}
