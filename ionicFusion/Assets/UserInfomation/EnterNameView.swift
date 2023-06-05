//
//  EnterNameView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 6/5/23.
//

import SwiftUI

struct EnterNameView: View {
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
                LottieView(filename: "confetti" ,loop: false)
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
                // .opacity(isFirstnameFocused ? 0 : 1)
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
                    
                    
                    VStack(spacing: 15.0) {
                        
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
                            .neoButtonOffShadow(cornerRadius: 18, isTapped: false)
                        
                            .onTapGesture{
                                erroralert = false
                                withAnimation(.easeInOut) {
                                    appears = true
                                }
                                
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
                            .neoButtonOffShadow(cornerRadius: 18, isTapped: false)
                            .onTapGesture{
                                erroralert = false
                            }
                        
                        
                        
                    }.padding()
                        .neoButtonOff(isToggle: false, cornerRadius: 25, perform: {
                            //
                        })
                }
            }
            
            .padding(20)
            .padding(.bottom, 30)
            .frame(maxWidth: .infinity)
            
            
        }
        
    }
    
    
    
    
}


