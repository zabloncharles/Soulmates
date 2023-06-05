//
//  OnboardingView.swift
//  DesignCodeiOS15
//
//  Created by Zablon Charles on 12/17/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct OnboardingView: View {
    @State var onScreen = 0
    @State var nextButtonPressed = false
    @State var image: UIImage?
    @State var firstname = ""
    @State var lastname = ""
    @State var selectedDate = Date()
    @State var email = ""
    @State var password = ""
    @State var newAge = "No data"
    @State var error = false
    @State var errorMessage = "There was an error"
    @State var showAngular = false
    @State var birthDate = Date()
    @State var pressedBack = false
    @State var signinPressed = false
    @Binding var doneIntro : Bool
    @State var success = false
    @State var switching = 0
    
    
    
   var transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    var transitionBack: AnyTransition = .asymmetric(
        insertion: .move(edge: .leading),
        removal: .move(edge: .trailing))
   
    
    var body: some View {
        
      
            ZStack {
               
                BackgroundView()
                
                VStack{
                    //First displayed screen
                            TabView(selection: $switching){
                            SignUpMessageView(title: "Sign Up!", message: "We are going to ask you a few questions on the next page so we can build a profile for you. You can click on the top left to go back if you make a mistake. Now let's get started!", gradientTitle: [Color("black"), Color("black"), .red], gradientMessage: [Color("black") , Color("black"), Color("black"), .red, Color("black")])
                                .tag(1)
                                EnterNameView(firstname: $firstname, lastname: $lastname, errormessage: errorMessage,onScreen: $onScreen, switching: $switching)
                                .tag(2)
                                EnterAgeView(newAge: $newAge, onScreen: $onScreen, switching: $switching)
                                    .tag(3)
                                AboutMeView()
                                    .tag(4)
                                WorkView()
                                    .tag(5)
                                UniversityFullView()
                                    .tag(6)
                                LikesPillView()
                                    .tag(7)
                                LookingForView()
                                    .tag(8)
                                Email_PasswordView(image: $image, email: $email, password: $password, onScreen: $onScreen, success: $success)
                                    .tag(9)
                            } .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                       
                }
                 .padding(.bottom, 50)
                 
                
                signinbutton
                
                    angularbutton
                    .offset(x: switching > 1 ? 0 : 490)
                    .animation(.spring(), value: switching)
              
                
                    tabicons
                    .offset(x: switching > 1  ? -290 : 0)
                    .animation(.spring(), value: switching)
                
                
                
                
                
            }
        
    }
    var angularbutton: some View {
        VStack {
            Spacer()
            HStack{
                
                AngularButton(title: error ? errorMessage :  onScreen > 1 ?  "Finish" : "Next", tap: success)
                    .neoButtonOffShadow(cornerRadius: 24, isTapped: false)
                    .padding(.horizontal, error ? 70 : 139)
                    .padding(.bottom, 20)
                    .scaleEffect(nextButtonPressed ? 0.97 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            switching += 1
                        }
                      //  angularButtonPressed()
//                        withAnimation(.easeInOut) {
//                            success.toggle()
//                        }
                    }
                    
            }
        }.animation(.spring(), value: error)
    }
    var tabicons: some View {
        VStack{
            Spacer()
            HStack{
                Image(systemName:  switching == 0 ? "smallcircle.filled.circle.fill" : "smallcircle.filled.circle")
                Image(systemName:  switching == 1 ? "smallcircle.filled.circle.fill" : "smallcircle.filled.circle")
                Image(systemName:  switching == 2 ? "smallcircle.filled.circle.fill" : "smallcircle.filled.circle")
            }.font(.headline)
                .foregroundColor(.white.opacity(0.00))
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color("offwhite"),Color("offwhite"), Color("offwhite")]), startPoint: .leading, endPoint: .trailing)
                   
                        .mask(
                            HStack{
                                Image(systemName:  switching == 0 ? "smallcircle.filled.circle.fill" : "smallcircle.filled.circle")
                                Image(systemName:  switching == 1 ? "smallcircle.filled.circle.fill" : "smallcircle.filled.circle")
                                Image(systemName:  switching == 2 ? "smallcircle.filled.circle.fill" : "smallcircle.filled.circle")
                            }.font(.headline)
                        )
                    
                    
                )
            
        }.padding(.bottom, 10)
            .transition(transition)
            .animation(.spring(), value: onScreen)
    }
    var signinbutton: some View {
        VStack {
            HStack {
                Spacer()
               // Text("Sign In")
                HStack(spacing:4){ Image(systemName: "person")
                       .foregroundColor(Color("black"))
                       .font(.subheadline)
                   ShimmerVar(text: "Sign In", useCustomFont: false, ifNotCustomFont: .subheadline )}
                    .foregroundColor(Color("white"))
                    
                    .padding(.vertical, 9)
                    .padding(.horizontal, 8)
                    .neoButtonOff(isToggle: false, cornerRadius: 8, perform: {
                        //
                        withAnimation(.spring()) {
                            signinPressed = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                withAnimation(.spring()) {
                                    signinPressed = false
                                    doneIntro = true
                                    
                                    
                                    
                                    
                                }
                            }
                        }
                    })
                    
                    
            }.padding()
                .padding(.top,5)
            
            Spacer()
        }
    }
    
    func backButtonActions() {
        
        pressedBack = true
        onScreen -= 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            pressedBack = false
            
        }
    }
    func angularButtonPressed(){
        withAnimation(.spring())  {
            nextButtonPressed = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.spring()) {
                nextButtonPressed = false
            }
            
        }
        StartButtonPressed()
    }

}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
           .preferredColorScheme(.dark)
                }
}

