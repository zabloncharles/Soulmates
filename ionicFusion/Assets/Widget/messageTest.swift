import Firebase
import FirebaseFirestore
import SwiftUI

class UserData: ObservableObject {
    @Published var users: [Userm] = []
    
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        
        db.collection("messages").getDocuments { snapshot, error in
            if let error = error {
                // Handle the error
                print("Error fetching messages: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                // Handle no documents found
                return
            }
            
            var emailu = documents.compactMap { $0.data()["email"] as? [String] }
                .filter { $0.contains(user?.email ?? "") }
                .flatMap { $0 }
            
            let newEmail = emailu
                .filter { $0 != user?.email }
            
            db.collection("users").whereField("email", in: newEmail).getDocuments { snapshot, error in
                if let error = error {
                    // Handle the error
                    print("Error fetching users: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    // Handle no documents found
                    return
                }
                
                self.users = documents.compactMap { document in
                    let data = document.data()
                    let docid = document.documentID
                    let firstname = data["firstname"] as? String ?? ""
                    return Userm(name: firstname, docid: docid)
                }
            }
        }
    }
}

struct Userm {
    let name: String
    let docid: String
}


struct UserListView: View {
    @ObservedObject var userData = UserData()
    
    
    var body: some View {
        List(userData.users, id: \.name) { user in
            Text(user.name)
        }
    }
}


struct NotificationRfow_Previews: PreviewProvider {
    
    
    static var previews: some View {
        UserListView()
        
    }
}
