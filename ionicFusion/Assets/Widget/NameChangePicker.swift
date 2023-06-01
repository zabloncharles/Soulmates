//
//  NameChangePicker.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/31/23.
//

import SwiftUI

struct NameChangePicker: View {
    @Binding var done : Int
        @State  var searchQuery = ""
        @State var selectedOption = ""
        @State  var universityNames: [String] = []
        @State var appeared = false
        @State var userError = false
        @State var userErrorMessage = ""
        
        var body: some View {
            VStack {
                Spacer()
                
                VStack {
                    VStack {
                        TextField(userError ? userErrorMessage : "\"What is your name?\"", text: $searchQuery)
                            .padding(.vertical)
                            .padding(.leading, 55)
                            .foregroundColor(userError ? Color.gray : Color.black)
                            .background(Color("offwhite"))
                            .neoButtonOffShadow(cornerRadius: 25, isTapped: false)
                        
                            .overlay(  HStack {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .padding(.leading, 10)
                                Spacer()
                            }
                            )
                    }.padding()
                    
                    // Picker(selection: $selectedOption, label: Text("Select Option")) {
                    VStack {
                        HStack {
                            VStack {
                                Spacer()
                                ForEach(universityNames, id: \.self) { option in
                                    HStack {
                                        Text(option)
                                            .padding()
                                        
                                        Spacer()
                                    }   .neoButtonOff(isToggle: false, cornerRadius: 15) {
                                    }
                                    
                                }
                                
                                
                                .padding(.horizontal)
                                .padding(.vertical,10)
                                Spacer()
                            }.neoButtonOff(isToggle: false, cornerRadius: 15) {
                                //
                            }
                            
                            
                        }.frame(width: .infinity,height: 200)
                        
                            .padding(10)
                    }
                    
                    Text("Done")
                        .padding()
                        .padding(.horizontal, 10)
                        .background(Color("offwhite"))
                        .neoButtonOff(isToggle: false, cornerRadius: 15) {
                            withAnimation(.spring()) {
                                done = 0
                                complete()
                            }
                        }
                    
                        .padding()
                        .padding(.bottom, 50)
                }.background(Color("offwhite").cornerRadius(25).padding(1))
                    .background(Color.gray.opacity(0.5).padding(.bottom,30))
                    .cornerRadius(25)
                    .animation(.spring(), value: searchQuery)
                    .offset(y: appeared ? 0 : 440)
                    .opacity(appeared ? 1 : 0)
                
            }.edgesIgnoringSafeArea(.all)
                .onAppear{
                    appeared = true
                    searchUniversities()
                }
                .onChange(of: searchQuery) { newValue in
                    
                    searchUniversities()
                    
                }
                .animation(.spring(), value: appeared)
        }
        
        func complete(){
            if searchQuery.isEmpty {
                userError = true
                typeWriter("You forgot your name!") {
                    //
                }
            } else {
                userError = true
                typeWriter("You forgot your name!") {
                    //
                }
            }
        }
        func searchUniversities() {
            // Placeholder implementation using static data
            // Replace this with your API request implementation
            let name = searchQuery.components(separatedBy: " ")
            
            if name.count > 1 {
                let staticData = ["Firstname: \(name[0].capitalized)", "Last Name: \(name[1].capitalized)"]
                universityNames = staticData
            } else {
                let staticData = ["Firstname: \(name[0].capitalized)", "Last Name: "]
                universityNames = staticData
                
            }
            
            
            
            
            
            
        }
        func typeWriter(_ text: String, completion: @escaping () -> Void) {
            
            
            // userErrorMessage = text
            var currentIndex = 0
            
            Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
                if currentIndex < text.count {
                    let index = text.index(text.startIndex, offsetBy: currentIndex)
                    let character = text[index]
                    
                    DispatchQueue.main.async {
                        withAnimation(.easeIn) {
                            userErrorMessage += String(character)
                        } // Update the typedText property on the main queue
                    }
                    
                    currentIndex += 1
                } else {
                    
                    timer.invalidate()
                    completion()
                    
                    Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
                        withAnimation(.easeInOut) {
                            userErrorMessage = ""
                            userError = false
                            
                        }
                    }
                    
                }
            }
        }
        
    }

struct NameChangePicker_Previews: PreviewProvider {
    static var previews: some View {
        NameChangePicker(done: .constant(0))
    }
}
