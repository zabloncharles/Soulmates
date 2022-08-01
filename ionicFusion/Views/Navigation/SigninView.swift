//
//  SigninView.swift
//  SigninView
//
//  Created by Meng To on 2021-07-27.
//

import SwiftUI
import Firebase

struct SigninView: View {
    @AppStorage("currentPage") var selected = 0
    @State var text = "test@gmail.com"
    @State var password = "123456"
    @State var circleInitialY = CGFloat.zero
    @State var circleY = CGFloat.zero
    @State var alertMessage = "Something went wrong."
    @State var showAlert = false
    @State var isLoading = false
    @State var isSuccessful = false
    @State var isLogging = false
    @FocusState var isEmailFocused: Bool
    @FocusState var isPasswordFocused: Bool
    @State var appear = [false, false, false, false]
    @Binding var signIn : Bool
    @Binding var doneIntro : Bool
    @State var userMessage = "Sign in"
    @State var messageTitle = "Sign In"
    @State var messageDescription = "Log in to your account to access your profile. Furthermore you can sign up for an account if you have not done so yet."
    @State var infoTitle = "Having trouble signing in?"
    @State var infoMessage = ""
    @State var infoTapped = false
    @State var signInTapped = false
    @State var showtext = false
    @State var profilePictureTapped = false
    @State var animate = false
    
