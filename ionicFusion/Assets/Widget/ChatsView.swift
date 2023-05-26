//
//  ChatsView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/26/23.
//
//import SwiftUI
//import Firebase
//import FirebaseFirestore
//import FirebaseAuth
//

import Foundation


//struct ChatsView: View {
//    @State private var chatMessages: [Message] = []
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading) {
//                if chatMessages.isEmpty {
//                    Text("Loading users...")
//                } else {
//                    ForEach(chatMessages) { user in
//                        MessageBubble1(section: user)
//                    }
//                }
//                Spacer()
//            }
//            .onAppear {
//                fetchUsers()
//            }
//        }
//    }
//
//    private func fetchUsers() {
//        let db = Firestore.firestore()
//        let usersRef = db.collection("users").document("E2FzpaP15CVyce9uvimm").collection("messages").document("Uq85VmqlQged6RRDNg0y").collection("messages")
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
//                    let name = data["documentID"] as? String ?? ""
//                    let name = data["name"] as? String ?? ""
//                    let text = data["text"] as? String ?? ""
//                    let sender = data["sender"] as? Bool ?? false
//                    let timestamp = data["timestamp"] as? String ?? ""
//                    return Message(documentID: <#String#>, name: name, text: text, sender: sender, timestamp: timestamp)
//
//                }
//                self.chatMessages = messages
//            }
//    }
//}

struct Message: Identifiable {
    let id = UUID()
    let documentID: String
    let name: String
    let text: String
    let sender: Bool
    let timestamp: String
}


//struct ChatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatsView()
//    }
//}
