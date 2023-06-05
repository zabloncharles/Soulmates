//
//  Email&PasswordView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 6/5/23.
//

import SwiftUI

struct Email_PasswordView: View {
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

//struct Email_PasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//      //  Email_PasswordView()
//    }
//}