    var body: some View {
        NavigationView{
         
                ZStack {
                   
                    
                
                    //MARK: THE TOP ICONS
                    Group{
                    LottieView(filename: "stars" ,loop: true)
                        .frame(width: 380)
                        .offset(x: 0, y: -420)
                    
                    LottieView(filename: "birds" ,loop: true)
                        .frame(width: 380)
                        .offset(x: 0, y: -220)
                    
                    topIcons
                    
                applogo
                    }.offset(y: signInTapped ? -700 : 0)
                    
                    
                    
                    
                    textandsecureFields
                    
                    
                    
                    
                    
                    
                    
                }.background(
                    Image("Blob 1")
                        .offset(x: -154, y: -340)
                        .edgesIgnoringSafeArea(.all)
                        .blur(radius: 58)
                        .opacity(signInTapped ? 0 : 1)
                )
                    .background(
                        BackgroundView()
                            .edgesIgnoringSafeArea(.all)
                            .opacity(!animate ? 1 : 0.001)
                            .animation(.easeInOut(duration: 6), value: animate)
                    )
                    .statusBar(hidden: false)
                    
                    .navigationBarHidden(true)
                .transition(.scale.combined(with: .opacity))
            
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    var applogo: some View {
        VStack{
            
            Image("fusionhalfgirl")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 350, alignment: .center)
                .offset(y: UIScreen.main.bounds.height * -0.1)
            
            
        }
    }
    var topIcons: some View {
        VStack{
            
            HStack {
                if isEmailFocused || isPasswordFocused {
                    
                    VStack{
                        Image(systemName: "keyboard.chevron.compact.down")
                           
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(infoTapped ? .gray : Color("black"))
                            .font(.subheadline)
                            .padding(infoTapped ? 8 : 7)
                        
                    }.background(.ultraThinMaterial)
                        .cornerRadius(5)
                        .onTapGesture {
                            animate = true
                            infoPressed()
                            
                        }
                }
                Spacer()
                NavigationLink(destination:  helpSuggestions) {
                  
                        Image(systemName: "info.circle")
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(infoTapped ? .gray : Color("black"))
                            .font(.title3)
                            .background(.ultraThinMaterial)
                            .cornerRadius(25)
                            .padding(infoTapped ? 8 : 7)
                        
                  
                }
              
                
                
            }.padding(.horizontal,20)
                .onTapGesture {
                    withAnimation(.spring()) {
                        infoPressed()
                    }}
            
            
            
            Spacer()
        }
    }
    
    var titleandDescription: some View{
//        VStack {
            VStack{
                //MARK: PROFILE PICTURE
//                Image(profilePictureTapped ? "image_04" : "image_03")
//                    .resizable(resizingMode: .stretch)
//                    .aspectRatio(contentMode: .fill)
//                    .font(.body)
//                    .rotationEffect(.degrees(profilePictureTapped ? 360 : 0))
//                    .animation(.spring(), value: profilePictureTapped)
//
//            }.frame(width:  90, height:  90)
//                .background(.ultraThinMaterial)
//                .background(Circle().fill(.blue).blur(radius: 20))
//                .cornerRadius(80)
//                .background(
//                    Circle()
//                        .fill(.ultraThinMaterial)
//                        .padding(-0.5)
//                )
//                .onTapGesture {
//                    withAnimation(.easeInOut(duration: 23)){
//                        profilePictureTapped.toggle()
//                    }
//                }
            
            //MARK: SIGN IN MESSAGE AND DESCRIPTION
//            Text(messageTitle)
//                .font(.title)
//                .foregroundColor(Color("black"))
//                .lineLimit(2)
          
            if !infoTapped {
                VStack {
                 //  Text(messageDescription)
                    GradientText(text: messageDescription, gradient: [Color("black"), Color("black"), .purple])
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding()
    //                        .background(
    //                            Rectangle()
    //                                .background(.ultraThinMaterial)
    //                                .opacity(0.10)
    //
    //                        )
    //                        .background(Circle()
    //                                        .fill(.purple.opacity(0.5))
    //                                        .blur(radius: 33)
    //                                        .offset(x:90, y:98)
    //                                        .frame(width: 266, height: 266)
    //                        )
                    //        .cornerRadius(20)
                            .onTapGesture {
                                isPasswordFocused = false
                                isEmailFocused = false
                            }
                            .offset(x:animate ? -390 : !animate ? 0 : 0)
                        .animation(.spring(), value: animate)
                    }
                    
                
            }
               
        }
    }
    var helpSuggestions: some View{
        VStack{
            //MARK: Message and questions
            
            
            VStack{
                Text("How you resolve problems signing into your fusion account depends on the type of issue preventing you from signing in. For example, are you having a password problem? Did you forget your username? Or did you get a message that your account is locked? To help you find the correct solution, select the issue from below that best describes the reason you can't sign in.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(
                        Rectangle()
                            .background(.ultraThinMaterial)
                            .opacity(0.10)
                        
                    )
                    .background(Circle()
                                    .fill(.purple.opacity(0.5))
                                    .blur(radius: 33)
                                    .offset(x:90, y:98)
                                    .frame(width: 266, height: 266)
                    )
                    .cornerRadius(20)
                    .onTapGesture {
                        isPasswordFocused = false
                        isEmailFocused = false
                    }
            }.padding(.bottom, 10)
            
            HStack{
                VStack (alignment: .leading, spacing: 13){
                    NavigationLink {helpwithSignin(
                        doneIntro: $doneIntro,
                        question: 1,
                        showalltextFields: true)}
                label: {
                    Label("Help with verification",
                          systemImage: "questionmark.circle")
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                }.padding(.horizontal,20)
                        .padding(.vertical,14)
                        .background(.ultraThinMaterial)
                        .cornerRadius(15)
                    
                    Divider()
                        .padding(.horizontal, 50)
                    
                    NavigationLink {helpwithSignin(
                        doneIntro: $doneIntro,
                        question: 2,
                        backgroundColor: "Background",
                        background: "image_03",
                        icon: "questionmark.circle",
                        titleMessage: "Forgot you email?",
                        titleDescription: "If you forgot your Fusion account email address or you signed in and got the error message, That account may not exist, we recommend you to request a security code to be sent to the phone number or email you used.",
                        askText: "Email/Phone",
                        userMessage: "Submit")}
                label: {
                    Label("Forgot you email",
                          systemImage: "questionmark.circle")
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                }.padding(.horizontal,20)
                        .padding(.vertical,14)
                        .background(.ultraThinMaterial)
                        .cornerRadius(15)
                    
                    Divider().padding(.horizontal, 50)
                    NavigationLink {helpwithSignin(
                        doneIntro: $doneIntro, question: 3,
                        backgroundColor: "Background",
                        background: "image_03",
                        icon: "person.circle",
                        titleMessage: "Forgot you password?",
                        titleDescription: "If the password you typed is incorrect, you’ll see a message that says: Your account or password is incorrect. If you don't remember your password, reset it now.",
                        askText: "Email",
                        userMessage: "Reset")
                        
                    }
                label: {
                    Label("Forgot your password",
                          systemImage: "questionmark.circle")
                    Spacer()
                    Image(systemName: "chevron.right")
                }.padding(.horizontal,20)
                        .padding(.vertical,14)
                        .background(.ultraThinMaterial)
                        .cornerRadius(15)
                    
                    Divider().padding(.horizontal, 50)
                    VStack{
                        Button {
                           
                            doneIntro = false
                            signIn = false
                        }
                    label: {
                        Label("Make a new account",
                              systemImage: "questionmark.circle")
                        
                        Spacer()
                        Image(systemName: "chevron.right")
                        
                    }
                    .padding(.horizontal,20)
                    .padding(.vertical,14)
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                    }
                }
            }
            .foregroundColor(Color("black"))
            Spacer()
            
        }.padding()
            .navigationBarTitle("Trouble signing in ?")
          
        
    }
    var textandsecureFields: some View{
        VStack(alignment: .center, spacing:8){
            Spacer()
            //MARK: Fields and submit button
           
            Group {
                titleandDescription
                    .padding(.bottom, -12)
                VStack {
                    
                    TextField("Email address", text: $text)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .customField(icon: "envelope.open.fill")
                        .newoffwhite(offwhiteisTapped: isEmailFocused, cornerradius: 15)
                        .overlay(
                            GeometryReader { proxy in
                                let offset = proxy.frame(in: .named("stack")).minY + 32
                                Color.clear.preference(key: CirclePreferenceKey.self, value: offset)
                            }
                                .onPreferenceChange(CirclePreferenceKey.self) { value in
                                    circleInitialY = value
                                    circleY = value
                                }
                        )
                        .focused($isEmailFocused)
                        .onChange(of: isEmailFocused) { isEmailFocused in
                            if isEmailFocused {
                                withAnimation {
                                    
                                    vibrate()
                                    userTyping()
                                    circleY = circleInitialY
                                }
                            }
                        }
                    Divider()
                    
                    
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .customField(icon: "key.fill")
                        .newoffwhite(offwhiteisTapped: isPasswordFocused, cornerradius: 15)
                        .focused($isPasswordFocused)
                        .onChange(of: isPasswordFocused, perform: { isPasswordFocused in
                            if isPasswordFocused {
                                withAnimation {
                                    
                                    vibrate()
                                    userTyping()
                                    circleY = circleInitialY + 70
                                    
                                }
                            }
                        })
                }//.offset(y: !infoTapped ? 0 : UIScreen.main.bounds.height * 0.3)
               
                .padding()
                .newoffwhite(offwhiteisTapped: false, cornerradius: 15)
                
                Button {
                    //model.dismissModal.toggle()
                    login()
                    vibrate()
                    
                } label: {
                    
                    AngularButton(title: userMessage)
                        .padding(.horizontal,90)
                        .padding(.top, isEmailFocused || isPasswordFocused ? 0 : 10)
                        .padding(.bottom, isEmailFocused || isPasswordFocused ? 10 : 0)
                    
                }.padding(.top,10)
            }
        }
        .padding(.horizontal, 13.0)
        //.transition(.scale.combined(with: .opacity))
        .offset(y: signInTapped ? 700 : 0)
        .onDisappear(perform: {
            signInTapped = false
        })
        .animation(.spring(), value: animate)
//        .transition(.asymmetric(
//            insertion: .move(edge: .bottom),
//            removal: .move(edge: .bottom)
//        ))
    }
    
    func userTyping(){
        infoTapped = false
    }
    func keyboardTapped(){
        isEmailFocused = false
        isPasswordFocused = false
        vibrate()
    }
    func infoPressed(){
        vibrate()
        isEmailFocused = false
        isPasswordFocused = false
        withAnimation(.spring()) {
            
            infoTapped.toggle()
            
        }
        
        if infoTapped{
            
            
            
            infoMessage = "How you resolve problems signing into your fusion account depends on the type of issue preventing you from signing in. For example, are you having a password problem? Did you forget your username? Or did you get a message that your account is locked? To help you find the correct solution, select the issue from below that best describes the reason you can't sign in."
            userMessage = "Try Signing in"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                showtext = true
            }
            showtext = false
            
            
        } else{
            messageDescription = "Log in to your account to access your profile. Furthermore, you can sign up if you don't have an account with us. (Sign Up)"
            infoMessage = ""
            showtext = false
            userMessage = "Sign In"
            
        }
        
    }
    func vibrate() {
        let impactMed = UIImpactFeedbackGenerator(style: .light)
        impactMed.impactOccurred()
    }
    
