
//
//
//  Fusion (iOS)
//
//  Created by Zablon Charles on 2/17/22.
//

import SwiftUI

struct Notification: View {
    var title = "Whats the notification about?"
    var notification = "Whats the title?"
    var lottieAnimation = "notification"
    var notificationBackgroundColor = Color.blue
    @State var notificationTapped = false
    @State var showlottieAnimation = true
    @State var looplottieAnimation = true
    @Binding var showNotification : Bool
    @State var showbackgroundBlur = true
    @State var opacityColor = 450
    @State private var notificationPosition = CGSize.zero
    @State var autohideNotification = true
    
    
    var body: some View {
        
        ZStack{
            alertviewthatnotificationhasappeared
            blurbackground
            VStack {
                notificationpopup
                    .onAppear{
                        vibrate()
                    }
            }
        }
        
        
    }
    var alertviewthatnotificationhasappeared: some View {
        VStack{
            if showNotification && autohideNotification {
               
                    VStack{
                        Text("Dismiss Notification")
                            .opacity(0)
                    }.onAppear{
                       notificationAppeared()
                    }
                   
                
            }
        }
    }
    var notificationpopup: some View {
        VStack {
            
            HStack {
                
                
                VStack(spacing:10) {
                    
                    HStack {
                        if showlottieAnimation {
                            LottieView(filename: lottieAnimation ,loop: looplottieAnimation)
                                .frame(width: 30, height: 30)
                                .offset(x: -2, y: 1)
                                .scaleEffect(1.9)
                        }
                        Text(title)
                        
                    }
                    
                    
                }.foregroundColor(Color("white"))
                    .padding()
                
                Spacer()
                
                HStack {
                    HStack {
                        Text(notification)
                        
                    }   .font(.subheadline)
                        .foregroundColor(Color("black"))
                        .padding(.horizontal, 10)
                        .padding(.vertical,8)
                        .background(.white )
                        .cornerRadius(10)
                        .padding(.horizontal, 10)
                    
                }
                .onTapGesture{
                    notificationTappedFunc()
                }
                
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 1)
            .background(
                .ultraThinMaterial
            )
            
            .background(
                Rectangle()
                    .fill(.pink)
                    .opacity(Double(opacityColor) / 90))
            .background(
                Rectangle()
                    .fill(.white)
                    .opacity(Double(opacityColor) / 10))
            .cornerRadius(30)
            .scaleEffect(notificationTapped ? 0.97 : 1)
            .padding()
            .offset(notificationPosition)
           
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        userIsDraggingNotification()
                        withAnimation(.spring()){
                            notificationPosition = gesture.translation
                            self.notificationPosition = CGSize(width: UIScreen.main.bounds.width * 0, height:gesture.location.y)
                            //see position on screen
                            //  notification = "\(gesture.location.y)"
                        }
                    }
                    .onEnded { _ in
                        userIsDoneDraggingNotification()
                        if abs(notificationPosition.height) > 230 {
                            // remove the card
                            withAnimation(.spring()) {
                                self.notificationPosition = CGSize(width: UIScreen.main.bounds.width * 0, height: 0)
                            }
                        } else {
                            withAnimation(.spring()) {
                                notificationPosition = .zero
                            }
                        }
                    }
        )
            
                Spacer()
            
            
        }.offset(y: showNotification ? 0 : UIScreen.main.bounds.height * -0.4)
           
    }
    var blurbackground: some View {
        VStack{
            
            VStack{
                Spacer()
                HStack {
                    
                    Spacer()
                }
                Spacer()
            }
            
            .edgesIgnoringSafeArea(.all)
            .background(.ultraThinMaterial)
            .opacity(showNotification && showbackgroundBlur ? 1 : showNotification && !showbackgroundBlur ? 0.1 : 0)
            .onTapGesture{
                withAnimation(.spring()){
                    
                    showNotification = false
                    
                }
            }
            
        }
        
    }
    func notificationAppeared(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
            withAnimation(.spring()) {
                showNotification = false
            }
        }
    }
    func userIsDraggingNotification(){
        autohideNotification = false
        
    }
    func userIsDoneDraggingNotification(){
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.spring()) {
                showNotification = false
                vibrate()
            }
        }
    }
    func notificationTappedFunc(){
        // what happens when the notification is tapped ?
            withAnimation(.spring()) {
                notificationTapped =  true
            }
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.spring()) {
                notificationTapped =  false
            }
        }
    }
    func vibrate(){
        // vibrate phone when the notification is tapped
        let impactMed = UIImpactFeedbackGenerator(style: .light)
        impactMed.impactOccurred()
    }
}

struct settingsEditor_Previews: PreviewProvider {
    static var previews: some View {
        // Notification(showNotification: .constant(false))
        SettingsView()
    }
}
