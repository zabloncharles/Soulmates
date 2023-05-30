////
////  ShuffleMatchesView.swift
////  ionicFusion
////
////  Created by Zablon Charles on 5/23/23.
////
//
//import SwiftUI
//import FirebaseFirestore
//import Firebase
//
//struct ShuffleMatchesView: View {
//    @State var matchcard = matchCardData[0]
//    @State var user: UserStruct? // Variable to hold the user dat
//    @Namespace var namespace
//    @State var text = ""
//    @State var erro = ""
//    @State var sendMessage = false
//   
//    var body: some View {
//       
//            ZStack {
//                BackgroundView()
//                FullProfileView(namespace: namespace, user: $user, matchcard: $matchcard, showProfile: .constant(false))
//                
//                
//                
//               
////                VStack{
////                    Spacer()
////                    HStack {
////                        Spacer()
////                        Image(systemName: "fleuron")
////                            .font(.title)
////                            .padding()
////                            .background(Color.red)
////                        .cornerRadius(60)
////
////                    }
////                }.zIndex(3)
//                 //   .padding(.bottom, 70)
//                   // .padding(.trailing,20)
//                  //  .blur(radius: 30)
//                
//               // SendMatch()
//                 //   .zIndex(3)
//                
//         
//                
//            
//                       
//            }
//        
//    }
//    private func fetchCurrentUser() {
//        
//        let db = Firestore.firestore()
//        let user = Auth.auth().currentUser
//        let usersRef = db.collection("users").whereField("email", isEqualTo: user?.email ?? "")
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
//            if let documentData = documents.first?.data() {
//                let user = UserStruct(
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
//                
//                self.user = user
//            } else {
//                print("User document not found")
//            }
//        }
//      
//    }
//    func sendMatch(text: String) {
//        let user = Auth.auth().currentUser
//        let db = Firestore.firestore()
//        
//        // Add a placeholder for the document ID
//        
//        
//        let docRef = db.collection("messages").document()
//        
//        // Add the document with the modified data
//        docRef.setData(["matched": true,
//                        "time":  Date(),
//                        "email": [user?.email ?? "" , "zab.charles@gmail.com"]
//                        // Add other fields as needed
//                       ], merge: true) { error in
//            if let error = error {
//                // Handle the error
//                print("Error updating message data: \(error.localizedDescription)")
//                return
//            }
//            
//            // Data updated successfully
//            print("Message data updated")
//            
//            // Perform additional operations
//            // ...
//        }
//    }
//   
//}
//
//struct ShuffleMatchesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShuffleMatchesView()
//    }
//}
