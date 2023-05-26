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
    @Binding var section: NotificationModel
    @State var hideNav = false
    @State var scrolling = CGFloat(0)
    @State var scrolledItem: Int = 0
    @State private var chatMessages: [Message] = []
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
                Image("image_10")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .accessibility(hidden: true)
            )
            .mask(
                RoundedRectangle(cornerRadius: 0)
            )
    
            .overlay(
                VStack(alignment: .leading, spacing: 8) {
                    
                    
                    HStack {
                        Image(section.avatar)
                            .resizable(resizingMode: .stretch)
                            .aspectRatio(contentMode: .fill)
                            
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
                            Text(section.name)
                                .font(.title2).bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.primary)
                        
                            HStack(spacing:2) {
                                Image(systemName: "circlebadge.fill")
                                    .foregroundColor(section.online == false ? .red : .green)
                                    .font(.caption2)
                                Text(section.online == true ? "Online" : "Was online 5 minutes ago")
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
                                      
                                            withAnimation(.spring()) {
                                                    scrollViewProxy.scrollTo((chatMessages.last?.id), anchor: .bottom)
                                                    scrollToBottom = true
                                                
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
                               sendMessage(text: messageText, sender: sender)
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
    
       func sendMessage(text: String, sender: String) {
        let db = Firestore.firestore()
        let messageRef = db.collection("users").document("E2FzpaP15CVyce9uvimm").collection("messages").document("Uq85VmqlQged6RRDNg0y").collection("messages").document("individual").collection("9oU5CqpvCwCDAezknYLG").document()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timestampString = dateFormatter.string(from: Date())
        
        let messageData: [String: Any] = [
            "text": text,
            "sender": true,
            "timestamp": timestampString,
            "documentID": messageRef.documentID // Save the document ID as a field
        ]
        
        messageRef.setData(messageData) { error in
            if let error = error {
                print("Error adding message: \(error.localizedDescription)")
            } else {
                print("Message added successfully")
            }
        }
       
        
      
    }
  
  //  private func fetchMessages() {
//        let db = Firestore.firestore()
//        let usersRef = db.collection("users").document("E2FzpaP15CVyce9uvimm").collection("messages").document("Uq85VmqlQged6RRDNg0y").collection("messages").document("individual").collection("9oU5CqpvCwCDAezknYLG")
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
//                    let sender = data["sender"] as? Bool ?? false
//                    let timestamp = data["timestamp"] as? String ?? ""
//                    return Message(documentID: docid, name: name, text: text, sender: sender, timestamp: timestamp)
//
//                }
//                self.chatMessages = messages
//            }
    
   // }
    func fetchMessages() {
        let fakeMessages = [
            Message(documentID: "0", name: "John", text: "?", sender: true, timestamp: "10:30 AM"),
            Message(documentID: "1", name: "John", text: "Hello", sender: true, timestamp: "10:30 AM"),
            Message(documentID: "2", name: "Alice", text: "Hi there", sender: false, timestamp: "10:35 AM"),
            Message(documentID: "3", name: "John", text: "How are you?", sender: true, timestamp: "10:40 AM"),
            Message(documentID: "4", name: "Alice", text: "I'm doing great!", sender: false, timestamp: "10:45 AM"),
            Message(documentID: "5", name: "John", text: "What have you been up to?", sender: true, timestamp: "11:00 AM"),
            Message(documentID: "6", name: "Alice", text: "Just working on some projects", sender: false, timestamp: "11:15 AM"),
            Message(documentID: "7", name: "John", text: "That's great!", sender: true, timestamp: "11:30 AM"),
            Message(documentID: "8", name: "Alice", text: "I'm learning new technologies too", sender: false, timestamp: "11:45 AM"),
            Message(documentID: "9", name: "John", text: "We should catch up sometime", sender: true, timestamp: "12:00 PM"),
            Message(documentID: "10", name: "Alice", text: "Definitely! Let's plan something", sender: false, timestamp: "12:15 PM"),
            Message(documentID: "11", name: "John", text: "Sure, how about next week?", sender: true, timestamp: "12:30 PM"),
            Message(documentID: "12", name: "Alice", text: "Sounds good to me!", sender: false, timestamp: "12:45 PM"),
            Message(documentID: "13", name: "John", text: "Great! I'll send you the details", sender: true, timestamp: "1:00 PM"),
            Message(documentID: "14", name: "Alice", text: "Looking forward to it!", sender: false, timestamp: "1:15 PM"),
            Message(documentID: "15", name: "John", text: "See you soon!", sender: true, timestamp: "1:30 PM"),
            // Add more fake messages as needed
        ]

        
        chatMessages = fakeMessages
    }
    func deleteMessage(messageID: String) {
        withAnimation {
            chatMessages.remove(at: Int(messageID) ?? 0)
        }
    }
    
//    func deleteMessage(messageID: String) {
//        let db = Firestore.firestore()
//        let messageRef = db.collection("users").document("E2FzpaP15CVyce9uvimm").collection("messages").document("Uq85VmqlQged6RRDNg0y").collection("messages").document("individual").collection("9oU5CqpvCwCDAezknYLG").document(messageID)
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


struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
       MessagesView(section: .constant(messageSections[0]))
       // ViewController()
    }
}




struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}
