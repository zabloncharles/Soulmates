//
//  AboutMeView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 6/1/23.
//

import SwiftUI

struct AboutMeView: View {
    @State var erroralert = false
    @State var firstname = ""
    @State var lastname = ""
    @State var errormessage = "Something isn't quite right"
    @FocusState var isFirstnameFocused: Bool
    @FocusState var isLastnameFocused: Bool
    @State var onScreen : Int = 0
    @State var appears = false
    
    
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
                        //switching = 1
                    }
                }
                
                
                
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        GradientText(text: "Tell Us" , gradient: [Color("black"), .blue,Color("black"),.gray])
                            .font(.largeTitle.bold())
                        GradientText(text: "About Yourself ?" , gradient: [Color("black"), .blue,Color("black"),.gray])
                            .font(.largeTitle.bold())
                        GradientText(text: "What do you want people to know about you." , gradient: [Color("black")])
                            .font(.headline)
                        
                    }.padding(.leading, 15)
                        .padding(.vertical, 0)
                    
                    
                    
                    Spacer()
                    
                    
                    VStack(spacing: 15.0) {
                        
                        TextEditor(text: $firstname)
                            .frame(height: 200)
                            .scrollContentBackground(.hidden)
                            .keyboardType(.alphabet)
                            .disableAutocorrection(true)
                            .placeholder(when: firstname.isEmpty) {
                                VStack {
                                    Text("Here's a short insight into my life :)...")
                                        .foregroundColor(.gray)
                                        .blendMode(.lighten)
                                        .padding(5)
                                        .padding(.top,5)
                                    Spacer()
                                }.frame(height: 200)
                            }
                            .padding(.leading,10)
                            .focused($isFirstnameFocused)
                        // .background(Color.blue)
                            
                        
                            .onTapGesture{
                                erroralert = false
                                withAnimation(.easeInOut) {
                                    appears = true
                                }

                            }
                        
                        
                        
                        
                    }.padding()
                        .neoButtonOff(isToggle: false, cornerRadius: 20, perform: {
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

struct AboutMeView_Previews: PreviewProvider {
    static var previews: some View {
        AboutMeView()
    }
}
