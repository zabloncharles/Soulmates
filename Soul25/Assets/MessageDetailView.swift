//
//  MessageDetailView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/19/23.
//



import SwiftUI

struct MessageDetailView: View {
    @AppStorage("hidemainTab") var hidemainTab = false
   
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State var text = "yo"
    //@Binding var section: NotificationModel
    @State var hideNav = false
    @State var scrolling = CGFloat(0)
    @State var scrolledItem: Int = 0
    @State var chatMessages: [MessageModel] = []
    var log: UserStruct
    @State var userAvatarLoaded = false
   // var log : MessageUser
    // var holdData : [IncomingMessage]
    @State private var messageText = ""
    @State private var sender = "John"
    @State var guardSending = false
    @State var userscrolled = false
    @FocusState private var keyboardFocus: Bool
    @State private var typing = false
    @State private var typedText = ""
    @State var scrollingUp = false
    @State var backButtonTapped = false
    @State var btapped = ""
    @State var blurPage = false
    @State var bubblesAppeared = false
    @State var messageDeleted = false
    @State private var scrollToBottom: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                content
                cover
                texting
                
            }
            .zIndex(1)
        }.navigationBarBackButtonHidden()
        .onAppear{
            withAnimation(.spring()) {
                hidemainTab = true
                chatMessages = messages
            }
        }
        .onDisappear {
            
            withAnimation(.spring()) {
                hidemainTab = false
            }
        }
    }
   
    var cover: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(backButtonTapped ? .clear : Color("black"))
