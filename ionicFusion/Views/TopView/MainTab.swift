//Created by Zablon Charles.


import SwiftUI
import FirebaseFirestore
import Firebase

struct MainTab: View {
    @State private var users: [User] = [] // Array to hold the user data
    @State var currentUser: UserStruct = fakeUser // Variable to hold the user data
    @State var user: UserStruct? // Variable to hold the user dat
    @AppStorage("currentPage") var selected = 0
    @AppStorage("showAccount") var showAccount = false
    @AppStorage("hidemainTab") var hidemainTab = false
    @AppStorage("notifications") var showNotifications = false
    @AppStorage("editcalendar") var showEditCalendar = false
    @Namespace var namespace
   // @State var matchcard = MatchCardData(name: "", location: "", quote: "", profilepic: "", background: "", work: "", matchscore: "")
    @State var matchcard = matchCardData[0]
    @State var selectedSection = messageSections[0]
 

    var body: some View {
        
        ZStack {
            BackgroundView()
            NavigationView {
                VStack{
                    
                    if self.selected == 0{
                       // HomeView( matchcard: $matchcard)
                        FullProfileView( namespace: namespace)
                    }
                   if self.selected == 1{
                      LikesView()
                          
                          
                    }
                    if self.selected == 2{
                     
                       // StandoutsView(matchcard: $matchcard)
                        HomeView(currentUser: $user)
                    }
                    if self.selected == 3{
                        NotificationsDetail(namespace: namespace, notification: $selectedSection)
                        
                    }
                    if self.selected == 4{
                        ProfileEditView()
                       // SenderView()
                        
                    }
                }
            }
            
            
//            if showProfile {
//                FullProfileView(namespace: namespace,user: $user, matchcard: $matchcard, showProfile: $showProfile)
//            }
            
            FloatingTabbar(selected: self.$selected)
                
                .offset(y:  hidemainTab  ? UIScreen.main.bounds.height * 0.13 : 0)
                .animation(.spring(), value: hidemainTab)
            
            
            
            
            
                
        }.onAppear{
           // fetchCurrentUser()
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
                
                self.currentUser = user
            } else {
                print("User document not found")
            }
        }
  
    }
}


struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
       // MainTab( course: .constant(Course))
        ViewController()
           // .preferredColorScheme(.dark)
            
    }
}

struct FloatingTabbar : View {
    
    @Binding var selected : Int
    @Namespace var namespace
    @State var tappedicon = false
    let generator = UINotificationFeedbackGenerator()
    
    var body : some View{
        
        VStack(){
        
        GeometryReader { proxy in
            let hasHomeIndicator = proxy.safeAreaInsets.bottom > 0
           
            
            HStack( alignment: .center, spacing: 17.0){
                
                  
                TabIcon(selected: $selected, selectedicon: 0, icon: "house", name:"Home" ,tappedicon: $tappedicon )
                TabIcon(selected: $selected, selectedicon: 1, icon: "fleuron",name:"Likes" , tappedicon: $tappedicon )
                TabIcon(selected: $selected, selectedicon: 2, icon: "person.2" , name:"Explore" ,tappedicon: $tappedicon )
                TabIcon(selected: $selected, selectedicon: 3, icon: "bubble.left.and.bubble.right",name:"Chats" , tappedicon: $tappedicon )
                TabIcon(selected: $selected, selectedicon: 4, icon: "person.2.badge.gearshape",name:"Profile" , tappedicon: $tappedicon )
           
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: hasHomeIndicator ? 64 : 64)
          
            .background(Color("offwhite"))
           
            .background(Image("cover2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            
                            .offset(x: self.selected == 0 ? -90 : self.selected == 1 ?  -20 : self.selected == 2 ? 40 :self.selected == 3 ? 90 : 0)
                            .animation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 1), value: selected)
                            
                           
            )
            
            .offwhitebutton(isTapped: tappedicon, isToggle: false, cornerRadius: 36, action: .constant(false))
         //   .background(.ultraThinMaterial)
           // .cornerRadius(36)
            .scaleEffect(tappedicon ? 0.97 : 1)
            .animation(.spring(), value: tappedicon)
            .padding(.horizontal, 61.0) //makes tabbar smaller
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            
            
        }
       
        
        }
    }
    
 
}





struct TabIcon: View {
    @Binding var selected : Int
    var selectedicon : Int = 0
    var icon : String = "person"
    var tapped: String = ".fill"
    var name = "Name"
    let generator = UINotificationFeedbackGenerator()
    @Binding var tappedicon : Bool
   
    var body: some View {
        Button(action: {
            self.selected = selectedicon
            
            vibrate()
            
            tappedicon = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                tappedicon = false
            }
        }) {
            VStack(spacing:2){
                VStack {
                    Image(systemName: self.selected == selectedicon ? "\(icon)\(tapped)" : icon)
                        .foregroundColor(self.selected == selectedicon ? .red  : .gray).padding(.horizontal)
                        .background(Circle()
                                        .fill(self.selected == selectedicon ? .red : .clear)
                                        .animation(.spring(), value: tapped)
                                        
                                        .blur(radius: 19)
                                        .opacity(0.4)
                    )
                }.frame(width: 40, height: 30)
                if self.selected == selectedicon {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.4, blendDuration: 1)) {
                        Rectangle()
                            .fill(.red)
                            .frame(width: 8, height: 1)
                    }
                }
                Text(name)
                    .font(.footnote)
                    .foregroundColor(self.selected == selectedicon ? .red : .gray)
            }
             
        }
    }
    func vibrate() {
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
}
}
