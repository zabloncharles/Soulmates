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
    @AppStorage("firstday") var firstday = false
    @State var onScreen = 0
    @State var nextButtonPressed = false
    @State var image: UIImage?
    @State var firstname = "Billi"
    @State var lastname = "Van"
    @State var selectedDate = Date()
    @State var email = "test@gmail.com"
    @State var password = "123456"
    @State var newAge = "No data"
    @State var error = false
    @State var errorMessage = "There was an error"
    @State var showAngular = false
    @State var birthDate = Date()
    @State var pressedBack = false
    @State var signinPressed = false
    @Binding var doneIntro : Bool
    @Binding var signIn : Bool
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
                    
                    switch onScreen {
                        case 0:
                            TabView(selection: $switching){
                            ZStack {
                                
                                WelcomeMessage(title: "Fusion", message: "Fusion is a women's health app, that supports women at each stage of their reproductive cycle. It tracks menstruation, cycle prediction, preparation for conception, pregnancy, early motherhood and menopause.", gradientTitle: [Color("black"), Color("black"), .red], gradientMessage: [Color("black") , Color("black"), Color("black"), .red, Color("black")], switching: $switching)
                                    .transition(pressedBack ? transitionBack : transition)
                                     signinbutton
                                
                            }.tag(0)
                            
                        
                            WelcomeMessage(title: "Sign Up!", message: "We are going to ask you a few questions on the next page so we can build a profile for you. You can click on the top left to go back if you make a mistake. Now let's get started!", gradientTitle: [Color("black"), Color("black"), .red], gradientMessage: [Color("black") , Color("black"), Color("black"), .red, Color("black")], switching: $switching)
                                .tag(1)
                           
                                OnboardThirdPage(firstname: $firstname, lastname: $lastname, errormessage: errorMessage,onScreen: $onScreen, switching: $switching)
                                .tag(2)
                                
                          
                                
                            } .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            
                        case 1:
                            OnboardSecondPage(newAge: $newAge, onScreen: $onScreen, switching: $switching)
                                .tag(3)
                            
                            
                        default:
                            FinalPage(image: $image, email: $email, password: $password, onScreen: $onScreen, success: $success)
                                .tag(4)
                                
                    }
             
                    
                        
                    
                }.background(
                    Image("Blob 1")
                        .offset(x: -154, y: -340)
                        .edgesIgnoringSafeArea(.all)
                    .blur(radius: 58)
                )
                    
                 .padding(.bottom, 50)
                 
                
        
                
                
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
                    .padding(.horizontal, error ? 70 : 139)
                    .padding(.bottom, 20)
                    .scaleEffect(nextButtonPressed ? 0.97 : 1)
                    .onTapGesture {
                        angularButtonPressed()
                        withAnimation(.easeInOut) {
                            success.toggle()
                        }
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
                    LinearGradient(gradient: Gradient(colors: [.white, Color.red]), startPoint: .leading, endPoint: .trailing)
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
                    .scaleEffect(signinPressed ? 0.97 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            signinPressed = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                withAnimation(.spring()) {
                                    signinPressed = false
                                        doneIntro = true
                                       
                                        
                                        
                                    
                                }
                            }
                        }
                    }
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
       // OnboardingView()
      //  OnboardingView(doneIntro: .constant(false), signIn: .constant(false))
          //  .preferredColorScheme(.dark)
        ViewController()
           .preferredColorScheme(.dark)
                }
}


