//
//  MessageDetailView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/19/23.
//



import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct MessageDetailView: View {
    @AppStorage("hidemainTab") var hidemainTab = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State var text = "yo"
    //@Binding var section: NotificationModel
    @State var hideNav = false
    @State var scrolling = CGFloat(0)
    @State var scrolledItem: Int = 0
    @State var chatMessages: [MessageModel] = []
    var log : MessageUser
    // var holdData : [IncomingMessage]
    @State private var messageText = ""
    @State private var sender = "John"
    @State var guardSending = false
    @State var userscrolled = false
    @FocusState private var keyboardFocus: Bool
    @State private var typing = false
    @State private var typedText = ""
    @State var scrollingUp = false
    @State var btapped = 0
    @State var blurPage = false
    @State var bubblesAppeared = false
    @State var messageDeleted = false
    @State private var scrollToBottom: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                content
                cover
                texting
                
            }
            .zIndex(1)
        }.navigationBarBackButtonHidden()
        .onAppear{
            withAnimation(.spring()) {
                hidemainTab = true
                chatMessages = messages
            }
        }
        .onDisappear {
            hidemainTab = false
            withAnimation(.spring()) {
                
            }
        }
    }
   
    var cover: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .neoButton(isToggle: false, perform: {
                        //go back to messages view
                        presentationMode.wrappedValue.dismiss()
                    })
//                    .onTapGesture {
//                        //go back to messages view
//                        presentationMode.wrappedValue.dismiss()
//                    }
                Image(log.avatar)
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                //  ImageViewer(url: "")
                    .cornerRadius(80)
                    .mask(Circle())
                    .background(
                        Circle()
                            .fill(Color.blue)
                            .padding(-2)
                        
                    )
                    .frame(width: 20, height: 40)
                    .padding(10)
                VStack{
                    Text(log.name.capitalized)
                    //  Text(log.docid)
                        .font(.title2).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.primary)
                    
                    HStack(spacing:2) {
                        Image(systemName: "circlebadge.fill")
                            .foregroundColor( .green)
                            .font(.caption2)
                        Text("Was online 5 minutes ago")
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.primary.opacity(0.7))
                    }
                    
                }.padding(.leading,5)
                Spacer()
                
                Image(systemName: "exclamationmark.circle")
                    .foregroundColor(.gray )
                    .font(.title2)
                    .padding(.trailing,10)
            }
            
            .padding(.horizontal,10)
            .padding(.top,45)
            .padding(.bottom,5)
            .background(
                LinearGradient(colors: [Color("white"),Color("white"),Color("white")], startPoint: .top, endPoint: .bottom))
            Spacer()
        }//.offset(y: CGFloat(scrolledItem - 20))
        //.offset(y: userscrolled ? -40 : 0)
        .edgesIgnoringSafeArea(.all)
    }
    
    var content: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView {
                scrollDetection
                VStack{
                    
                    VStack {
                        
                        
                        
                        
                        VStack {
                            LazyVStack {
                                ForEach(chatMessages.sorted(by: { $1.timestamp > $0.timestamp })) {section in
                                    
                              //  ForEach(chatMessages) {section in
                                    
                                   // Text(section.text)
                                    MessageBubblesView(section: section, blurPage: $blurPage, messageDeleted: $messageDeleted)
                                      
                                        .opacity(bubblesAppeared ? 1 : 0.30)
                                        .onLongPressGesture {
                                            blurPage.toggle()
                                           // btapped =  Int(section.documentID) ?? 0
                                            
                                            
                                            
                                            
                                        }
                                       // .opacity( messageDeleted && btapped == Int(section.documentID) ?? 0 ? 0 : 1)
                                       // .blur(radius: btapped == Int(section.documentID) ?? 0 ? 0 :  blurPage ? 13 : 0)
                                        .id(section.id)
                                        .onAppear {
                                            
                                                scrollViewProxy.scrollTo(((chatMessages[chatMessages.count - 3]).id), anchor: .bottom)
                                                
                                                
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                                withAnimation(.easeInOut) {
                                                    bubblesAppeared = true
                                                }
                                                withAnimation(.spring()) {
                                                    
                                                        scrollViewProxy.scrollTo((chatMessages.last?.id), anchor: .bottom)
                                                        scrollToBottom = true
                                                    
                                                }
                                            }
                                        }
                                    
                                    
                                }
                                
                            }
                        }
                        .coordinateSpace(name: "scrollView")
                    }
                    .onChange(of: messageDeleted) { newValue in
                        if messageDeleted {
                            blurPage = false
                            
                            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
                                
                                
                              //  deleteMessage(messageID: "\(btapped)")
                            }
                            
                            typeWriteText("Message deleted!") {
                                //Message was deleted
                                messageDeleted = false
                            }
                        }
                    }
                    
                }
                
                
                
                
                .padding(.top, 150)
                .coordinateSpace(name: "scroll")
            }.background( Color("offwhiteneo"))
                .onTapGesture{
                    blurPage = false
                }
            // .overlay(Text("\(scrolledItem)"))
                .onTapGesture{
                    keyboardFocus = false
                }
               
                .onDisappear{
                    bubblesAppeared = false
                   
                }
            
        }
            .offset(y:-90)
            
        
    }
    var texting: some View {
        
        
        VStack{
            Spacer()
            // Usage example
            
            
            HStack {
                TextField("Type your message", text: $messageText)
                    .padding(.vertical)
                    .padding(.leading, 55)
                    .foregroundColor(guardSending ? .gray : Color("black"))
                    .background(Color("offwhite"))
                    .focused($keyboardFocus)
                    .cornerRadius(25)
                    .overlay(  Image(systemName: "pencil.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .offset(x: -145)
                    )
                    .offwhitebutton(isTapped: keyboardFocus, isToggle: true, cornerRadius: 25, action:  $typing)
                    .onChange(of: typing) { newValue in
                        if keyboardFocus {
                            typing = true
                        } else {
                            typing = false
                        }
                    }
                
                Image(systemName: "arrow.up.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(messageText.count < 1 ? .gray : guardSending ? .red : .blue)
                    .neumorphiccircle(padding: -5, opacity: 1)
                    .onTapGesture{
                        
                        if messageText.count > 0 && !guardSending{
                          //  sendMessage(message: messageText)
                            messageText = ""
                        } else {
                            if !guardSending {
                                typeWriteText("You haven't typed anything bro :/") {
                                    print("Typing finished")
                                }
                            }
                        }
                        
                    }
                
            }.padding()
               // .background(Color)
                
            
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
                keyboardFocus = false
                typing = false
               
                
//                if offset < previousOffset {
//                    scrollingUp = false
//                } else {
//                    scrollingUp = true
//                }
                
                
                if offset < 11 || offset > 50 {
                    
                    withAnimation(.spring()) {
                        hideNav = true
                        
                    }
                    
                }
                
                else {
                    withAnimation(.spring()) {
                        hideNav = false
                    }
                    
                    
                }
                
                // Update the previous offset
//                previousOffset = offset
            }
        }
        .onChange(of: scrolledItem) { newValue in
            
            
            withAnimation(.spring()) {
                userscrolled = true
            }
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { timer in
                withAnimation(.spring()) {
                    userscrolled = false
                }
            }
            
            
            
            
        }
    }
    func typeWriteText(_ text: String, completion: @escaping () -> Void) {
        let original = messageText
        messageText = ""
        var currentIndex = 0
        guardSending = true
        Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { timer in
            if currentIndex < text.count {
                let index = text.index(text.startIndex, offsetBy: currentIndex)
                let character = text[index]
                
                DispatchQueue.main.async {
                    withAnimation(.easeIn) {
                        messageText += String(character)
                    } // Update the typedText property on the main queue
                }
                
                currentIndex += 1
            } else {
                
                timer.invalidate()
                completion()
                Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
                    withAnimation(.easeInOut) {
                        messageText = original
                        
                        guardSending = false
                    }
                }
                
            }
        }
    }
    
