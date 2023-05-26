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
    
    @FocusState private var keyboardFocus: Bool
    @State private var typing = false
    var body: some View {
        NavigationView {
            ZStack {
              BackgroundView()
                content
              
                    cover
               
                texting
              
                
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
                    .background(Color("white").opacity(0.5))
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                  
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(20)
                    .offset(y: 80)
            )
         
            Spacer()
        }//.offset(y: CGFloat(scrolledItem - 20))
        .offset(y: hideNav ? 0 : 0)
        .edgesIgnoringSafeArea(.all)
    }
    
    var content: some View {
        
        ScrollView (showsIndicators: false){
            scrollDetection
            VStack{
                
                VStack {
                    
                    
                        
                            
                            VStack {
                                
                                ForEach(chatMessages.sorted(by: { $1.timestamp > $0.timestamp })) {section in
                                 
                                    
                                    MessageBubble1(section: section)
                                        .onLongPressGesture {
                                           deleteMessage(messageID: section.documentID)
                                        }
                                  //  Text("\(section.id)")
                                    
                                       
                                }
                            }
                            .coordinateSpace(name: "scrollView")
                        }
            }
                
                
            
            
               .padding(.top, 90)
                .padding(.bottom,90)
            .coordinateSpace(name: "scroll")
        }.background(Color("offwhiteneo"))
       
            .overlay(Text("\(scrolledItem)"))
            .onTapGesture{
                keyboardFocus = false
            }
            .onAppear{
                fetchMessages()
            }
        
        
        
    }
    var texting: some View {
       
           
            VStack{
                Spacer()
                
                HStack {
                    TextField("Type your message", text: $messageText)
                        .padding(.vertical)
                        .padding(.leading, 55)
                        .background(Color("offwhite"))
                        .focused($keyboardFocus)
                        .cornerRadius(25)
                        .overlay(  Image(systemName: "pencil.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .offset(x: -145)
                        )
                        .offwhitebutton(isTapped: typing, isToggle: true, cornerRadius: 25, action:  $typing)
                        .onChange(of: typing) { newValue in
                            if keyboardFocus {
                                typing = true
                            } else {
                                typing = false
                            }
                        }
                    
                        Image(systemName: "arrow.up.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(messageText.count < 1 ? .gray : .blue)
                        .neumorphiccircle(padding: -5, opacity: 1)
                        .onTapGesture{
                           if messageText.count > 0 {
                               sendMessage(text: messageText, sender: sender)
                               messageText = ""
                            }
                        
                    }
                    
                }.padding()
                   // .background(Color("offwhite"))
                    .background(
                        VStack{
                            Rectangle()
                                .fill(.ultraThinMaterial)
                                .frame(width: .infinity,height: 190)
                                .cornerRadius(35)
                                .offset(y:55)
                        }
                           
                            
                    )
                    
            }.offset(y: hideNav ? 0 : 0)
           
        
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
  
    private func fetchMessages() {
        let db = Firestore.firestore()
        let usersRef = db.collection("users").document("E2FzpaP15CVyce9uvimm").collection("messages").document("Uq85VmqlQged6RRDNg0y").collection("messages").document("individual").collection("9oU5CqpvCwCDAezknYLG")
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
                    let sender = data["sender"] as? Bool ?? false
                    let timestamp = data["timestamp"] as? String ?? ""
                    return Message(documentID: docid, name: name, text: text, sender: sender, timestamp: timestamp)
                    
                }
                self.chatMessages = messages
            }
    }
    
    func deleteMessage(messageID: String) {
        let db = Firestore.firestore()
        let messageRef = db.collection("users").document("E2FzpaP15CVyce9uvimm").collection("messages").document("Uq85VmqlQged6RRDNg0y").collection("messages").document("individual").collection("9oU5CqpvCwCDAezknYLG").document(messageID)
        
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
