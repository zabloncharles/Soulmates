//
//  SkullProfile.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/27/23.
//

import SwiftUI


struct SkullProfile: View {
    @State  var previousOffset: CGFloat = 0
    @State var showblacknav = false
    @AppStorage("currentPage") var selected = 0
    @State var profiles: [UserStruct] = compatibleFakeUsers
    @Binding var currentUser: UserStruct?
    @AppStorage("hidemainTab") var hidemainTab = false
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
    @State var profileImages = ["",""]
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
                    .blur(radius: liked ? 10 : 0)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            liked = false
                            sendMessageFocused = false
                        }
                    }
                    .ignoresSafeArea()
                    
                    //the send text view that comes after liking a potential match
                   
                        ZStack {
                            LinearGradient(colors: [Color("offwhite"),Color.clear,Color("offwhite")], startPoint: .bottom, endPoint: .top)
                                .animation(.easeInOut, value: liked)
                                
                            VStack {
                                nameandheart
                                    .offset(y:40)
                                Spacer()
                            }
                            
                            likedcontent
                                .animation(.spring(), value: liked)
                                .offset(y:110)
                               
                           
                            
                        }
                        .cornerRadius(liked ? 0 : 15)
                        .offset(y: !liked ? UIScreen.main.bounds.height * 1.30 : 0)

                  
                                      
                      
                    
                            
                      
                    
                }.animation(.spring(), value: dislike)
               
            nameandheartnav
                .opacity(liked ? 0 : currentUser?.email == profile.email ? 0 : 1)
            
            
       
              
            
        }.background(Color("offwhite"))
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
        .onChange(of: liked) { V in
            if liked {
                hidemainTab = true
            } else {
                hidemainTab = false
            }
        }
    }
    var nameandheart: some View{
       
            HStack {
                HStack(spacing: 3.0) {
                    
                
                   
                    Text(currentUser?.email == profile.email ? "Profile" : "Match")
                            .font(.title)
                        .bold()
                
                    
                    Image(systemName:currentUser?.email == profile.email ?  "person.crop.circle" : "person.2")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    
                 
                    
                    
                }
                    .padding(.vertical, 6)
                 
                
                 
                    
                
                Spacer()
                Button {
                    withAnimation(.spring()) {
                        showProfile = false
                    }
                    withAnimation {
                       // if currentIndex != profiles.count - 1 {
                            currentIndex += 1
                       // }
                        
                    }
                
                    
                } label: {
                    if !liked {
                        Image(systemName:currentUser?.email == profile.email ?  "gear" : "heart.slash")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(currentUser?.email == profile.email ?  Color("black") : .red)
                    } else {
                        
                        Image(systemName: "heart.slash.fill")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        
                    }
                    
                    
                }
                
            }.padding(.horizontal,25)
            .background(
                GeometryReader { geometry in
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color("black").opacity(0.12)) // Adjust color as needed
                        .padding(.top, geometry.size.height) // Position the border at the bottom
                }
            )
           
       
    }
    var nameandheartnav: some View{
        VStack {
            HStack {
                HStack {
                    
                    
                    HStack(spacing: 2){
                        Text(profile.firstname)
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
                        showProfile = false
                    }
                  
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
                
                .frame(height: 190)
                
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
                    GetImageAndUrl(url:"", loaded: .constant(true), imageUrl: .constant(""))
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
                        .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 6, action: $liked)
                        
                        
                        
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
                        .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 6, action: $liked)
                        
                        VStack{
                            Spacer()
                        }.frame(width: 1, height: 12)
                            .background(Color("black"))
                        
                        VStack{
                            Image(systemName: "mappin.and.ellipse")
                            Text("1,200M")
                        }
                        .padding(.horizontal,10)
                        .padding(.vertical,4)
                        .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 6, action: $liked)
                    }
                    
                    
                    if (currentUser?.email == profile.email){
                        
                  
                    HStack{
                        Spacer()
                        Text("Edit Profile")
                            .foregroundColor(Color("white"))
                           
                        Spacer()
                    }.background(.blue)
                        .padding(.horizontal,10)
                        .padding(.vertical,5)
                        .background(.blue)
                        .cornerRadius(6)
                        .padding(.horizontal,70)
                    }
                }
                
               
                
                Spacer()
            }
            Spacer()
            
            VStack {
                HStack(spacing: 2){
                    Text(profile.firstname)
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
                    Text("I love going out hiking and fishing :)")
                    Spacer()
                }
               
            } .padding(.top,20)
        }.padding(.leading,20)
    }
    
    var moreinfohorizontalcards: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack {
                ZStack {
                   
                    HStack(spacing: 3.9){
                        Image(systemName: "graduationcap")
                            .font(.system(size: 18, weight: .medium))
                        
                        
                        Text( profile.education)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                        
                    }.foregroundColor(Color("black"))
                        .padding(.horizontal,5)
                    .padding(.vertical,4)
                    .background(Color("offwhite"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("black"), lineWidth: 1)
                        
                    )
                    .cornerRadius(8)
                    
                   
                }
                  
                   
                
                VStack{
                    Spacer()
                }.frame(width: 1, height: 12)
                    .background(Color("black"))
                
                HStack {
                    Image(systemName: "building")
                        .font(.system(size: 18, weight: .medium))
                    
                    Text( "Works in \(profile.work)")
                    // Text("Works in \(profile.work)")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                }.foregroundColor(Color("black"))
                    .padding(.horizontal,5)
                    .padding(.vertical,4)
                    .background(Color("offwhite"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("black"), lineWidth: 1)
                        
                    )
                    .cornerRadius(8)
                   
                
                VStack{
                    Spacer()
                }.frame(width: 1, height: 12)
                    .background(Color("black"))
                
                HStack {
                    Image(systemName: "location")
                        .font(.system(size: 18, weight: .medium))
                    
                    
                    HStack {
                        //  DistanceView()
                        Text( profile.location[0])
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                        
                    }
                    
                }.foregroundColor(Color("black"))
                    .padding(.horizontal,5)
                    .padding(.vertical,4)
                    .background(Color("offwhite"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("black"), lineWidth: 1)
                        
                    )
                    .cornerRadius(8)
                
                  
                
                VStack{
                    Spacer()
                }.frame(width: 1, height: 12)
                    .background(Color("black"))
            }
            .padding(.leading,20)
            
          
            
        }
    }
    var whatilike: some View{
        VStack(alignment: .leading, spacing: 15.0){
            
            HStack {
                
                
                
                
                HStack {
                    Text(profile.firstname)
                        .bold()
                        .font(.subheadline)
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 18, weight: .medium))
                    Text("2d")
                    
                        .font(.callout)
                    
                    Spacer()
                    Image(systemName: "ellipsis")
                }.padding(.trailing,10)
                Spacer()
            }
            Text("\"Fun loving and looking to settle up with this stuff and do me. its really not like that said no one ever.\"")
            
                .font(.callout)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
                .padding(.trailing,10)
            
            
            
            HStack {
                ForEach(profile.likes, id: \.self) { like in
                    LikesPill(placeholder: like)
                }
                
                
            }
        }.foregroundColor(Color("black"))
            .padding(.leading,20)
    }
    var content: some View {
        
      
            
            
            
            
            VStack(alignment: .leading, spacing: 20.0) {
                
                nameandheart
             
                
               avatarandthreeinfo
                   
                 
               
                
                
//                About me card
                VStack(alignment: .leading, spacing: 13.0) {
                    
                   
                        moreinfohorizontalcards
                       
                    
                        Divider()
                     
                    
                       
                        
                    VStack {
                        GetImageAndUrl(url:"", loaded: .constant(true), imageUrl: $profileImages[0])
                            .frame(width:UIScreen.main.bounds.width, height: 400)
                            .cornerRadius(0)
                            .neoDoubleTapButton(isToggle: false, perform: {
                                //when first image is clicked
                                likedImage = profileImages[0]
                                    liked = true
                            })
                        
                        VStack {
                            HStack {
                                HStack(spacing:4) {
                                    Text(profile.firstname)
                                        .bold()
                                    .font(.subheadline)
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 18, weight: .medium))
                                }
                                
                                Text("2d")
                                    .font(.callout)
                                Spacer()
                                Image(systemName: "ellipsis")
                            }.padding(.trailing,20)
                            Spacer()
                            
                            HStack {
                                VStack {
                                    Image(systemName: "quote.opening")
                                        .font(.system(size: 18, weight: .medium))
                                    
                                }
                                Text("this is how i like to unwind")
                                    .font(.callout)
                                    .italic()
                                
                                Spacer()
                            }.padding(.trailing,10)
                        }
                        .padding(.leading,20)
                        .padding(.vertical)
                        .background(Color("offwhite"))
                        .padding(.top,-10)
                    }
                        
                 
                    
                    
                    
                    
                    
                    Divider()
//                    Likes Pill
                  whatilike
                    
                      Divider()
                    
                    
                   
                    
                        
                        VStack {
                            GetImageAndUrl(url:profileImages[1], loaded:.constant(true),imageUrl: $profileImages[1])
                                .frame(width:UIScreen.main.bounds.width, height: 400)
                            
                                .cornerRadius(0)
//
                                .neoDoubleTapButton(isToggle: false, perform: {
                                    //when first image is clicked
                                    liked = true
                                    likedImage = profileImages[1]
                                    
                                })
                            
                            VStack {
                              
                                    
                                    
                                    
                                    
                                    HStack {
                                        HStack(spacing:4) {
                                            Text(profile.firstname)
                                                .bold()
                                                .font(.subheadline)
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(.blue)
                                                .font(.system(size: 18, weight: .medium))
                                        }
                                        Text("2d")
                                        
                                            .font(.callout)
                                        
                                        Spacer()
                                        Image(systemName: "ellipsis")
                                    }.padding(.trailing,20)
                                    Spacer()
                               
                                HStack {
                                    VStack {
                                        Image(systemName: "quote.opening")
                                            .font(.system(size: 18, weight: .medium))
                                        
                                    }
                                    Text("When i knew my modeling career was over. i was devastated")
                                        .font(.callout)
                                        .italic()
                                    
                                    Spacer()
                                }.padding(.trailing,10)
                            }
                            .padding(.leading,20)
                            .padding(.vertical)
                            .background(Color("offwhite"))
                                .padding(.top,-10)
                        }
                  
                    
                    Divider()
                    
                    
                    
                   answerprompt
                    
                    
                    
                    
                    
                }
                
            }
            
            .padding(.top,40)
           
            .padding(.bottom,120)
            
            
            
            
            
            
        
        
        
        
        
        
        
        
    }
    
    var answerprompt: some View{
        VStack(alignment: .leading, spacing: 15.0){
            
            HStack {
                
                
                
                
                HStack {
                    HStack(spacing:4) {
                        Text(profile.firstname)
                            .bold()
                            .font(.subheadline)
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 18, weight: .medium))
                    }
                    Text("2d")
                    
                        .font(.callout)
                    
                    Spacer()
                    Image(systemName: "ellipsis")
                }.padding(.trailing,10)
                Spacer()
            }
            Text("\"I like going going out to clubs and studying for my mcat lol.\"")
            
                .font(.callout)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
            
            
            //                        the prompt
            HStack {
                VStack{
                    Spacer()
                }.frame(width: 1, height: .infinity)
                    .background(Color("black"))
                HStack {
                    Spacer()
                    Text("What do you like to do for fun?")
                        .bold()
                        .font(.callout)
                        .multilineTextAlignment(.trailing)
                        .lineLimit(3)
                    
                    
                }.padding(20)
                
                    .cornerRadius(12)
                    .padding(.leading,20)
            }
            
            
        }.foregroundColor(Color("black"))
        
            .padding(.leading,20)
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
            
            
           
            HStack {
                
          
                
                
                HStack {
                    HStack(spacing:4) {
                        Text(profile.firstname)
                            .bold()
                            .font(.title2)
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 18, weight: .medium))
                    }
                    Text("2d")
                    
                        .font(.callout)
                    
                    Spacer()
                    Image(systemName: "ellipsis")
                }
                Spacer()
            }.offset(y:40)
           
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
                .background(Color("offwhite"))
                .cornerRadius(15)
                .padding(.top, 30)
                .offset(y: liked ? 0 : -20)
            
            
            VStack {
                ZStack{
                    VStack{
                        Color("offwhite")
                    }
                    if liked {
                        GetImageAndUrl(url:likedImage, loaded: .constant(true), imageUrl: .constant(""))
//
                         
                    }
                    
                    
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
                TextField("Say Hi...", text: $sendMessage)
                
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
                               
                              
                            }
                            .offset(x: 155)
                    )
                    .offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 25, action:  .constant(false))
                    .padding(.horizontal,0)
                   
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
                    hidemainTab = false
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
                    withAnimation(.spring()) {
                        viewState = .zero
                    }
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