//
                    .onTapGesture {
                        //go back to messages view
                        backButtonTapped = true
                        presentationMode.wrappedValue.dismiss()
                    }
          
                GetImageAndUrl(url:log.avatar, loaded: .constant(true), imageUrl: .constant(""))
                    .cornerRadius(80)
                    .neoButton(isToggle: false) {
                        //go to user profile
                    }
                    .mask(Circle())
                    .background(
                        Circle()
                            .fill(Color.clear)
                            .padding(-2)
                        
                    )
                    .frame(width: 40, height: 40)
                 
                VStack{
                    HStack(spacing: 4.0) {
                        Text(log.firstName)
                     
                            .font(.headline).bold()
                        .foregroundColor(.primary)
                        Image(systemName: "checkmark.circle")
                            .foregroundColor( .blue)
                            .font(.subheadline)
                        Spacer()
                    }
                    
                    HStack(spacing:2) {
                        Image(systemName: "circlebadge.fill")
                            .foregroundColor( .green)
                            .font(.caption2)
                        Text(" 2 minutes ago")
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.primary.opacity(0.7))
                    }
                    
                }.padding(.leading,5)
                Spacer()
                
                Image(systemName: "exclamationmark.circle")
                    .foregroundColor(.gray )
                    .font(.headline)
                    .padding(.trailing,10)
            }
            
            .padding(.horizontal,10)
            .padding(.top,50)
            .padding(.bottom,10)
            .background(Color("offwhiteneo"))
            Divider()
                .padding(.top,-8)
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var content: some View {
        VStack {
            ScrollViewReader { scrollViewProxy in
                ScrollView(showsIndicators: false) {
                  
                                    ForEach(chatMessages.sorted(by: { $1.timestamp > $0.timestamp })) {section in
                                   
                                        VStack {
                                        
                                            MessageBubblesView(section: section, blurPage: $blurPage, messageDeleted: $messageDeleted, bTapped: $btapped)
                                              
    //                                            .opacity(bubblesAppeared ? 1 : 0.30)
                                                .onLongPressGesture {
                                                    blurPage.toggle()
                                                 
                                                }
                                                
                                                .opacity( btapped == (section.timestamp ) ? 1 : blurPage ? 0 : 1)
                                                .blur(radius: btapped == (section.timestamp ) ? 0 :  blurPage ? 13 : 0)
                                                .id(section.id)
                                                .onAppear{
                                                    scrollViewProxy.scrollTo(((chatMessages[chatMessages.count - 4]).id), anchor: .bottom)
                                                }
    //                                            .onAppear {
    //
    //                                                    scrollViewProxy.scrollTo(((chatMessages[chatMessages.count - 2]).id), anchor: .bottom)
    //
    //                                                    withAnimation(.easeInOut) {
    //                                                        bubblesAppeared = true
    //                                                    }
    ////                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
    ////                                                    withAnimation(.spring()) {
    ////
    ////                                                            scrollViewProxy.scrollTo((chatMessages.last?.id), anchor: .bottom)
    ////                                                            scrollToBottom = true
    ////
    ////                                                    }
    ////                                                }
    //                                        }
                                        }
                                        
                                        
                                    }
                                    
                                
                            
                            
                        
                        .onChange(of: blurPage) { newValue in
                            if !blurPage {
                                btapped = ""
                            }
                        }
    //                    .onChange(of: messageDeleted) { newValue in
    //                        if messageDeleted {
    //                            blurPage = false
    //
    //                            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
    //
    //                            }
    //
    //                            typeWriteText("Message deleted!") {
    //                                //Message was deleted
    //                                messageDeleted = false
    //                            }
    //                        }
    //                    }
                        
                    
                    
                    
                    
                    
                    .padding(.top, 150)
                    
                 
                  
                }.coordinateSpace(name: "scrollView")
                .background( Color("offwhiteneo"))
                    .onTapGesture{
                        blurPage = false
                    }
            
                    .onTapGesture{
                        keyboardFocus = false
                    }
                  
               
                
            }
            .padding(.bottom,80)
      
            
            Spacer()
        }
            
        
    }
    var texting: some View {
        
        
        VStack{
            Spacer()
            // Usage example
            
            
            HStack {
                TextField("Message...", text: $messageText)
                    
                    .padding(.vertical,10)
                    .padding(.leading, 15)
                    .foregroundColor(guardSending ? .gray : Color("black"))
                  
                    .focused($keyboardFocus)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("black").opacity(0.70), lineWidth: 1)
                        
                    )
                    .cornerRadius(20)
                    
                   
                    .onChange(of: typing) { newValue in
                        if keyboardFocus {
                            typing = true
                        } else {
                            typing = false
                        }
                    }
                
                Image(systemName: "paperplane.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(messageText.count < 1 ? .gray : guardSending ? .red : .blue)
                    
                    .onTapGesture{
                        
                        if messageText.count > 0 && !guardSending{
                          //  sendMessage(message: messageText)
                            //send the fake text to array
                            sendFakeText()
                            messageText = ""
                        } else {
                            if !guardSending {
                                typeWriteText("You haven't typed anything bro :/") {
                                    print("Typing finished")
                                }
                            }
                        }
                        
                    }
                
            } .background( Color("offwhiteneo"))
                
                .padding()
            
                
            
        }    .modifier(KeyboardAwareModifier())
        
        
    }
  
    
    func sendFakeText(){
        
        
        // Generate and add a fake message to the chat
        let fakeMessage = MessageModel(userID: "user1", text: messageText, sender: "user1", timestamp: "\(Date())", stamp: "Sent")
        
        withAnimation {
            chatMessages.append(fakeMessage)
        }
    }
    func typeWriteText(_ text: String, completion: @escaping () -> Void) {
        let original = messageText
        messageText = ""
        var currentIndex = 0
        guardSending = true
        Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { timer in
            if currentIndex < text.count {
                let index = text.index(text.startIndex, offsetBy: currentIndex)
                let character = text[index]
                
                DispatchQueue.main.async {
                    withAnimation(.easeIn) {
                        messageText += String(character)
                    } // Update the typedText property on the main queue
                }
                
                currentIndex += 1
            } else {
                
                timer.invalidate()
                completion()
                Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
                    withAnimation(.easeInOut) {
                        messageText = original
                        
                        guardSending = false
                    }
                }
                
            }
        }
    }
    

    
    
}


struct MessageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // MessagesView(section: .constant(messageSections[0]))
        ViewController()
    }
}




struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}