    func login() {
        //check animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeInOut(duration: 1)) {
                signInTapped = true
            }
        }
      
        if infoTapped{
            infoPressed()
        } else {
            Auth.auth().signIn(withEmail: text, password: password) { (result, error) in
                if error != nil {
                    
                    //if the auth is unsuccessful
                    UserDefaults.standard.set(false, forKey: "signIn")
                    self.alertMessage = error?.localizedDescription ?? ""
                    userMessage = "There was an error!"
                    //                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    //                    userMessage = "\(error?.localizedDescription ?? "")"
                    //                }
                    
                } else {
                    let db = Firestore.firestore()
                    let user = Auth.auth().currentUser
                    // Set the data to update
                    
                    db.collection("users").whereField("email", isEqualTo: user?.email ?? "")
                        .getDocuments() { (querySnapshot, error) in
                            if error != nil {
                                
                            } else {
                                for document in querySnapshot!.documents {
                                    db.collection("users").document("\(document.documentID)").setData(["online": true], merge: true) { error in
                                        
                                        if error == nil {
                                            
                                            
                                        }
                                    }
                                }
                            }
                        }
                    
                    //if the auth is not successful
                    userMessage = "Checking info..."
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        userMessage = "Successful..."
                        vibrate()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        userMessage = "Signing you in..."
                        vibrate()
                        
                    }
                    
                    
                    // Logs the user in then dismisses the model
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        selected = 0
                        self.signIn = true
                        UserDefaults.standard.set(true, forKey: "signIn")
                        self.text = "\(signIn)"
                        self.password = ""
                        userMessage = "Sign in"
                        
                    }
                }
            }
        }
        
        
        
    }
    
    
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        
        ViewController()
         .preferredColorScheme(.light)
        //  helpwithSignin()
        
    }
}