// MARK: Functions
extension OnboardingView {
    func StartButtonPressed() {
        vibrate()
        //give the user success or errors on their inputs
        switch onScreen {
       
        case 0: //the page number of content
            if firstname.count == 0 && lastname.count == 0{
                
                
                errorMessage = "Hmm! Your name?"
                waitfourSeconds()
                return
            } else if firstname.count < 2 || lastname.count < 2{
                
                
                errorMessage = "Name too short"
                waitfourSeconds()
                
                return
            }
            case 1: //the page number of content
                if newAge == "No data" {
                    
                    
                    errorMessage = "Hmm! Your age?"
                    waitfourSeconds()
                    return
                } else if Int(newAge) ?? 1 < 11{
                    
                    
                    errorMessage = "Age too short"
                    waitfourSeconds()
                    
                    return
                }
            
        case 2: //the page number of content
            if email.count == 0 || password.count == 0{
                
                
                errorMessage = "You forgot your email/password?"
                waitfourSeconds()
                return
            } else if email.count < 2 || password.count < 2{
                
                
                errorMessage = "Maybe you made a mistake?"
                waitfourSeconds()
                
                return
            }
            else if !email.contains("@") || !email.contains("."){
                
                
                errorMessage = "Error! retype email"
                waitfourSeconds()
                
                return
            }
//                else if image == nil  {
//                    errorMessage = "image not found"
//                    waitfourSeconds()
//
//                } else if image != nil  {
//                    errorMessage = "huh"
//                    waitfourSeconds()
//                }
                            
                            else {
                
                AddInfo(firstname: self.firstname, lastname: self.lastname, age: self.newAge, password: self.password, email: self.email)
                
            }
            
            
        default:
            break
        }
        
        
        // Change the page and if last page sign in user
        
            withAnimation(.spring()) {
                onScreen += 1
                
            }
        
        
    }
    func waitfourSeconds(){
        error = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            error = false
        }
    }
    func AddInfo(firstname: String, lastname: String, age: String, password: String, email: String){
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
          
            if error != nil {
                
            //if the auth is unsuccessful
                errorMessage = "We encountered a problem"
                waitfourSeconds()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                   // errorMessage = "Try again"
                    waitfourSeconds()
                   
                }
                //if the auth is not successful
            } else {
               
                errorMessage = "Signing you up..."
                waitfourSeconds()
                //if successful
                let userID = Auth.auth().currentUser?.uid
               // let avatarurl = "profileimages/\(userID ?? "error").jpg"
                let db = Firestore.firestore()
                db.collection("users").document().setData(["id" : userID! ,"firstName": firstname, "lastName": lastname, "age": age, "email" : email, "password" : password, "online" : true])
                
                
                
                
                
                // Logs the user in then dismisses the model
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                     if image != nil  {
                         uploadPic()
                     
                         
                     } else {
                         let db = Firestore.firestore()
                         let user = Auth.auth().currentUser
                         let random = "https://picsum.photos/200"
                         //save the dounload url to database key
                         db.collection("users").whereField("email", isEqualTo: user?.email ?? "")
                             .getDocuments() { (querySnapshot, error) in
                                 if error != nil {
                                     //there is an error
                                 } else {
                                     for document in querySnapshot!.documents {
                                         db.collection("users").document("\(document.documentID)").setData(["avatar": random], merge: true) { error in
                                             
                                             if error == nil {
                                                 
                                                 
                                             }
                                         }
                                     }
                                 }
                             }
                     }
                  
                    errorMessage = "Successful..."
                    waitfourSeconds()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    errorMessage = "Signing you in..."
                    waitfourSeconds()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    UserDefaults.standard.set(true, forKey: "isLogged")
                    UserDefaults.standard.set(true, forKey: "doneIntro")
                    UserDefaults.standard.set(0, forKey: "currentPage")
                    self.email = ""
                    self.password = ""
                    doneIntro = true
                    vibrate()
                }
            }
        }

    }
    func uploadPic(){
        
        let storageRef = Storage.storage().reference()
        // Create a reference to the file you want to upload
        //guard
        guard let uid = Auth.auth().currentUser?.uid
        else { return }
        // let imageurl = storageRef.storage.reference(withPath:uid)
        let ref = storageRef.child("profileimages/\(uid).jpg")
        
        guard let imageData = self.image?.jpegData(compressionQuality:
                                                    0.5) else { return }
        ref.putData(imageData, metadata: nil) { metadata, err in
            if  (err != nil)  {
                //some err
                //Storage: \(err)"
                errorMessage = "an error happened at first level"
                return
            }
            ref.downloadURL { url, err in
                if  (err != nil)  {
                    //som err
                    errorMessage = "an error happened"
                    return
                } else {
                    loadImageFromFirebase()
                }
            }
        }
       
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
                return
            }
           // info = "success"
            
            let imageurl = "\(url!)"
          //  self.imageURL = imageurl
            
            
            //save the download url to database key
            db.collection("users").whereField("email", isEqualTo: user?.email ?? "")
                .getDocuments() { (querySnapshot, error) in
                    if error != nil {
                        //there is an error
                    } else {
                        for document in querySnapshot!.documents {
                            db.collection("users").document("\(document.documentID)").setData(["avatar": imageurl], merge: true) { error in
                                
                                if error == nil {
                                    
                                    
                                }
                            }
                        }
                    }
                }
        }
    }
    func vibrate() {
        let impactMed = UIImpactFeedbackGenerator(style: .light)
                        impactMed.impactOccurred()
}
    
}
