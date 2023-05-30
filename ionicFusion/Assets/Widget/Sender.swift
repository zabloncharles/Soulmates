////
////  Sender.swift
////  ionicFusion
////
////  Created by Zablon Charles on 5/26/23.
////
//
////
////  MessagesView.swift
////  Fusion (iOS)
////
////  Created by Zablon Charles on 2/28/22.
////
//
//import SwiftUI
//import Firebase
//import FirebaseFirestore
//import FirebaseAuth
//
//struct SenderView: View {
//    @AppStorage("hidemainTab") var hidemainTab = false
//    @Environment(\.horizontalSizeClass) var horizontalSizeClass
//    @Environment(\.presentationMode) var presentationMode
//    @State var text = "yo"
//    //@Binding var section: NotificationModel
//    @State var hideNav = false
//    @State var scrolling = CGFloat(0)
//    @State var scrolledItem: Int = 0
//    @State private var chatMessages: [Message] = []
//    @State private var messageText = ""
//    @State private var sender = "John"
//    @State var guardSending = false
//    @State var userscrolled = false
//    @FocusState private var keyboardFocus: Bool
//    @State private var typing = false
//    @State private var typedText = ""
//    @State var btapped = 0
//    @State var blurPage = false
//    @State var messageDeleted = false
//    @State private var scrollToBottom: Bool = false
//    @State private var selectedOption = 0
//   @State  var usertext = ""
//    @State var profiles: [UserStruct] = []// Array to hold the user data
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                BackgroundView()
//                content
//                
//                cover
//                
//                texting
//                // Text(userscrolled ? "yes he scrolled" : "no he didtn scroll")
//                
//            }
//            .zIndex(1)
//        }.onAppear{
//            withAnimation(.spring()) {
//                hidemainTab = false
//            }
//        }
//        .onDisappear {
//            withAnimation(.spring()) {
//                hidemainTab = false
//            }
//        }
//    }
//    
//    var cover: some View {
//        VStack {
//            VStack {
//                Spacer()
//            }
//            .frame(maxWidth: .infinity)
//            .frame(height: 110)
//            
//            .background(
//                // Image(section.background)
//                // Image("image_10")
//                //  .resizable(resizingMode: .stretch)
//                // .aspectRatio(contentMode: .fill)
//                //  .accessibility(hidden: true)
//                ImageViewer(url: "")
//            )
//            .mask(
//                RoundedRectangle(cornerRadius: 0)
//            )
//            
//            .overlay(
//                VStack(alignment: .leading, spacing: 8) {
//                    
//                    
//                    HStack {
//                        // Image(holdData.name)
//                        //     .resizable(resizingMode: .stretch)
//                        //   .aspectRatio(contentMode: .fill)
//                        ImageViewer(url: "")
//                            .cornerRadius(80)
//                            .mask(Circle())
//                            .background(
//                                Circle()
//                                    .fill(Color.blue)
//                                    .padding(-2)
//                                
//                            )
//                            .frame(width: 60, height: 60)
//                            .padding(10)
//                        VStack{
//                            Text("holdData.name")
//                                .font(.title2).bold()
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                                .foregroundColor(.primary)
//                            
//                            HStack(spacing:2) {
//                                Image(systemName: "circlebadge.fill")
//                                    .foregroundColor( .green)
//                                    .font(.caption2)
//                                Text("Was online 5 minutes ago")
//                                    .font(.footnote)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                    .foregroundColor(.primary.opacity(0.7))
//                            }
//                            
//                        }
//                        Spacer()
//                        
//                        Image(systemName: "exclamationmark.circle")
//                            .foregroundColor(.gray )
//                            .font(.title2)
//                            .padding(.trailing,10)
//                    }
//                    
//                    
//                    
//                    
//                    
//                }
//                    .background(Color("white").opacity(0.6))
//                
//                    .offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 15, action: .constant(false))
//                
//                
//                    .frame(maxHeight: .infinity, alignment: .bottom)
//                    .padding(20)
//                    .offset(y: 80)
//            )
//            VStack {
//                TextField("Type your message", text: $usertext)
//                    .padding(.vertical)
//                    .padding(.leading, 55)
//                    .foregroundColor(.gray)
//                    .background(Color("offwhite"))
//                    .cornerRadius(25)
//                    .overlay(  Image(systemName: "pencil.circle.fill")
//                        .font(.largeTitle)
//                        .foregroundColor(.white)
//                        .offset(x: -145)
//                    )
//                .offwhitebutton(isTapped: keyboardFocus, isToggle: true, cornerRadius: 25, action:  $typing)
//                .padding(.horizontal,45)
//                
//                VStack(spacing: 30.0){
//                    ForEach(profiles) { item in
//                        Text(item.firstname)
//                            .padding()
//                            .background(Color.blue)
//                            .cornerRadius(10)
//                            .onTapGesture {
//                                usertext = item.email
//                        }
//                    }
//                   
//                }.onAppear{
//                    fetchUsers()
//                }
//            }
//            
//            Spacer()
//        }//.offset(y: CGFloat(scrolledItem - 20))
//        .offset(y: userscrolled ? -40 : 0)
//        .edgesIgnoringSafeArea(.all)
//    }
//    
//    var content: some View {
//        ScrollViewReader { scrollViewProxy in
//            ScrollView {
//                scrollDetection
//                VStack{
//                    
//                    VStack {
//                        
//                        
//                        
//                        
//                        VStack {
//                            LazyVStack {
//                                ForEach(chatMessages.sorted(by: { $1.timestamp > $0.timestamp })) {section in
//                                    
//                                    
//                                    MessageBubble1(section: section, blurPage: $blurPage, messageDeleted: $messageDeleted, bTapped: btapped)
//                                        .onLongPressGesture {
//                                            blurPage.toggle()
//                                            btapped =  Int(section.documentID) ?? 0
//                                            
//                                            
//                                            
//                                            
//                                        }
//                                        .opacity( messageDeleted && btapped == Int(section.documentID) ?? 0 ? 0 : 1)
//                                        .blur(radius: btapped == Int(section.documentID) ?? 0 ? 0 :  blurPage ? 13 : 0)
//                                        .id(section.id)
//                                        .onAppear {
//                                            
//                                            // withAnimation {
//                                            scrollViewProxy.scrollTo((chatMessages.last?.id), anchor: .bottom)
//                                            scrollToBottom = true
//                                            
//                                            //  }
//                                        }
//                                    
//                                    
//                                }
//                                
//                            }
//                        }
//                        .coordinateSpace(name: "scrollView")
//                    }
//                    .onChange(of: messageDeleted) { newValue in
//                        if messageDeleted {
//                            blurPage = false
//                            
//                            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
//                                
//                                
//                                deleteMessage(messageID: "\(btapped)")
//                            }
//                            
//                            typeWriteText("Message deleted!") {
//                                //Message was deleted
//                                messageDeleted = false
//                            }
//                        }
//                    }
//                    
//                }
//                
//                
//                
//                
//                .padding(.top, 130)
//                .coordinateSpace(name: "scroll")
//            }.background( Color("offwhiteneo"))
//                .onTapGesture{
//                    blurPage = false
//                }
//            // .overlay(Text("\(scrolledItem)"))
//                .onTapGesture{
//                    keyboardFocus = false
//                }
//                .onAppear{
//                    fetchMessages()
//                }
//            
//        }.padding(.bottom, 96)
//        
//    }
//    var texting: some View {
//        
//        
//        VStack{
//            Spacer()
//            // Usage example
//            
//            
//            HStack {
//                TextField("Type your message", text: $messageText)
//                    .padding(.vertical)
//                    .padding(.leading, 55)
//                    .foregroundColor(guardSending ? .gray : Color("black"))
//                    .background(Color("offwhite"))
//                    .focused($keyboardFocus)
//                    .cornerRadius(25)
//                    .overlay(  Image(systemName: "pencil.circle.fill")
//                        .font(.largeTitle)
//                        .foregroundColor(.white)
//                        .offset(x: -145)
//                    )
//                    .offwhitebutton(isTapped: keyboardFocus, isToggle: true, cornerRadius: 25, action:  $typing)
//                    .onChange(of: typing) { newValue in
//                        if keyboardFocus {
//                            typing = true
//                        } else {
//                            typing = false
//                        }
//                    }
//                
//                Image(systemName: "arrow.up.circle.fill")
//                    .font(.largeTitle)
//                    .foregroundColor(messageText.count < 1 ? .gray : guardSending ? .red : .blue)
//                    .neumorphiccircle(padding: -5, opacity: 1)
//                    .onTapGesture{
//                        if messageText.count > 0 && !guardSending{
//                            sendMessage(text: messageText, sender: sender)
//                            messageText = ""
//                        } else {
//                            if !guardSending {
//                                typeWriteText("You haven't typed anything bro :/") {
//                                    print("Typing finished")
//                                }
//                            }
//                        }
//                        
//                    }
//                
//            }.padding()
//            // .background(Color("offwhite"))
//                .background(
//                    ZStack{
//                        Rectangle()
//                            .fill(Color.black)
//                            .frame(width: .infinity,height: 190)
//                            .cornerRadius(35)
//                            .offset(y:55)
//                        Rectangle()
//                            .fill(.ultraThinMaterial.opacity(0.5))
//                            .frame(width: .infinity,height: 190)
//                            .cornerRadius(35)
//                            .offset(y:55)
//                    }
//                    
//                    
//                )
//            
//        }
//        
//        
//    }
//    var scrollDetection: some View {
//        GeometryReader { proxy in
//            let offset = proxy.frame(in: .named("scroll")).minY
//            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
//        }
//        .onPreferenceChange(ScrollPreferenceKey.self) { offset in
//            withAnimation(.easeInOut) {
//                scrolledItem = Int(offset)
//                keyboardFocus = false
//                typing = false
//                
//                
//                
//                if offset < 11 || offset > 50 {
//                    
//                    withAnimation(.spring()) {
//                        hideNav = true
//                        
//                    }
//                    
//                }
//                
//                else {
//                    withAnimation(.spring()) {
//                        hideNav = false
//                    }
//                    
//                    
//                }
//                
//            }
//        }
//        .onChange(of: scrolledItem) { newValue in
//            
//            
//            withAnimation(.spring()) {
//                userscrolled = true
//            }
//            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { timer in
//                withAnimation(.spring()) {
//                    userscrolled = false
//                }
//            }
//            
//            
//            
//            
//        }
//    }
//    func typeWriteText(_ text: String, completion: @escaping () -> Void) {
//        let original = messageText
//        messageText = ""
//        var currentIndex = 0
//        guardSending = true
//        Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { timer in
//            if currentIndex < text.count {
//                let index = text.index(text.startIndex, offsetBy: currentIndex)
//                let character = text[index]
//                
//                DispatchQueue.main.async {
//                    withAnimation(.easeIn) {
//                        messageText += String(character)
//                    } // Update the typedText property on the main queue
//                }
//                
//                currentIndex += 1
//            } else {
//                
//                timer.invalidate()
//                completion()
//                Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
//                    withAnimation(.easeInOut) {
//                        messageText = original
//                        
//                        guardSending = false
//                    }
//                }
//                
//            }
//        }
//    }
//    
//    func sendMessage(text: String, sender: String) {
//        if usertext.count > 1 {
//            ///
//        } else {
//            return
//        }
//        let db = Firestore.firestore()
//        let user = Auth.auth().currentUser
//        let collectionRef = db.collection("messages")
//        
//        collectionRef ///the one thats sending
//            .whereField("email", arrayContains: "zab.charles@gmail.com") // Query condition
//            .getDocuments { (snapshot, error) in
//                guard let documents = snapshot?.documents else {
//                    // Handle error
//                    return
//                }
//                
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "MMM d, yyyy 'at' h:mm:ss a"
//                let timeinstring = dateFormatter.string(from: Date())
//                
//                
//                for document in documents {
//                    let documentRef = collectionRef.document(document.documentID).collection("log").document()
//                    
//                    // Update the document with new data
//                    documentRef.setData([
//                        "text": text,
//                        "time":  timeinstring,
//                        "sender": usertext ?? ""
//                        // Add other fields as needed
//                    ], merge: false) { error in
//                        if let error = error {
//                            // Handle error
//                        } else {
//                            // Data added successfully
//                        }
//                    }
//                }
//            }
//    }
//    
//    private func fetchUsers() {
//        let db = Firestore.firestore()
//        let user = Auth.auth().currentUser
//        let usersRef = db.collection("users")
//            //.whereField("email", isNotEqualTo: user?.email ?? "")
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
//    
//      private func fetchMessages() {
//            let db = Firestore.firestore()
//          let usersRef = db.collection("messages").document("o5zCtH1v82wgfb9QOFgu").collection("log")
//                .addSnapshotListener { snapshot, error in
//                    guard let documents = snapshot?.documents else {
//                        print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
//                        return
//                    }
//    
//                    // Process the updated documents and update your UI accordingly
//                    // For example, you can update an @State variable holding chat messages
//                    let messages = documents.map { document -> Message in
//                        let data = document.data()
//                        let name = data["name"] as? String ?? ""
//                        let docid = data["documentID"] as? String ?? ""
//                        let text = data["text"] as? String ?? ""
//                        let sender = data["sender"] as? String ?? ""
//                        let timestamp = data["time"] as? String ?? ""
//                        return Message(documentID: docid, name: name, text: text, sender: sender, timestamp: timestamp)
//    
//                    }
//                    self.chatMessages = messages
//                }
//    
//     }
//    func getTimeString()-> String{
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        return dateFormatter.string(from: Date())
//    }
// 
////    func fetchMessages() {
////        let fakeMessages = [
////            Message(documentID: "0", name: "John", text: "?", sender: true, timestamp: "10:30 AM"),
////            Message(documentID: "1", name: "John", text: "Hello", sender: true, timestamp: "10:30 AM"),
////            Message(documentID: "2", name: "Alice", text: "Hi there", sender: false, timestamp: "10:35 AM"),
////            Message(documentID: "3", name: "John", text: "How are you?", sender: true, timestamp: "10:40 AM"),
////            Message(documentID: "4", name: "Alice", text: "I'm doing great!", sender: false, timestamp: "10:45 AM")
////            // Add more fake messages as needed
////        ]
////
////
////        chatMessages = fakeMessages
////    }
//    func deleteMessage(messageID: String) {
//        withAnimation {
//            chatMessages.remove(at: Int(messageID) ?? 0)
//        }
//    }
//    
//    //    func deleteMessage(messageID: String) {
//    //        let db = Firestore.firestore()
//    //        let messageRef = db.collection("users").document("E2FzpaP15CVyce9uvimm").collection("messages").document("Uq85VmqlQged6RRDNg0y").collection("messages").document("individual").collection("9oU5CqpvCwCDAezknYLG").document(messageID)
//    //
//    //        messageRef.delete { error in
//    //            if let error = error {
//    //                print("Error deleting message: \(error.localizedDescription)")
//    //            } else {
//    //                print("Message deleted successfully")
//    //            }
//    //        }
//    //    }
//    
//    
//    
//}
//
//
//struct SenderViewView_Previews: PreviewProvider {
//    static var previews: some View {
//        // MessagesView(section: .constant(messageSections[0]))
//        ViewController()
//    }
//}
//
//