// MARK: the help struct
struct helpwithSignin: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("signIn") var signIn = false
    @Binding var doneIntro : Bool
    @State var question = 1
    @State var backgroundColor = "Background"
    @State var background = "Blob 1"
    @State var icon = "person.circle"
    @State var titleMessage = "Verification"
    @State var titleDescription = "If you don’t see an option for where to send a code or you no longer have access to any of the verification options shown, you won't be able to reset your password this way. Remember to check your email when signing up for a verification code. Yes even in your junk folder. You can also request a new verification email below."
    @State var askText = "Email"
    @State var text = ""
    @State var userMessage = "Submit"
    
    @State var askSecure = "Secure"
    @State var secureText = ""
    @State var showalltextFields = false
    @State var showtextSubmit = true
    @State var showsecureSubmit = true
    @FocusState var isEmailFocused: Bool
    @State var showButton = true
    
    
    
    var body: some View {
        
        VStack{
            iconTitleMessage
            Spacer()
            
            Divider()
            ZStack {
                LottieView(filename: "birds" ,loop: true)
                    .frame(width: 399)
                alltextFields
                    .padding(.vertical,5)
                    .padding(.horizontal,5)
            }
            
            if showButton {
                Button {
                    submit()
                } label: {
                    AngularButton(title: userMessage)
                        .padding(.horizontal,90)
                        .padding(.top, 20)
                }
            }
            
            
        } .padding(20)
            .background(
                
                Image("ob7")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .offset(x:UIScreen.main.bounds.width * 0.99)
                    .blur(radius: 17)
                
                    .padding()
                    .edgesIgnoringSafeArea(.all) )
            .statusBar(hidden: false)
            .background(Color(backgroundColor).edgesIgnoringSafeArea(.vertical))
            .onTapGesture{hidekeyboard()}
        
        
            .navigationBarBackButtonHidden(false)
        
            .onAppear {
                method()
            }
    }
    
    var iconTitleMessage: some View {
        VStack(spacing:10){
            VStack(spacing:10) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(.secondary)
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(30)
                
                
                Text(titleMessage)
                    .font(.title2)
                    .fontWeight(.regular)
                    .foregroundColor(Color("black"))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 19)
                    .background(.ultraThinMaterial)
                    .cornerRadius(25)
                    .onTapGesture {
                        //presentationMode.wrappedValue.dismiss()
                        hidekeyboard()
                        
                    }
                
            }
            Divider()
            Text(titleDescription)
                .font(.subheadline)
                .padding(18)
                .background(.ultraThinMaterial)
                .cornerRadius(25)
                .multilineTextAlignment(.center)
        }.padding(.top, -80)
            .onTapGesture {
                hidekeyboard()
            }
        
        
    }
    var alltextFields: some View {
        VStack{
            
            Group{
                if showtextSubmit{
                    TextField(askText, text: $text)
                        .keyboardType(.default)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .customField(icon: "envelope.open.fill")
                        .focused($isEmailFocused)
                        .onTapGesture {
                            userMessage = "Submit"
                            vibrate()
                        }
                        .onChange(of: text) { text in
                            userMessage = "Submit"
                        }
                }
                
                
                if showsecureSubmit{
                    SecureField(askSecure, text: $secureText)
                        .keyboardType(.default)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .customField(icon: "key")
                        .focused($isEmailFocused)
                        .onTapGesture {
                            userMessage = "Submit"
                            vibrate()
                        }
                        .onChange(of: secureText) { secureText in
                            userMessage = "Submit"
                        }
                }
                
            }
            Spacer()
            
            
        }
    }
    func hidekeyboard(){
        isEmailFocused = false
    }
    func method(){
        vibrate()
        
        if question == 1 || question == 2 || question == 3 || question == 4 {
            
            showsecureSubmit = false
            
        }
        
        if question == 1{
            
            
        }
        if question == 2{
            
            showtextSubmit = true
            
            
        }
        if question == 3{
            
            
        }
        if question == 4{
            
            showtextSubmit = false
            showButton = true
            
            
        }
        
    }
    func submit(){
        vibrate()
        if question == 1 || question == 2 || question == 3  {
            
            if text.isEmpty || !text.contains("@") || !text.contains("."){
                userMessage = "Retype email"
            }else {
                userMessage = "Sending email..."
                userMessage = "Email sent"
            }
            
        } else if question == 4 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                userMessage = "Let's GO!"
                UserDefaults.standard.set(true, forKey: "doneIntro")
                signIn = false
                doneIntro = false
                vibrate()
            }
            userMessage = "Loading..."
            
        }
        
    }
    func vibrate() {
        let impactMed = UIImpactFeedbackGenerator(style: .light)
        impactMed.impactOccurred()
    }
}




