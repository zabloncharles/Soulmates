import SwiftUI
import Firebase

struct UserListView: View {
    @State private var users: [Usere] = [] // Variable to hold the users' data
    
    var body: some View {
        VStack(alignment: .leading) {
            if users.isEmpty {
                Text("Loading users...")
            } else {
                ForEach(users) { user in
                    Text("\(user.fname)\(users.count)") // Display the first name of the user
                }
            }
        }
        .onAppear {
            fetchUsers()
        }
    }
    
    private func fetchUsers() {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        let usersRef = db.collection("users").whereField("email", isNotEqualTo: user?.email ?? "")
        
        usersRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found.")
                return
            }
            
            let users = documents.compactMap { document in
                let documentData = document.data()
                
                return Usere(
                    fname: documentData["firstname"] as? String ?? ""
                )
            }
            
            self.users = users
        }
    }
}

struct Usere: Identifiable {
    var id = UUID()
    var fname: String
}
struct MainTaeb_Previews: PreviewProvider {
    static var previews: some View {
        // MainTab( course: .constant(Course))
        UserListView()
        // .preferredColorScheme(.dark)
        
    }
}
