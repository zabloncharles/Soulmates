//
//  SettingsView.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 2/17/22.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore


struct SettingsView: View {
    @ObservedObject var viewModel = UserViewModel()
    @AppStorage("signedIn") var signIn = false
    @AppStorage("hidemainTab") var hidemainTab = false
    @AppStorage("signInAnimation") var signInAnimation = false
    @AppStorage("editcalendar") var showEditCalendar = false
    @State var birthDate = Date()
    @State var image: UIImage?
    @State var tappedImage = false
    @State var showImagePicker = false
    @State var changeWallpaperTapped = false
    @State var showEditer = false
    @State var showNotification = false
    @FocusState var isUserNameFocused
    @State var textFielde = 0
    @State var doneTapped = false
    @State var lastChance = false
    @State var animate = false
    //@Binding var wallpaper : String
    @State var showWallpaperPicker = false
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("wallpaper") var wallpaper = ""
    @State var notificationMessage = "test message"
    @State var textEdit = ""
    @State var showBlur = false
    @State var birthdaycompleteTapped = false
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .leading),
        removal: .move(edge: .leading))
    let wallpapers = ["Villanova" , "Moscaid" , "Maverick" , "Sunshine" , "Paradise" , "Deerville"]
    
    var body: some View {
        
        
        ZStack {
            
            //Background
           
            
            //First Section
            wallpaperandsettingsinfo
                .padding(.top, 30)
              
                    //image picker
                        .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil) {
                            ImagePicker(image: $image)
                                .ignoresSafeArea()
                                .onDisappear {
                                    changePic()
                                    
                                    withAnimation(.spring()) {
                                        tappedImage = false
                                    }
                                    
                                    
                                }
                    }
            
            
            
           
            
            Notification(title: notificationMessage, notification: "Notification", showNotification: $showNotification)
                .padding(.top, -6)
                .opacity(showNotification ? 1 : 0)
                .animation(.spring(), value: showNotification)
            
        }
      
        
        .onAppear {
            withAnimation(.spring()) {
                hidemainTab = true
                animate = true
            }
        }
        .onDisappear {
            withAnimation(.spring()) {
                hidemainTab = false
                animate = false
            }
        }
       
    }
   
    var wallpaperandsettingsinfo: some View {
        VStack(alignment: .leading) {
            //User privacy
           
            HStack{
               
                Text("Wallpaper")
                    .font(.title3).bold()
                   
                    .padding(70)
                    
                    .cornerRadius(19)
                    .opacity(0)
                    
                VStack{
                   
                    HStack {
                        Spacer()
                        
                        
                           
                    }
                    
                }.scaleEffect(tappedImage ? 0.97 : 1)
                    
            }    .background(
                ZStack {
                   
                    VStack {
                        Text("Wallpaper")
                            .font(.title).bold()
                        
                        Image(wallpaper)
                            .renderingMode(.original)
                            .resizable(resizingMode: .stretch)
                            .aspectRatio(contentMode: .fill)
                            .onTapGesture{
                                withAnimation(.spring()){
                                    changeWallpaperTapped = true
                                    showWallpaperPicker.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                        withAnimation(.spring()){
                                            changeWallpaperTapped = false
                                        }
                                    }
                                }
                                
                        }
                    }

                    
                }
                
            )
                .cornerRadius(20)
                .padding(0.4)
                .cornerRadius(25)
                .padding(-1)
                .scaleEffect(showWallpaperPicker ? 0.97 : 1)
                .padding()
                .rotation3DEffect(Angle(degrees:showWallpaperPicker ? 20 : 0), axis: (x: showWallpaperPicker ? 600.0 : 0, y: 0.0, z: 0.0))

                .animation(.spring(), value: textFielde)
                .background(.ultraThinMaterial)
                .background(VStack{
                    Spacer()
                    LinearGradient(colors: [Color("offwhite"),Color("offwhite"), Color.clear], startPoint: .bottom, endPoint: .top)
                })
                .cornerRadius(25)
            
            // Divider().padding(.horizontal, 50)
            VStack {
                ZStack{
                    
                    if showWallpaperPicker {
                        wallpaperselection
                            .offset(x: showWallpaperPicker ? 0 : UIScreen.main.bounds.width * 1)
                           
                    }
                    
                    
                    VStack {
                        settingselection
                            .offset(x: !showWallpaperPicker ? 0 : UIScreen.main.bounds.width * -1)
                        
                        Divider()
                        //User privacy
                        VStack(alignment: .leading){
                        
                         
                            //User privacy
                            Text("Sign Out")
                                .font(.title3).bold()
                            
                            HStack {
                                Text("Sign Out")
                                Spacer()
                                Image(systemName: "power")
                                    .foregroundColor(Color("black"))
                                
                                
                            }.padding()
                                .neoButtonOff(isToggle: false, cornerRadius: 13) {
                                    //
                                    signout()
                                }
                                .padding(.vertical, 2)
                            
                        
                    }.padding().neoButtonOff(isToggle: false, cornerRadius: 13) {
                        //
                      
                    }
                    .padding()
                        
                    }
                    
                }
                
            }
            
            
            
            
            
        }
            .padding()
           
        
    }
    var birthdaypicker: some View {
        DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
            Text("")
              
            
        }
        .datePickerStyle(WheelDatePickerStyle())

        .frame(maxWidth: .infinity)
        
        
        .padding(30)
    }
    
    var settingselection : some View {
        
       
          
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading){
            Text("Profile Infomation")
                .font(.title3).bold()
            HStack {
                Text("Email")
                Spacer()
                Text("test@gmail.com")
                    .foregroundColor(Color("black"))
                
                
            }.padding()
                .neoButtonOff(isToggle: false, cornerRadius: 13) {
                    //
                }
                .padding(.vertical, 2)
        }.padding().neoButtonOff(isToggle: false, cornerRadius: 13) {
            //
        }
            
            Divider()
            //New Section
            VStack(alignment: .leading) {
                Text("Account Options")
                    .font(.title3).bold()
                HStack {
                    Text("Deactivate Account")
                    Spacer()
                    Image(systemName: "circle.grid.2x1.left.filled")
                        .foregroundColor(.green)
                    
                    
                }.padding()
                    .neoButtonOff(isToggle: false, cornerRadius: 13) {
                        //
                    }
                    .padding(.vertical, 2)
                
                //Delete account option
                HStack {
                    Text("Delete Account")
                    Spacer()
                    Image(systemName: "trash.slash")
                        .foregroundColor(Color("black"))
                    
                    
                }.padding()
                    .neoButtonOff(isToggle: false, cornerRadius: 13) {
                        //
                    }
                    .padding(.vertical, 2)
            }.padding().neoButtonOff(isToggle: false, cornerRadius: 13) {
                //
            }
            
            
            
            
            
            Divider()
            //User privacy
            VStack(alignment: .leading){
            Text("Privacy Policy")
                .font(.title3).bold()
            HStack {
                Text("Data Protection")
                Spacer()
                Image(systemName: "list.bullet.rectangle.portrait")
                    .foregroundColor(Color("black"))
                
                
            }.padding()
                .neoButtonOff(isToggle: false, cornerRadius: 13) {
                    //
                }
                .padding(.vertical, 2)
            
            HStack {
                Text("Report a problem")
                Spacer()
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(Color("black"))
                
                
            }.padding()
                .neoButtonOff(isToggle: false, cornerRadius: 13) {
                    //
                }
                .padding(.vertical, 2)
            }.padding().neoButtonOff(isToggle: false, cornerRadius: 13) {
                //
            }
                   
                       
                        
                        
                    
                    
                }.padding(10)
                    .padding(.vertical, 10)
                    
                   
                    
              
                   
                
            
            
        
        
        
    }
    
    var wallpaperselection : some View {
        
        VStack {
            ScrollView (showsIndicators: false){
                ForEach(handbooks) { handbook in
                    WallpaperVM(handbook: handbook, showWallpaperPicker: $showWallpaperPicker)
                }
            }
        }.scaleEffect(!showWallpaperPicker ? 0.90 : 1)
        
    }
    func changeUsernameFunc() {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        // Set the data to update
        let fullName = "\(textEdit)"
        var components = fullName.components(separatedBy: " ")
        if components.count > 0 {
            let firstName = components.removeFirst()
            let lastName = components.joined(separator: " ")
        
        
        db.collection("users").whereField("email", isEqualTo: user?.email ?? "")
            .getDocuments() { (querySnapshot, error) in
                if error != nil {
                    showNotification = true
                    notificationMessage = "there was an error getting the right dociment with emal"
                } else {
                    for document in querySnapshot!.documents {
                        db.collection("users").document("\(document.documentID)").setData(["firstName": "\(firstName)","lastName": "\(lastName)"], merge: true) { error in
                            
                            if error == nil {
                                
                                showNotification = true
                                notificationMessage = "Your name was changed to \(textEdit) successfully."
                            } else {
                                showNotification = true
                                notificationMessage = "there was an error at last line"
                            }
                        }
                    }
                }
            }
        }
    }
    func convertAge() -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        
        let date = formatter.string(from: birthDate)
   
        
        
      
        
        return String(date)
        
        
    }
    func getage() -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        
        let date = formatter.string(from: birthDate)
        let tes = "\(date)"
        
        let birthday = formatter.date(from: ("\(tes)"))
        let timeInterval = birthday?.timeIntervalSinceNow
        let age = abs(Int(timeInterval! / 31556926.0))
        
        
        return String(age)
        
        
    }
    func checkdateandupload(){
        let ageinnumber = Int(getage()) ?? 5
        if ageinnumber < 13 {
            showNotification = true
            notificationMessage = "Mhm, too young? Try a different date."
        } else {
            changebirthdayFunc()
        }
    }
    func changebirthdayFunc(){
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        // Set the data to update
        
            db.collection("users").whereField("email", isEqualTo: user?.email ?? "")
                .getDocuments() { (querySnapshot, error) in
                    if error != nil {
                        
                    } else {
                        for document in querySnapshot!.documents {
                            db.collection("users").document("\(document.documentID)").setData(["age": "\(getage())"], merge: true) { error in
                                
                                if error == nil {
                                    
                                    showNotification = true
                                    notificationMessage = "Your birthdate has been changed successfully."
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                                        showBlur = false
                                        
                                    }
                                } else {
                                    
                                }
                            }
                        }
                    }
                }
        
    }
    
    func signout(){
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        // Set the data to update
        
        db.collection("users").whereField("email", isEqualTo: user?.email ?? "")
            .getDocuments() { (querySnapshot, error) in
                if error != nil {
                    
                } else {
                    for document in querySnapshot!.documents {
                        db.collection("users").document("\(document.documentID)").setData(["online": false], merge: true) { error in
                            
                            if error == nil {
                                
                               
                            }
                        }
                    }
                }
            }
        try! Auth.auth().signOut()
        signIn = false
        signInAnimation = true
       
    }
    func changePic(){
        
        let storageRef = Storage.storage().reference()
        // Create a reference to the file you want to upload
        guard let uid = Auth.auth().currentUser?.uid
        else { return }
        // let imageurl = storageRef.storage.reference(withPath:uid)
        let ref = storageRef.child("profileimages/\(uid).jpg")
        
        guard let imageData = self.image?.jpegData(compressionQuality:
                                                    0.5) else { return }
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                //some err
                //Storage: \(err)"
                return
            } else {
                notificationMessage = "Your picture saved successfully"
            }
            ref.downloadURL { url, err in
                if let err = err {
                    //som err
                   
                    return
                } else {
                    notificationMessage = "Your url downloaded successfully"
                }
            }
        }
        let impactMed = UIImpactFeedbackGenerator(style: .light)
        impactMed.impactOccurred()
        loadImageFromFirebase()
    }
    func loadImageFromFirebase() {
        
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        guard let uid = Auth.auth().currentUser?.uid
        else { return }
        //  let avatarurl = "profileimages/\(userID ?? "error").jpg"
        let storageRef = Storage.storage().reference(withPath:"profileimages/\(uid).jpg")
        storageRef.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                notificationMessage = "error reaching database"
                return
            }
            // info = "success"
            
            let imageurl = "\(url!)"
            //  self.imageURL = imageurl
            notificationMessage = "connected to storage"
            
            //save the dounload url to database key
            db.collection("users").whereField("email", isEqualTo: user?.email ?? "")
                .getDocuments() { (querySnapshot, error) in
                    if error != nil {
                        //there is an error
                    } else {
                        for document in querySnapshot!.documents {
                            db.collection("users").document("\(document.documentID)").setData(["avatar": imageurl], merge: true) { error in
                                
                                if error == nil {
                                    notificationMessage = "url saved to database"
                                    
                                } else {
                                    notificationMessage = "url not saved to database"
                                }
                            }
                        }
                    }
                }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
   //    SettingsView()
//            .preferredColorScheme(.dark)
       // MainTab()
        ViewController()
            .preferredColorScheme(.dark)
    }
}

struct SettingSelections: View {
    var title = "title"
    var icon = "chevron.right"
    @State var selectionTapped = false
    var body: some View {
        HStack{
            Text(title)
            Spacer()
          
        }.padding()
            
            .scaleEffect( selectionTapped ? 0.96 : 1)
    }
}