//Welcome info
// MARK: Fisrt Page - Welcome
struct WelcomeMessage: View {
    var title = "Welcome to Fusion"
    var message = "Here at Fusion LLC, we have dedicated half of our life in the solde pupose of helping women all around the globe get the health that they deserve."
    var gradientTitle : [Color] =  [.white , .orange, .white]
    var gradientMessage : [Color] =  [.blue , .orange, .white]
    var image = "fusionhalfgirl"
    @State var appears = false
    @State var backButtonAppeared = false
    @State var messageeTapped = false
    @Binding var switching : Int
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .leading),
        removal: .move(edge: .leading))
    var body: some View {
        ZStack {
            LottieView(filename: "stars" ,loop: appears)
               .frame(width: 380)
               .offset(x: 0, y: -420)
             
            LottieView(filename: "birds" ,loop: appears)
               .frame(width: 380)
               .offset(x: 0, y: -220)
             
          
            
            ZStack {
                
                if switching < 1 {
                    VStack{
                     
                        Image(image)
                           .resizable()
                           .aspectRatio(contentMode: .fit)
                       .frame(width: 350, height: 350, alignment: .center)
                       .offset(y: UIScreen.main.bounds.height * -0.1)
                      
                    }
                   
                } else {
                    
                    LottieView(filename: "woman2" ,loop: true)
                       .frame(width: 200)
                       .offset(y: UIScreen.main.bounds.height * -0.10)
                }
                  
            }
            .scaleEffect(appears ? 1 : 0.96)
           
            .onTapGesture {
                withAnimation(.spring()){
                    appears.toggle()
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 4)){
                    appears = true
                }
                
            }
            .onDisappear {
                appears = false
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Spacer()
              
                   
              
                VStack(alignment: .leading, spacing: 4){
                    Text(title)
                        .fontWeight(.bold)
                        .foregroundColor(.clear)
                        .background(
                            LinearGradient(gradient: Gradient(colors: gradientTitle), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                                .mask(
                                    Text(title)
                                ))
                    .font(.title)
                    .padding(.horizontal, -3)
                    
                   
                        
                Text(message)
                    .fontWeight(.thin)
                    .foregroundColor(.clear)
                    .background(
                        LinearGradient(gradient: Gradient(colors: gradientMessage), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                           
                            .mask(Text(message)))
                    .font(.callout)
                }.padding()
                    .background(
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .opacity(0)
                    )
                   // .rotation3DEffect(Angle(degrees: messageeTapped ? 180 : 0), axis: (x: 0, y: 180, z: 0))
                    .animation(.spring(), value: messageeTapped)
      
                
            }.padding(.horizontal, 18)
                .edgesIgnoringSafeArea(.all)
             .padding(.bottom, 29)
             .onTapGesture(perform: {
                 messageeTapped.toggle()
             })
        }

    }
 
}


// MARK: Name
struct OnboardThirdPage: View {
    @State var erroralert = false
    @Binding var firstname : String
    @Binding var lastname : String
    @State var errormessage = "Something isn't quite right"
    @FocusState var isFirstnameFocused: Bool
    @FocusState var isLastnameFocused: Bool
    @Binding var onScreen : Int
    @State var appears = false
    @Binding var switching : Int
    
    var body: some View{
        ZStack{
          
            LottieView(filename: "birds" ,loop: true)
                .frame(width: 380)
                .offset(x: 0, y: -280)
            
            if appears {
                LottieView(filename: "confetti" ,loop: true)
                    .frame(width: 380)
                    .scaleEffect(appears ? 1.2 : 1 )
                    .offset(x: 0, y: -60)
                    .opacity(appears ? 1 : 0)
                    .transition(.scale.combined(with: .opacity ))
            } else {
                LottieView(filename: "writing" ,loop: true)
                    .frame(width: 380)
                    .offset(x: 0, y: -50)
                    .shadow(color: .black, radius: appears ? 0 : 0.4, x: 4, y: 5)
                    .transition(.scale.combined(with: .opacity))
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            appears = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                            withAnimation(.easeInOut) {
                                appears = false
                            }
                        }
                    }
            }
            
            
            VStack(alignment: .leading, spacing: 5) {
                
                HStack(spacing: 1.0){
                    Image(systemName: "chevron.left")
                    Text("Back")
                    
                    
                }
                .font(.headline)
                .onTapGesture{
                   // onScreen -= 0
                    withAnimation(.easeInOut) {
                        switching = 1
                    }
                }
          
            
           
            
            VStack(alignment: .leading, spacing: 10) {
                   
                VStack(alignment: .leading, spacing: 0) {
                    
                    GradientText(text: "What is " , gradient: [Color("black"), .blue,Color("black"),.gray])
                        .font(.largeTitle.bold())
                    GradientText(text: "your name ?" , gradient: [Color("black"), .blue,Color("black"),.gray])
                        .font(.largeTitle.bold())
                    GradientText(text: " Please enter your full name below." , gradient: [Color("black")])
                        .font(.headline)
                    
                }.padding(.leading, 15)
                    .padding(.vertical, 0)
                     
                         
                
                Spacer()
                
                
                VStack {
                    Group {
                        TextField("", text: $firstname)
                            .textContentType(.givenName)
                            .keyboardType(.alphabet)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                            .placeholder(when: firstname.isEmpty) {
                                Text("first name...")
                                    .foregroundColor(.gray)
                                    .blendMode(.lighten)
                            }
                            .customField(icon: "pencil")
                            .focused($isFirstnameFocused)
                           
                            .onTapGesture {
                                erroralert = false
                               
                            }
                        
                        TextField("", text: $lastname)
                            
                            .textContentType(.familyName)
                            .keyboardType(.alphabet)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                            .placeholder(when: lastname.isEmpty) {
                                Text("last name...")
                                    .foregroundColor(.gray)
                                    .blendMode(.lighten)
                                
                            }
                            .customField(icon: "pencil.slash")
                            .focused($isLastnameFocused)
                            
                            .onTapGesture {
                                erroralert = false
                            }
                      
                    }
                }.padding()
            }
            }
           
