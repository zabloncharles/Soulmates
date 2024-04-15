//
//  SigninView.swift
//  SigninView
//
//  Created by Meng To on 2021-07-27.
//

import SwiftUI


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
    @AppStorage("doneIntro") var doneIntro = false
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
                            .opacity(0)
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
              //  NavigationLink(destination:  helpSuggestions) {
                  
                HStack {
                    Text("Sign Up")
                        .padding(.horizontal,10)
                        .padding(.vertical,7)
                        .neoButtonOff(isToggle: false, cornerRadius: 8) {
                            //
                            doneIntro = false
                        }
                    Spacer()
                    Image(systemName: "info.circle")
                        .padding(.horizontal,5)
                        .padding(.vertical,5)
                   
                        
                  
                }
                        
                  
               // }
              
                
                
            }.padding(.horizontal,20)
                .onTapGesture {
                    withAnimation(.spring()) {
                        infoPressed()
                    }}
            
            
            
            Spacer()
        }
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
                  
                        .neoButtonOffShadow(cornerRadius: 15, isTapped: false)
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
                     
                        .neoButtonOffShadow(cornerRadius: 15, isTapped: false)
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
                .neoButtonOff(isToggle: false, cornerRadius: 15, perform: {
                    //
                })
                Button {
                    //model.dismissModal.toggle()
                    login()
                    vibrate()
                    
                } label: {
                    
                    Text(userMessage)
                    
                        .neoButtonOffShadow(cornerRadius: 15, isTapped: false)
                        .padding(.horizontal,120)
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





