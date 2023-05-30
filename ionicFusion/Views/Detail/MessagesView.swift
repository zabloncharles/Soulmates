//
//  MessagesView.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 2/28/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct MessagesView: View {
    @AppStorage("hidemainTab") var hidemainTab = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State var text = "yo"
    //@Binding var section: NotificationModel
    @State var hideNav = false
    @State var scrolling = CGFloat(0)
    @State var scrolledItem: Int = 0
    @State private var chatMessages: [Message] = []
    var log : SomeUsers
   // var holdData : [IncomingMessage]
    @State private var messageText = ""
    @State private var sender = "John"
    @State var guardSending = false
    @State var userscrolled = false
    @FocusState private var keyboardFocus: Bool
    @State private var typing = false
    @State private var typedText = ""
    @State var btapped = 0
    @State var blurPage = false
    @State var messageDeleted = false
    @State private var scrollToBottom: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
              BackgroundView()
                content
              
                    cover
               
                texting
             // Text(userscrolled ? "yes he scrolled" : "no he didtn scroll")
                
            }
            .zIndex(1)
        }.onAppear{
            withAnimation(.spring()) {
                hidemainTab = true
            }
        }
        .onDisappear {
            withAnimation(.spring()) {
                hidemainTab = false
            }
        }
    }
    
    var cover: some View {
        VStack {
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 110)
         
            .background(
               // Image(section.background)
               // Image("image_10")
                  //  .resizable(resizingMode: .stretch)
                   // .aspectRatio(contentMode: .fill)
                  //  .accessibility(hidden: true)
                ImageViewer(url: "")
            )
            .mask(
                RoundedRectangle(cornerRadius: 0)
            )
    
            .overlay(
                VStack(alignment: .leading, spacing: 8) {
                    
                    
                    HStack {
                       // Image(holdData.name)
                       //     .resizable(resizingMode: .stretch)
                         //   .aspectRatio(contentMode: .fill)
                        ImageViewer(url: "")
                            .cornerRadius(80)
                            .mask(Circle())
                            .background(
                                Circle()
                                    .fill(Color.blue)
                                    .padding(-2)
                                    
                            )
                            .frame(width: 60, height: 60)
                            .padding(10)
                        VStack{
                            Text(log.name.capitalized)
                            Text(log.docid)
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
                         
                        }
                        Spacer()
                        
                        Image(systemName: "exclamationmark.circle")
                            .foregroundColor(.gray )
                            .font(.title2)
                            .padding(.trailing,10)
                    }
                    
                
                   
                }
                    .background(Color("white").opacity(0.6))
                    
                    .offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 15, action: .constant(false))
                   
                  
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(20)
                    .offset(y: 80)
            )
         
            Spacer()
        }//.offset(y: CGFloat(scrolledItem - 20))
        .offset(y: userscrolled ? -40 : 0)
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
                                    
                                    
                                    MessageBubble1(section: section, blurPage: $blurPage, messageDeleted: $messageDeleted, bTapped: btapped)
                                        .onLongPressGesture {
                                            blurPage.toggle()
                                            btapped =  Int(section.documentID) ?? 0
                                            
                                            
                                                
                                           
                                        }
                                        .opacity( messageDeleted && btapped == Int(section.documentID) ?? 0 ? 0 : 1)
                                        .blur(radius: btapped == Int(section.documentID) ?? 0 ? 0 :  blurPage ? 13 : 0)
                                        .id(section.id)
                                        .onAppear {
                                      
                                           // withAnimation {
                                                    scrollViewProxy.scrollTo((chatMessages.last?.id), anchor: .bottom)
                                                    scrollToBottom = true
                                                
                                              //  }
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
                                
                              
                                  deleteMessage(messageID: "\(btapped)")
                            }
                            
                            typeWriteText("Message deleted!") {
                                //Message was deleted
                                messageDeleted = false
                            }
                        }
                    }
                  
                }
                
                
                
                
                .padding(.top, 130)
                .coordinateSpace(name: "scroll")
            }.background( Color("offwhiteneo"))
                .onTapGesture{
                    blurPage = false
                }
               // .overlay(Text("\(scrolledItem)"))
                .onTapGesture{
                    keyboardFocus = false
                }
                .onAppear{
                   fetchMessages()
                }
            
        }.padding(.bottom, 96)
        
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
                               sendMessage(message: messageText)
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
                   // .background(Color("offwhite"))
                    .background(
                        ZStack{
                            Rectangle()
                                .fill(Color.black)
                                .frame(width: .infinity,height: 190)
                                .cornerRadius(35)
                                .offset(y:55)
                            Rectangle()
                                .fill(.ultraThinMaterial.opacity(0.5))
                                .frame(width: .infinity,height: 190)
                                .cornerRadius(35)
                                .offset(y:55)
                        }
                           
                            
                    )
                    
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
    
    func sendMessage(message: String) {
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        let collectionRef = db.collection("messages").document(log.docid)
            .collection("log")
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy 'at' h:mm:ss a"
        let timeinstring = dateFormatter.string(from: Date())
        
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "h:mm a"
        let timeinstring2 = dateFormatter2.string(from: Date())
        
        
        let data: [String: Any] = [
            "text": message,
            "time":  timeinstring,
            "stamp": timeinstring2,
            "sender": user?.email ?? ""
            // Add more fields and values as needed
        ]
        
        collectionRef.addDocument(data: data) { error in
            if let error = error {
                typeWriteText("Error adding document: \(error.localizedDescription)") {
                    //nothing
                }
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("Document added successfully")
                typeWriteText("Message sent successfully") {
                    //nothing
                }
            }
        }
    }
  
    private func fetchMessages() {
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        let usersRef = db.collection("messages")
            .document(log.docid) // Specify the document ID in the "messages" collection
            .collection("log") // Go one collection deeper
           // .whereField("email", arrayContains: holdData.email) //
           // .whereField("email", arrayContains: user?.email)


            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                // Process the updated documents and update your UI accordingly
                // For example, you can update an @State variable holding chat messages
                let messages = documents.map { document -> Message in
                    let data = document.data()
                    let name = data["name"] as? String ?? ""
                    let docid = data["documentID"] as? String ?? ""
                    let text = data["text"] as? String ?? ""
                    let sender = data["sender"] as? String ?? ""
                    let stamp = data["stamp"] as? String ?? ""
                    
                    let timestamp = data["timestamp"] as? String ?? ""
                    return Message(documentID: docid, name: name, text: text, sender: sender, timestamp: timestamp, stamp:stamp)

                }
                self.chatMessages = messages
            }

    }

//    func deleteMessage(messageID: String) {
//        withAnimation {
//            chatMessages.remove(at: Int(messageID) ?? 0)
//        }
//    }
    
    func deleteMessage(messageID: String) {
        let db = Firestore.firestore()
        let messageRef = db.collection("messages")
            .document(log.docid) // Specify the document ID in the "messages" collection
            .collection("log").document(messageID) // Go one collection deeper

        messageRef.delete { error in
            if let error = error {
                print("Error deleting message: \(error.localizedDescription)")
            } else {
                print("Message deleted successfully")
            }
        }
    }
    
    

    }


struct MessagesView_Previews: PreviewProvider {
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


struct Message: Identifiable {
    let id = UUID()
    let documentID: String
    let name: String
    let text: String
    let sender: String
    let timestamp: String
    let stamp: String
}
