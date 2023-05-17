//
//  SettingsView.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 2/17/22.
//

import SwiftUI
import Firebase
import FirebaseAuth


struct SettingsView: View {
    @ObservedObject var viewModel = UserViewModel()
    @AppStorage("signIn") var signIn = true
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
    @State var showBirthdayPicker = false
    @State var showBlur = false
    @State var birthdaycompleteTapped = false
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .leading),
        removal: .move(edge: .leading))
    let wallpapers = ["Villanova" , "Moscaid" , "Maverick" , "Sunshine" , "Paradise" , "Deerville"]
    
    var body: some View {
        
        
        ZStack {
            
            //Background
           Color("background").ignoresSafeArea()
            
            //First Section
            wallpaperandsettingsinfo
                .padding(.top, 30)
                .blueNavigation
             
            
            
            
          
                //notification popup
                
                
                    
                    
               
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
            
            
            
            
            BackButton()
            
            birthdaypickerandblur
            
            Notification(title: notificationMessage, notification: "Notification", showNotification: $showNotification)
                .padding(.top, -6)
                .opacity(showNotification ? 1 : 0)
                .animation(.spring(), value: showNotification)
            
        }
      
        
        .onAppear {
            withAnimation(.spring()) {
                hidemainTab = true
            }
        }
        .onDisappear {
            withAnimation(.spring()) {
                hidemainTab = false
            }
        }
//        .onChange(of: notificationMessage) { newValue in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
//                showNotification = true
//            }
//        }
    }
    var birthdaypickerandblur: some View {
        ZStack {
            
            VStack{
                if showBlur {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .frame(width: .infinity, height: .infinity)
                        .edgesIgnoringSafeArea(.all)
                    
                        .onTapGesture {
                            showBlur = false
                        }
                }
            }.opacity(showBlur ? 1 : 0)
                .animation(.easeInOut, value: showBlur)
            
            VStack{
                if showBlur {
                    VStack{
                        Spacer()
                        VStack(spacing: -19.0) {
                            Text(convertAge())
                        .padding(.horizontal, 13)
                            .padding(.vertical, 9)
                            .newoffwhite(offwhiteisTapped: false, cornerradius: 9)
                            
                        birthdaypicker
                            .frame(maxWidth: .infinity)
                            .padding()
                            
                        
                        Text("Complete")
                            .font(.body)
                            .fontWeight(.regular)
                            .padding(.horizontal, 13)
                            .padding(.vertical, 9)
                            .newoffwhite(offwhiteisTapped: birthdaycompleteTapped, cornerradius: 9)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    birthdaycompleteTapped = true
                                }
                                checkdateandupload()
                            }
                        }.padding(.bottom, 10)
                        
                    }.offset(y: showBirthdayPicker ? 0:450)
                    .onDisappear {
                        withAnimation(.spring()) {
                            showBirthdayPicker = false
                            birthdaycompleteTapped = false
                            
                        }
                    }
                }
            }.transition(.scale.combined(with: .opacity ))
                .animation(.easeInOut, value: showBirthdayPicker)
        }
    }
    var wallpaperandsettingsinfo: some View {
        VStack(alignment: .leading) {
           
            
            VStack(alignment: .leading) {
                Text("Settings")
                    .font(.title)
                    .fontWeight(.bold)
                Text(showWallpaperPicker ? "Change your wallpaper" : textFielde == 1 ? "Change your name" : textFielde == 2 ? "Change your email" : textFielde == 3 ? "Change your zodiac" : textFielde == 4 ? "Activate your account" : textFielde == 0 ? "Change your profile information." : "Manage your account")
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(Color("black"))
               
            }.padding(.horizontal, 20)
            
            
            
            
            HStack{
                VStack (spacing:70){
                    Text("Change your wallpaper")
                        .opacity(0)
                    Text("Change your wallpaper")
                        .opacity(0)
                    Text("Change your wallpaper")
                        .opacity(0)
                }
                
                VStack{
                    
                    HStack {
                        Spacer()
                        
                        Text("wall")
                            .foregroundColor(.black)
                            .opacity(0)
                            .padding(.vertical, 5)
                            .padding(.leading, 25)
                            .padding(.trailing, 49)
                            .background(.black)
                            .cornerRadius(20)
                            .offset(x:39)
                           
                    }.overlay(
                        VStack {
                            if let image = self.image{
                                
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .rotationEffect(.degrees(tappedImage ? 180 : 0))
                                
                            } else {
                                
//                                Image(systemName: tappedImage ? "rays" : "person")
//
//                                    .aspectRatio(contentMode: .fit)
//                                    .font(.title2)
                                Avatar()
                                    .rotationEffect(.degrees(tappedImage ? 360 : 0))
                                
                            }
                            
                            
                        }.frame(width:  60, height:  60)
                            .background(.ultraThinMaterial)
                        
                            .cornerRadius(80)
                            .background(
                                Circle()
                                    .fill(.black)
                                    .padding(-4)
                            )
                            .offset(x:60)
                            .onTapGesture{
                                withAnimation(.spring()){
                                    textFielde = 0
                                    tappedImage = true
                                }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                                        withAnimation(.spring()){
                                            showImagePicker.toggle()
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                            tappedImage = false
                                            }
                                        }
                                    }
                                
                                
                            }
                    )
                    
                        .overlay(VStack{
                            if showWallpaperPicker {
                                Text("Current Wallpaper")
                                    .font(.footnote)
                                    .foregroundColor(.primary)
                                    .padding(.vertical, 5)
                                    .padding(.trailing, 11)
                                    .padding(.leading, 29)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(25)
                                    .offset(x:-229 , y:60)
                            }
                        }
                        )
                }.scaleEffect(tappedImage ? 0.97 : 1)
                    
            }    .background(
                ZStack {
                   
                    Image(wallpaper)
                        .renderingMode(.original)
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fill)
                      
                    LottieView(filename: "birds" ,loop: true)
                        .frame(width: 380)
                        .offset(x: 0, y: 0)
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
                
            )
                .cornerRadius(25)
                .padding(0.4)
                .background(.white.opacity(0.30))
                .cornerRadius(25)
                .padding(-1)
                .scaleEffect(showWallpaperPicker ? 0.97 : 1)
                .padding()
                .rotation3DEffect(Angle(degrees:showWallpaperPicker ? 20 : 0), axis: (x: showWallpaperPicker ? 600.0 : 0, y: 0.0, z: 0.0))

                .offset(x: textFielde == 10 ? -540 : 0)
                .animation(.spring(), value: textFielde)
              
            
            // Divider().padding(.horizontal, 50)
            VStack {
                ZStack{
                    
                    wallpaperselection
                        .offset(x: showWallpaperPicker ? 0 : UIScreen.main.bounds.width * 1)
                    
                    
                    settingselection
                        .offset(x: !showWallpaperPicker ? 0 : UIScreen.main.bounds.width * -1)
                    
                }
                
            }
            
            
            
            
            
        }
        
    }
    var birthdaypicker: some View {
        DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
            Text("")
              
            
        }
        .datePickerStyle(WheelDatePickerStyle())
        .newoffwhite(offwhiteisTapped: false, cornerradius: 21)
        .frame(maxWidth: .infinity)
        
        
        .padding(30)
    }
    
    var settingselection : some View {
        
        ForEach(viewModel.userinfo) { user in
            VStack{
                VStack(spacing: 12) {
                    HStack {
                        if textFielde == 1 {
                            if doneTapped && !textEdit.isEmpty  {
                                SettingSelections(title: "Are you sure you want to change your name to \(textEdit)")
                                    .onAppear{
                                        lastChance = true
                                    }
                                    .onDisappear {
                                        lastChance = false
                                    }
                                    .transition(.scale.combined(with: .opacity))
                                    .animation(.easeInOut, value: lastChance)
                                
                                
                            } else {
                                VStack {
                                    TextField(isUserNameFocused ? "Your first and last name.." : "\(user.fname) \(user.lname)", text: $textEdit)
                                        .keyboardType(.default)
                                        .autocapitalization(.none)
                                        .settingcustomField(icon: "pencil")
                                        .focused($isUserNameFocused)
                                        .padding(8)
                                }
                                .transition(.scale.combined(with: .opacity))
                                .animation(.easeInOut, value: doneTapped)
                            }
                            
                        } else {
                            SettingSelections(title: "Name")
                        }
                        Spacer()
                        
                       HStack {
                           if textFielde == 1 {
                               if doneTapped && !textEdit.isEmpty && lastChance  {
                                   HStack {
                                       Text(doneTapped && !textEdit.isEmpty ? "Yes" :  "Done")
                                           .foregroundColor(.white)
                                           .padding(9)
                                           .background(.blue)
                                           .cornerRadius(9)
                                           .scaleEffect(doneTapped ? 0.97 : 1)
                                           .onTapGesture {
                                               doneTapped = true
                                               isUserNameFocused = false
                                               
                                               if textEdit.isEmpty {
                                                   showNotification = true
                                                   notificationMessage = "Error: Please type in something before you hit done!"
                                               }
                                               
                                               if doneTapped && !textEdit.isEmpty && lastChance {
                                                   showNotification = true
                                                   notificationMessage = "Your name was changed to \(textEdit)"
                                                   textFielde = 0
                                                   changeUsernameFunc()
                                               }
                                              
                                       }
                                       Text("No")
                                           .foregroundColor(.white)
                                           .padding(9)
                                           .background(.red)
                                           .cornerRadius(9)
                                           .scaleEffect(doneTapped ? 0.97 : 1)
                                           .onTapGesture {
                                                   doneTapped = false
                                                   textFielde = 0
                                             
                                               
                                           }
                                   }
                                   .transition(.scale.combined(with: .opacity))
                                   .animation(.easeInOut, value: doneTapped)
                               }
                               else {
                                   Text(doneTapped && !textEdit.isEmpty ? "Yes" : textEdit.isEmpty ? "Cancel" : "Done")
                                       .foregroundColor(.white)
                                       .padding(9)
                                       .background(.blue)
                                       .cornerRadius(9)
                                       .scaleEffect(doneTapped ? 0.97 : 1)
                                       .onTapGesture {
                                           doneTapped = true
                                           isUserNameFocused = false
                                           
                                           if textEdit.isEmpty {
                                              textFielde = 0
                                           }
                                           
                                           if doneTapped && !textEdit.isEmpty && lastChance {
                                              
                                               textFielde = 0
                                               changeUsernameFunc()
                                           }
                                           
                                   }
                                       .transition(.scale.combined(with: .opacity))
                                       .animation(.easeInOut, value: doneTapped)
                               }
                         
                        } else {
                            VStack {
                                
                                
                                settingsMenuItems(text: "\(user.fname) \(user.lname)", icon: "person", itemTapped: false)
                                    .overlay(Rectangle()
                                        .opacity(0.02)
                                        .cornerRadius(25)
                                        .onTapGesture {
                                            textFielde = 1
                                        })
                                
                            }
                        }
                           
                       }.padding(.trailing, 10)
                    }.padding(.vertical, 2)
                    .newoffwhite(offwhiteisTapped: textFielde == 1, cornerradius: 11)
                    
                    HStack {
                        SettingSelections(title: "Email")
                            .onTapGesture {
                                textFielde = 2
                            }
                        Spacer()
                        
                       HStack {
                           if textFielde == 2 {
                            VStack {
                                TextField("email", text: $textEdit)
                                    .keyboardType(.default)
                                    .autocapitalization(.none)
                                    .settingcustomField(icon: "envelope")
                                
                            }
                        } else {
                            settingsMenuItems(text: user.email, icon: "envelope", itemTapped: false)
                                .overlay(Rectangle()
                                            .opacity(0.02)
                                            .cornerRadius(25)
                                            .onTapGesture {
                                    textFielde = 2
                                })
                            
                        }
                           
                       }.padding(.trailing, 10)
                        
                        
                    }
                    .padding(.vertical, 2)
                    .newoffwhite(offwhiteisTapped: textFielde == 2, cornerradius: 11)
                    
                    
                    HStack {
                        
                        SettingSelections(title: textFielde == 3 ? "Change birthday?" : "Birthday")
                        Spacer()
                        HStack{
                            
                            if textFielde == 3{
                                HStack {
                                    HStack (spacing: 2){
                                        Image(systemName: "checkmark.circle")
                                        Text("Yes")
                                        
                                    }   .padding(.vertical,8)
                                        .padding(.horizontal,8)
                                        .background(.blue)
                                        .cornerRadius(9)
                                        .onTapGesture {
                                            showBlur = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            showBirthdayPicker = true
                                            }
                                        }
                                    HStack {
                                        HStack (spacing: 2){
                                            Image(systemName: "x.circle")
                                            Text("Cancel")
                                            
                                        }   .padding(.vertical,8)
                                            .padding(.horizontal,8)
                                            .background(.gray)
                                            .cornerRadius(9)
                                            .onTapGesture {
                                                textFielde = 0
                                            }
                                    }
                                }
                            } else {
                                settingsMenuItems(text: user.birthday, icon: "calendar", itemTapped: false)
                                    .overlay(Rectangle()
                                        .opacity(0.02)
                                        .cornerRadius(25)
                                        .onTapGesture {
                                            textFielde = 3
                                        })
                            }
                            
                            
                        }.padding(.trailing, 10)
                    }.padding(.vertical, 2)
                        .newoffwhite(offwhiteisTapped: textFielde == 5, cornerradius: 11)
                    
                    
                    HStack {
                        
                        SettingSelections(title: textFielde == 5 ? "Change cycle?" : "Cycle")
                        Spacer()
                        HStack{
                         
                            if textFielde == 5{
                                HStack {
                                    HStack (spacing: 2){
                                        Image(systemName: "checkmark.circle")
                                        Text("Yes")
                                         
                                    }   .padding(.vertical,8)
                                        .padding(.horizontal,8)
                                        .background(.blue)
                                        .cornerRadius(9)
                                        .onTapGesture {
                                            showEditCalendar = true
                                        }
                                    HStack {
                                        HStack (spacing: 2){
                                            Image(systemName: "x.circle")
                                            Text("Cancel")
                                            
                                        }   .padding(.vertical,8)
                                            .padding(.horizontal,8)
                                            .background(.gray)
                                            .cornerRadius(9)
                                            .onTapGesture {
                                                textFielde = 0
                                            }
                                    }
                                }
                            } else {
                                settingsMenuItems(text: user.cyclechange, icon: "calendar", itemTapped: false)
                                    .overlay(Rectangle()
                                        .opacity(0.02)
                                        .cornerRadius(25)
                                        .onTapGesture {
                                            textFielde = 5
                                        })
                            }
                          
                            
                        }.padding(.trailing, 10)
                    }.padding(.vertical, 2)
                        .newoffwhite(offwhiteisTapped: textFielde == 5, cornerradius: 11)
                   
                    
                  
                    
                }.padding(10)
                    .padding(.vertical, 2)
                    .newoffwhite(offwhiteisTapped: false, cornerradius: 15)
                    .padding()
                    .offset(x: textFielde == 10 ? 540 : 0)
                    .animation(.spring(), value: textFielde)
                    
              
               
                VStack {
                    HStack {
                        SettingSelections(title: "Activate Account")
                        Spacer()
                        settingsMenuItems(text:"Activate", icon: "checkmark.circle", itemTapped: false)
                            .overlay(Rectangle()
                                        .opacity(0.02)
                                        .cornerRadius(10)
                                        .onTapGesture {
                                withAnimation(.spring()){
                                    textFielde = 4
                                    showNotification.toggle()
                                    textFielde = 0
                                }
                            })
                    }
                    .padding(.trailing, 10)
                    .newoffwhite(offwhiteisTapped: textFielde == 4, cornerradius: 11)
           
                    
                }.padding()
                    .padding(.vertical,-7)
                    .padding(.horizontal,-7)
                    .newoffwhite(offwhiteisTapped: false, cornerradius: 15)
                    .padding()
                    .offset(x: textFielde == 10 ? 540 : 0)
                    .animation(.spring(), value: textFielde)
                    .padding(.top,-20)
               
             
                    
                VStack(alignment: .center) {
                
                        HStack {

                            VStack{
                            if textFielde > 8 {
                                HStack{
                                    Image(systemName: "circle.dotted")
                                        .font(.title3)
                                        .rotationEffect(Angle(degrees: animate ? 0 : 180))
                                    Text("Signing Out...")
                                        .font(.headline)
                                }
                              
                                .transition(.scale.combined(with: .opacity))
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                                            withAnimation(.easeIn(duration: 2)) {
                                                animate = true
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                    withAnimation(.easeIn(duration: 2)) {
                                                signIn = false
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .onDisappear {
                                        animate = false
                                    }
                            } else {
                                Text("Sign Out")
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .transition(.scale.combined(with: .opacity))
                            }
                            }
                                            .onTapGesture {
                                    signout()
                                    withAnimation(.spring()){
                                       
                                                 textFielde = 9
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                     textFielde = 10
                                                 }
                                                
                                    }
                                }
                            
                            
                                
                        }.padding(.horizontal, textFielde > 8 ? 17 : 50)
                        .padding(.vertical, textFielde > 8 ? 17 : 14)
                        .newoffwhite(offwhiteisTapped: textFielde > 8 ? true : false, cornerradius: 13)
                        
                            .padding(.top, 20)
                           .offset(y: textFielde == 10 ? 140 : 0)
                            .animation(.spring(), value: textFielde)
                            .scaleEffect(textFielde == 5 ? 0.97 : 1)
                            .opacity(textFielde == 5 ? 0 : 1)
                    
                }
                   
                Spacer()
            }
        }
        
        
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
                                        showBirthdayPicker = false
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