//    func sendMessage(message: String) {
//        let user = Auth.auth().currentUser
//        let db = Firestore.firestore()
//        let collectionRef = db.collection("messages").document(log.docid)
//            .collection("log")
//
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMM d, yyyy 'at' h:mm:ss a"
//        let timeinstring = dateFormatter.string(from: Date())
//
//
//        let dateFormatter2 = DateFormatter()
//        dateFormatter2.dateFormat = "h:mm a"
//        let timeinstring2 = dateFormatter2.string(from: Date())
//
//
//        let data: [String: Any] = [
//            "text": message,
//            "time":  timeinstring,
//            "stamp": timeinstring2,
//            "sender": user?.email ?? ""
//            // Add more fields and values as needed
//        ]
//
//        collectionRef.addDocument(data: data) { error in
//            if let error = error {
//                typeWriteText("Error adding document: \(error.localizedDescription)") {
//                    //nothing
//                }
//                print("Error adding document: \(error.localizedDescription)")
//            } else {
//                print("Document added successfully")
//                typeWriteText("Message sent successfully") {
//                    //nothing
//                }
//            }
//        }
//    }
    
//    private func fetchMessages() {
//        let user = Auth.auth().currentUser
//        let db = Firestore.firestore()
//        let usersRef = db.collection("messages")
//            .document(log.docid) // Specify the document ID in the "messages" collection
//            .collection("log") // Go one collection deeper
//                               // .whereField("email", arrayContains: holdData.email) //
//                               // .whereField("email", arrayContains: user?.email)
//
//
//            .addSnapshotListener { snapshot, error in
//                guard let documents = snapshot?.documents else {
//                    print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
//                    return
//                }
//
//                // Process the updated documents and update your UI accordingly
//                // For example, you can update an @State variable holding chat messages
//                let messages = documents.map { document -> Message in
//                    let data = document.data()
//                    let name = data["name"] as? String ?? ""
//                    let docid = data["documentID"] as? String ?? ""
//                    let text = data["text"] as? String ?? ""
//                    let sender = data["sender"] as? String ?? ""
//                    let stamp = data["stamp"] as? String ?? ""
//
//                    let timestamp = data["timestamp"] as? String ?? ""
//                    return Message(documentID: docid, name: name, text: text, sender: sender, timestamp: timestamp, stamp:stamp)
//
//                }
//                self.chatMessages = messages
//            }
//
//    }
    
    //    func deleteMessage(messageID: String) {
    //        withAnimation {
    //            chatMessages.remove(at: Int(messageID) ?? 0)
    //        }
    //    }
    
//    func deleteMessage(messageID: String) {
//        let db = Firestore.firestore()
//        let messageRef = db.collection("messages")
//            .document(log.docid) // Specify the document ID in the "messages" collection
//            .collection("log").document(messageID) // Go one collection deeper
//        
//        messageRef.delete { error in
//            if let error = error {
//                print("Error deleting message: \(error.localizedDescription)")
//            } else {
//                print("Message deleted successfully")
//            }
//        }
//    }
    
    
    
}


struct MessageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // MessagesView(section: .constant(messageSections[0]))
        ViewController()
    }
}




struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}



