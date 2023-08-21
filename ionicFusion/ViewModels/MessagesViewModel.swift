//
//  MessagesViewModel.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 3/21/22.
//


import Firebase
import SwiftUI

//class MessagesViewModel: ObservableObject {
//    @Published var messagesInput: [MessagesModel] = []
//
//
//
//    init() {
//        addInfo()
//
//    }
//
//    func addInfo(){
//
//        // Get a reference to the database
//        let db = Firestore.firestore()
//        let user = Auth.auth().currentUser
//
//      //  let messageRef = db
//         //   .collection("messages").document("roomA")
//
//
//        db.collection("messages").whereField("id", isEqualTo: "123456")
//            .getDocuments() { (querySnapshot, error) in
//                if error != nil {
//                    self.messagesInput = MessagesData
//                } else {
//                    for document in querySnapshot!.documents {
//                        let docRef = db.collection("messages").document("\(document.documentID)")
//
//                        docRef.getDocument { (document, error) in
//                            if let document = document, document.exists {
//
//                                self.messagesInput = [
//                                         MessagesModel(
//                                            message: "Hey john",
//                                            time: "2:34 PM",
//                                            response: false
//
//                                         )
//
//
//                                ]
//
//                            } else {
//                                self.messagesInput = MessagesData
//                            }
//                        }
//
//
//                    }
//                }
//            }
//
//
//    }
//
//}


//  User(fname: (document.get("firstName") ?? "error") as! String,
