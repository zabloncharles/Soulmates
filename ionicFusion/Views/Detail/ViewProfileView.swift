//
//  ViewProfileView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/30/23.
//

import SwiftUI



struct ViewProfileView_Previews: PreviewProvider {
      @Namespace var namespace
    static var previews: some View {
     //   ViewProfileView(namespace: namespace, dislike: .constant(false), scrolling: .constant(T##value: Bool##Bool))
      ViewController()
    }
}



import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct ViewProfileView: View {
    @AppStorage("hidemainTab") var hidemainTab = false
    var namespace: Namespace.ID
    var profile = userStruct[0]
    var isAnimated = true
    @State var viewState: CGSize = .zero
    @State var likedImage = ""
    @State var sendMessage = ""
    @FocusState var sendMessageFocused: Bool
    @State var showProfile = true
    @State var text = ""
    @State var erro = ""
    @State var typeText = ""
    @State var profileImages = ["","",""]
    @State var likedAppeared = false
    @State var animatehearts = false
    @Binding var dislike : Bool
    @Binding var scrolling : Bool
    @FocusState var isfocused
    @State var animateapper = false
    @State var roundEntrance = false
    @State var profileLoaded = false
    @State var animategirl = false
    @State var liked = false
    @State var cancelLike = false
    @State var showMore = false
    @State var scrolledItem = 0
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        
        ZStack {
            
            BackgroundView()
            
            ZStack {
                
                
                ScrollView {
                    
                    cover
                        .background(scrollDetection)
                    //  .offset(y:dislike ? -570 : 0)
                    //  .matchedGeometryEffect(id: "som\(matchcard.usernumber)", in: namespace)
                    
                    content
                    // .offset(y: dislike ? 650 : 0)
                    
                    
                }
                .coordinateSpace(name: "scroll")
                .mask(RoundedRectangle(cornerRadius: viewState.width / 3))
                .scaleEffect(-viewState.width/500 + 1)
                .gesture(drag)
                
                .ignoresSafeArea()
                
                if liked  {
                    ZStack {
                        LinearGradient(colors: [Color("white").opacity(0.94), Color.clear,Color.clear], startPoint: .bottom, endPoint: .top)
                            .animation(.easeInOut.speed(0.65), value: hidemainTab)
                            .opacity(hidemainTab ? 1 : 0)
                            .onAppear{
                                hidemainTab = true
                            }
                            .onTapGesture {
                                //hideKeyboard
                                sendMessageFocused = false
                            }
                        likedcontent
                            .animation(.easeInOut.delay(0.05), value: hidemainTab)
                            .offset(y: !hidemainTab ? UIScreen.main.bounds.height * 1.02 : 0)
                        
                        
                    }.background(.ultraThinMaterial)
                        .edgesIgnoringSafeArea(.all)
                }
                
                
                //    Text("scrolled by \(scrolledItem)")
                
                
            }.animation(.spring(), value: dislike)
            
            //  .opacity(dislike ? 0 :1 )
            
                .offset(y: !animateapper ? UIScreen.main.bounds.height * 1.02 : 0)
                .onAppear{
                    withAnimation(.spring()) {
                        animateapper = true
                        
//                        roundEntrance =  true
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1)  {
//
//                            withAnimation(.spring()) {
//                                roundEntrance =  false
//                            }
//                        }
                    }
                    
                    
                }
                .onDisappear{
                    withAnimation(.spring()) {
                        animateapper = false
                    }
                }
            
            
            
            
            if showProfile {
                nameandheart
            }
            
            
        }.onAppear{
            withAnimation(.spring()) {
                hidemainTab = true
            }
        }
      
        
        
        
        
        
        
        
        
        
    }
    var nameandheart: some View{
        VStack {
            HStack {
                HStack {
                    //  TextWriterAppear(typeText: profile.firstname, speed: 0.03)
                    Text(profile.firstname)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    
                } .padding(10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                
                Spacer()
                
                //The user doesn't like current shuffle card.
                Button {
                    
                    withAnimation(.spring()) {
                        dislike = false
                    }
                    
                } label: {
                    Image(systemName: "heart.slash")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                    
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
                VStack{
                    
                    GetImageAndUrl(url:profile.avatar, loaded: .constant(true), imageUrl: .constant(""))
                        .offset(y: scrollY > 0 ? -scrollY : 0)
                        .scaleEffect(liked ? 1.4 : scrollY > 0 ? scrollY / 1000 + 1 : 1)
                        .blur(radius: liked ? 14 : scrollY > 0 ? scrollY / 10 : 0)
                        .animation(.spring(), value: liked)
                })
            
        }
        .frame(height: 400)
        .overlay(
            
            LinearGradient(colors: [Color.clear,Color("white"),Color.clear], startPoint: .top, endPoint: .bottom)
                .offset(y:350)
            
            
        )
        
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
                
                
                
                
                
                
              
                    VStack {
                        // ImageViewer(url: profile.images[0] )
                        GetImageAndUrl(url:profile.images[0], loaded: .constant(true), imageUrl: $profileImages[0])
                           // .frame(width: UIScreen.main.bounds.width - 52, height: 400)
                        
                    }.frame(width: UIScreen.main.bounds.width - 22, height: 400)
                    
                    .cornerRadius(13)
                    .neoButton(isToggle: false, perform: {
                        //when first image is clicked
                        liked = true
                        likedImage = profileImages[0]
                        
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
                    .padding(.bottom,5)
                
                
                    VStack {
                        
                        GetImageAndUrl(url:profile.images[1], loaded: .constant(true), imageUrl: $profileImages[1])
                        
                        
                        
                    }.frame(width: UIScreen.main.bounds.width - 22, height: 400)
                
                        
                        
                        //.padding(20)
                        
                        .cornerRadius(13)
                        .neoDoubleTapButton(isToggle: false, perform: {
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
                
                    .padding(.bottom,35)
                
                
                
                
            }
            
            .padding(.top,-10)
            .padding(10)
            
            VStack(alignment: .center) {
                HStack{
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(Color("offwhite"))
                        .cornerRadius(65)
                        .onTapGesture {
                            scrolling = false
                            hidemainTab = false
                        }
                }
            }.padding(.bottom,95)
                .padding(.top,-20)
            
            
            
            
        }.padding(.bottom,-70)
        
        
        
        
        
        
        
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
                    GetImageAndUrl(url:"", loaded: .constant(true), imageUrl: .constant(""))
                    // .matchedGeometryEffect(id: profile.avatar, in: namespace)
                    
                    
                    
                }
                
                .frame(width: 400 , height: 400)
            }
            .animation(.spring(), value: hidemainTab)
            .neoButtonOff(isToggle: false, cornerRadius: 15, perform: {
                //clicked you liked
                sendMessageFocused = false
            })
            .overlay(
                VStack {
                    if animatehearts {
                        LottieView(filename: "likedapost" ,loop: false)
                        .frame(width: 380)
                        .scaleEffect(animatehearts ? 1.2 : 1 )
                        .offset(x: 0, y: -60)
                   // .animation(.easeIn.delay(0.97), value: likedAppeared)
                    }
                }
                 
                   // .transition(.scale.combined(with: .opacity ))
                    
            )
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
                                //sendMatch()
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
            .offset(y:likedAppeared ? 110 : 220)
        // .background(Color.black.opacity(0.65))
        
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeIn) {
                        animatehearts = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeOut) {
                        animatehearts = false
                    }
                }
                withAnimation(.spring()) {
                    likedAppeared = true
                    hidemainTab = true
                    
                }
            }
            .onDisappear{
                
                withAnimation(.spring()) {
                    likedAppeared = false
                    
                }
            }
           
        
        
    }
    var scrollDetection: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { offset in
            withAnimation(.easeInOut) {
                // scrolledItem = Int(offset)
                
                
                
                
                
                if offset > 65 {
                    
                    withAnimation(.spring()) {
                        // hidemainTab = true
                        scrolling = false
                        
                    }
                    
                }
                
                else {
                    withAnimation(.spring()) {
                        //  hidemainTab = false
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
        //  let original = typeText
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
    
    func sendMatch(text: String) {
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        
        // Add a placeholder for the document ID
        
        
        let docRef = db.collection("messages").document()
        
        // Add the document with the modified data
        docRef.setData(["matched": true,
                        "time":  Date(),
                        "email": [user?.email ?? "" , "zab.charles@gmail.com"]
                        // Add other fields as needed
                       ], merge: true) { error in
            if let error = error {
                // Handle the error
                print("Error updating message data: \(error.localizedDescription)")
                return
            }
            
            // Data updated successfully
            print("Message data updated")
            
            // Perform additional operations
            // ...
        }
    }
    func getLocation(){
        
    }
}


