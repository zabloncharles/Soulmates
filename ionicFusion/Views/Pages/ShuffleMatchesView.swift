//
//  ShuffleMatchesView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/23/23.
//

import SwiftUI
import FirebaseFirestore
import Firebase

struct ShuffleMatchesView: View {
    @State var matchcard = matchCardData[0]
    @State var user: UserStruct? // Variable to hold the user dat
    @Namespace var namespace
    var body: some View {
        VStack{
            FullProfileView(namespace: namespace, user: $user, matchcard: $matchcard, showProfile: .constant(false))
                .background(
            Image("Blob 1")
                .offset(x: -154, y: -340)
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 58))
        }.onAppear{
            fetchCurrentUser()
        }
    }
    private func fetchCurrentUser() {
        
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        let usersRef = db.collection("users").whereField("email", isEqualTo: user?.email ?? "")
        
        usersRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found.")
                return
            }
            
            if let documentData = documents.first?.data() {
                let user = UserStruct(
                    firstname: documentData["firstname"] as? String ?? "",
                    lastname: documentData["lastname"] as? String ?? "",
                    notifications: documentData["notifications"] as? String ?? "",
                    avatar: documentData["avatar"] as? String ?? "",
                    cyclechange: documentData["cyclechange"] as? String ?? "",
                    birthday: documentData["birthday"] as? String ?? "",
                    email: documentData["email"] as? String ?? "",
                    aboutme: documentData["aboutme"] as? String ?? "",
                    education: documentData["education"] as? String ?? "",
                    work: documentData["work"] as? String ?? "",
                    images: documentData["images"] as? [String] ?? [],
                    likes: documentData["likes"] as? [String] ?? [],
                    location: documentData["location"] as? [String] ?? [],
                    lookingfor: documentData["lookingfor"] as? String ?? "",
                    online: documentData["online"] as? Bool ?? false,
                    password: documentData["password"] as? String ?? "",
                    matches: documentData["matches"] as? Int ?? 0,
                    age: documentData["age"] as? String ?? "", lifestyle: documentData["lifestyle"] as? [String] ?? [],
                    lifestyledesc: documentData["lifestyledesc"] as? String ?? ""
                )
                
                self.user = user
            } else {
                print("User document not found")
            }
        }
        //        let db = Firestore.firestore()
        //        let usersRef = db.collection("users")
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
        //            self.users = documents.compactMap { queryDocumentSnapshot in
        //                let data = queryDocumentSnapshot.data()
        //
        //                // Map Firestore data to your User struct or class
        //                if let fname = data["fname"] as? String,
        //                   let lname = data["lname"] as? String,
        //                   let email = data["email"] as? String,
        //                   let notifications = data["notifications"] as? String,
        //                   let avatar = data["avatar"] as? String,
        //                   let cyclechange = data["cyclechange"] as? String,
        //                   let birthday = data["birthday"] as? String {
        //                    return User(fname: fname, lname: lname, notifications: notifications, avatar: avatar, cyclechange: cyclechange, birthday: birthday, email: email)
        //                } else {
        //                    return nil
        //                }
        //            }
        //        }
    }
}

struct ShuffleMatchesView_Previews: PreviewProvider {
    static var previews: some View {
        ShuffleMatchesView()
    }
}
