//
//  ViewProfileView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/30/23.
//

import SwiftUI



struct ViewProfileView_Previews: PreviewProvider {
  //  @Namespace var namespace
    static var previews: some View {
      //  ViewProfileView(namespace: namespace)
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
    // @Binding var user: UserStruct? // Variable to hold the user dat
    var profile = userStruct[0]
    @ObservedObject var viewModel = UserViewModel()
    var isAnimated = true

    @State var viewState: CGSize = .zero
    @State var selectedSection = courseSections[0]
    @State var selectedItem = matchDummy[0]
    @State var showProfile = true
    @State var text = ""
    @State var erro = ""
    @State var typeText = ""
    @Binding var dislike : Bool
    @FocusState var isfocused
    @State var animateapper = false
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
                        likedcontent
                    }
                    
                    
                }.animation(.spring(), value: dislike)
            
                  //  .opacity(dislike ? 0 :1 )
                    .offset(y: !animateapper ? UIScreen.main.bounds.height * 1.02 : 0)
                    .onAppear{
                        hidemainTab = true
                        withAnimation(.spring()) {
                            animateapper = true
                        }
                    }
                    .onDisappear{
                       // hidemainTab = false
                        withAnimation(.spring()) {
                            animateapper = false
                        }
                    }
                    
                
                
            
            if showProfile {
                nameandheart
            }
        }.onChange(of: liked) { newValue in
            if liked {
                hidemainTab = true
            }
        }
        
        
        
        
        
        
        
        
        
    }
    var nameandheart: some View{
        VStack {
            HStack {
                HStack {
                    TextWriterAppear(typeText: profile.firstname, speed: 0.03)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    
                } .padding(10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                
                Spacer()
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
                //  Image(matchcard.background)
                //      .resizable()
                //  .aspectRatio(contentMode: .fill)
                GetImageAlert(url:profile.avatar,loaded: $profileLoaded)
                
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                    .blur(radius: scrollY > 0 ? scrollY / 10 : 0)
                    .accessibility(hidden: true)
                    .matchedGeometryEffect(id: "profileimage", in: namespace)
                
            )
            
            .cornerRadius(8)
            
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
                        ImageViewer(url: profile.images[0] )
                        
                            .frame(minHeight:  400)
                        
                    }
                    
                }.padding(-20)
                    .padding(.bottom,20)
                    .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 14, action: $liked)
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
                        ImageViewer(url: profile.images[1] )
                        
                            .frame(maxWidth: 500 , minHeight:  400)
                        
                        
                    }
                    
                }.padding(-20)
                    .padding(.bottom,20)
                    .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 14, action: $liked)
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
                    Text("As seen on my mom's fridge")
                    Image(systemName: "quote.closing")
                }
            }.padding(15).offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 15, action:  .constant(false))
                .padding(.top, 70)
                .offset(y: liked ? 0 : -20)
                
            
            VStack {
                ImageViewer(url: profile.avatar)
                
                    .frame(width: 400 , height: 400)
            }.offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 20, action:  .constant(false))
                .matchedGeometryEffect(id: "profileimage", in: namespace)
            
            
            
            
            
            
            HStack {
                TextField("Send a message", text: $text)
                    .focused($isfocused)
                    .padding(.vertical,16)
                    .padding(.leading, 55)
                    .foregroundColor(Color("black"))
                    .background(Color("offwhite"))
                    .cornerRadius(25)
                    .overlay(  Image(systemName: "pencil.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .offset(x: -139)
                    )
                    .offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 25, action:  .constant(false))
                    .padding(.horizontal,0)
                    .onChange(of: isfocused) { newValue in
                        if isfocused {
                            hidemainTab = true
                        }
                    }
                
                
                HStack {
                    Image(systemName: "paperplane")
                        .font(.headline)
                        .foregroundColor(.white)
                        .onTapGesture {
                            // sendMatchMessage(text: text)
                        }
                }.padding()
                    .background(Color.pink)
                
                    .offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 30, action:  .constant(false))
                
                
                
            }
            
            
            Text("Cancel")
                .padding(.vertical,10)
                .padding(.horizontal,60)
                .background(Color("offwhite"))
                .cornerRadius(20)
                .neoButton(isToggle: false) {
                    //
                    liked = false
                }
                .padding(.top,10)
            Spacer()
        }.padding(.horizontal, 20)
            .background(BackgroundView())
            .onAppear{
               
                withAnimation(.spring()) {
                    hidemainTab = true
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
                scrolledItem = Int(offset)
                
                
                
                
                
                if offset < -15 {
                    
                    withAnimation(.spring()) {
                       // hidemainTab = true
                        
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