            .padding(20)
            .padding(.bottom, 30)
            .frame(maxWidth: .infinity)
           
           
        }
        
    }
    
   
  
    
}
// MARK: Birthday
//Birthday
struct OnboardSecondPage: View {
    var title = "age"
    var message = "age"
    var gradientTitle : [Color] =  [.black, .purple]
    var gradientMessage : [Color] =  [.black , .purple, .red]
    @State var appears = false
    @State var firstName = ""
    @Binding var newAge : String
    @State var birthDate = Date()
    @Binding var onScreen : Int
    @Binding var switching : Int
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }
    var body: some View {
        
        ZStack{
            
            LottieView(filename: "birds" ,loop: true)
                .frame(width: 380)
                .offset(x: 0, y: -280)
            
            if appears {
                LottieView(filename: "confetti" ,loop: true)
                    .frame(width: 380)
                    .scaleEffect(appears ? 1.2 : 1 )
                    .offset(x: 0, y: -60)
                    .opacity(appears ? 1 : 0)
                    .transition(.scale.combined(with: .opacity ))
            } else {
            LottieView(filename: "girlonphone" ,loop: true)
                .frame(width: 380)
                .offset(x: 0, y: -50)
                .shadow(color: .black, radius: appears ? 0 : 0.4, x: 4, y: 5)
                .transition(.scale.combined(with: .opacity))
                .onTapGesture {
                    withAnimation(.easeInOut) {
                    appears = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                        withAnimation(.easeInOut) {
                            appears = false
                        }
                    }
                }
            }
            
            
            VStack(alignment: .leading, spacing: 5) {
                
                HStack(spacing: 1.0){
                    Image(systemName: "chevron.left")
                    Text("Back")
                        
                }
                .font(.headline)
                .onTapGesture{
                    onScreen -= 1
                    switching = 2
                }
                VStack(alignment: .leading, spacing: 0) {
                    
                    GradientText(text: "What is " , gradient: [Color("black"), .purple,.yellow])
                        .font(.largeTitle.bold())
                    GradientText(text: "your date of birth ?" , gradient: [Color("black"), .purple,.yellow])
                        .font(.largeTitle.bold())
                    GradientText(text: " Please enter the date of birth below." , gradient: [Color("black")])
                        .font(.headline)
                    
                }.padding(.leading, 15)
                    .padding(.vertical, 0)
                
                
                
                
                
                
                Spacer()
                
                VStack {
                    Text("\(birthDate, formatter: dateFormatter)")
                   // Text("\(newAge)")
                        .padding()
                        .foregroundColor(.gray)
                        .opacity(appears ? 0 : 1)
                        .scaleEffect(appears ? 0 : 1)
                        .offset(y: -50)
                    
                    
                    DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                        Text("")
                        
                    }
                    .datePickerStyle(WheelDatePickerStyle())
                    .onChange(of: birthDate) { newValue in
                        convertAge()
                    }
                    
                    
                    
                    
                    
                    
                }.frame(maxWidth: .infinity)
                
                
                    .padding(30)
                
                
                
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            
            
        }.onAppear {
           
                appears = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                withAnimation(.easeInOut) {
                    appears = false
                }
            }
        }
        .onDisappear {
            appears = false
        }
        
        
    }
    
    func convertAge(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        
        let date = formatter.string(from: birthDate)
        let tes = "\(date)"
        
        let birthday = formatter.date(from: ("\(tes)"))
        let timeInterval = birthday?.timeIntervalSinceNow
        let age = abs(Int(timeInterval! / 31556926.0))
        
        
        newAge = "\(age)"
        
        
        
        
    }
}
// MARK: Email & password
struct FinalPage: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var image: UIImage?
    @Binding var email : String
    @Binding var password : String
    @FocusState var isEmailFocused: Bool
    @FocusState var isPasswordFocused: Bool
    @State var showImagePicker = false
    @State var appeared = false
    @State var appears = false
    @State var tappedImage = false
    @Binding var onScreen : Int
    @Binding var success : Bool
    @State var delayImage = true
    
    var body: some View {
        ZStack{
//            VStack{
//                if let image = self.image{
//
//
//                    Image(uiImage: image)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .rotationEffect(.degrees(tappedImage ? 360 : 0))
//
//
//                } else {
//                    Image(systemName: "camera")
//
//                        .aspectRatio(contentMode: .fit)
//                        .font(.body)
//                        .padding()
//                        .rotationEffect(.degrees(tappedImage ? 90 : 0))
//
//
//                }
//            }.frame(width:  90, height:  90)
//                .background(.ultraThinMaterial)
//                .background(Circle().fill(.blue).blur(radius: 30))
//                .cornerRadius(80)
//                .background(
//                    Circle()
//
//                        .fill(.ultraThinMaterial)
//                        .padding(-0.6)
//
//
//                )
//                .scaleEffect(tappedImage ? 0.91 : 1)
//                .onTapGesture {
//                    withAnimation(.easeInOut) {
//
//                        tappedImage = true
//
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
//
//                            showImagePicker.toggle()
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
//                                tappedImage = false
//                            }
//
//
//                        }
//                    }
//
//                }

            LottieView(filename: "birds" ,loop: true)
                .frame(width: 380)
                .offset(x: 0, y: -280)
            
            if appears {
                LottieView(filename: "confetti" ,loop: true)
                    .frame(width: 380)
                    .scaleEffect(appears ? 1.2 : 1 )
                    .offset(x: 0, y: -60)
                    .opacity(appears ? 1 : 0)
                    .transition(.scale.combined(with: .opacity ))
            } else {
                
                VStack{
                if !success {
                    LottieView(filename: colorScheme == .dark ? "girlpic2dark" : "girlpic2" ,loop: false)
                        .frame(width: 230)
                        
                        .offset(x: 0, y: -45)
                        .shadow(color: .black, radius: 0.4, x: 6, y: 0)
                    
                        .transition(.scale.combined(with: .opacity))
                     
                } else {
                    if !showImagePicker {
                        LottieView(filename: colorScheme == .dark ? "girlpic1dark" : "girlpic1" ,loop: false)
                        .frame(width: 250)
                        .offset(x: 0, y: -45)
                        .overlay(
                            VStack{
                                VStack {
                                    if let image = self.image{
                                        
                                        
                                        ZStack {
                                            ProgressView()
                                                .opacity(delayImage ? 0.70 : 0)
                                            
                                            Image(uiImage: image)
                                                .resizable(resizingMode: .stretch)
                                                .aspectRatio(contentMode: .fill)
                                                .overlay(
                                                    Image(systemName: "checkmark.seal.fill")
                                                        .foregroundColor(.primary)
                                                
                                                )
                                                .opacity(delayImage ? 0.77 : 0)
                                                .onAppear{
                                                    withAnimation(.easeInOut(duration: 4)) {
                                                delayImage = true
                                                    }
                                                }
                                                .onDisappear {
                                                    withAnimation(.easeInOut) {
                                                    delayImage = false
                                                    }
                                            }
                                        }
                                        
                                        
                                        
                                    } else {
                                        
                                            ProgressView()
                                                
                                        
                                    }
                                }
                            
                            } .frame(width: 97, height: 136)
                                .cornerRadius(1)
                                .offset(x:-31 , y: -20)
                                .rotationEffect(.degrees( -15))
                        )

                       // .shadow(color: .black, radius: 0.4, x: 6, y: 0)
                       .transition(.scale.combined(with: .opacity))
                }
                }
                    
                }
                .scaleEffect(success ? 0.97 : 1)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        appears = true
                        success = true
                        delayImage = true
                        
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                        withAnimation(.easeInOut) {
                            appears = false
                            
                            tappedImage = true
                            showImagePicker.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation(.easeInOut(duration: 3)) {
                                        tappedImage = false
                                        delayImage = false
                                    }
                                }
                                
                                
                            }
                        }
                    }
                
                }
            }
            
            
           
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 5) {
                    
                    HStack(spacing: 1.0){
                        Image(systemName: "chevron.left")
                        Text("Back")
                        
                    }
                    .font(.headline)
                    .onTapGesture{
                        onScreen -= 1
                        // switching = 2
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        
                        GradientText(text: "Complete" , gradient: [Color("black"), .purple,Color("black"),.purple])
                            .font(.largeTitle.bold())
                        GradientText(text: "Signing up!" , gradient: [Color("black"), .purple,Color("black"),.purple])
                            .font(.largeTitle.bold())
                        GradientText(text: " Please enter an email and password." , gradient: [Color("black")])
                            .font(.headline)
                        
                    }.padding(.leading, 15)
                        .padding(.vertical, 0)
                    
                    
                }.padding(.leading)
                
                VStack{
                
                    
                    VStack(alignment: .center) {
                        
                       
                        
                        Text("Enter your email address and type a new password to create your account. You can click the image below to upload your profile picture.")
                            .foregroundColor(.clear)
                            .multilineTextAlignment(.center)
                        
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color("black"), .orange, Color("black")]), startPoint: .leading, endPoint: .trailing)
                                
                                    .mask(Text("Enter your email address and type a new password to create your account. You can click the camera icon to upload your profile picture.")
                                            .multilineTextAlignment(.center)))
                            .padding()
                            
                        
                           
                            .font(.callout)
                        
                        
                    }
                    .padding(.vertical, 10)
                    
                    .onAppear{
                        withAnimation(.easeIn(duration: 2)) {
                            appeared = true
                        }
                        withAnimation(.easeIn(duration: 8)) {
                            appeared = false
                        }
                        
                    }
                    .onDisappear{
                        withAnimation(.easeIn(duration: 3)) {
                            appeared = false
                        }
                        
                    }
                    
                    
                    
                    
                    Spacer()
                    
                    VStack {
                        Group {
                            TextField("", text: $email)
                                .textContentType(.emailAddress)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .placeholder(when: email.isEmpty) {
                                    Text("Email address...")
                                        .foregroundColor(.gray)
                                       
                                }
                                .customField(icon: "envelope.open.fill")
                                .focused($isEmailFocused)
                            
                            
                            SecureField("", text: $password)
                                .textContentType(.password)
                                .placeholder(when: password.isEmpty) {
                                    Text("Password...")
                                        .foregroundColor(.gray)
                                        
                                }
                                .customField(icon: "key.fill")
                                .focused($isPasswordFocused)
                            
                            
                        }
                    }.padding()
                        
                    
                }.padding(.horizontal,20)
                    .padding(.bottom, 50)
            }
            if appears {
            VStack{
                LottieView(filename: "confetti" ,loop: true)
                    .frame(width: 380)
                    .scaleEffect(appears ? 1.2 : 1 )
                    .offset(x: 0, y: -60)
                    .opacity(appears ? 1 : 0)
                    .transition(.scale.combined(with: .opacity ))
            }
            }
            
            
        }.onAppear {
            withAnimation(.spring()) {
                 }
            }
        .onDisappear(perform: {
            isEmailFocused = false
            isPasswordFocused = false
        })
        .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil) {
                       ImagePicker(image: $image)
                           .ignoresSafeArea()
                   }
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
                    signIn = true
                    firstday = true
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
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
}
    
}
