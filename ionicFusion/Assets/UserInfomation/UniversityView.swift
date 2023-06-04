//
//  UniversityView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 6/2/23.
//

import SwiftUI

struct UniversityFullView: View {
    @State var erroralert = false
    @State var firstname = ""
    @State var lastname = ""
    @State var errormessage = "Something isn't quite right"
    @FocusState var isFirstnameFocused: Bool
    @State var onScreen : Int = 0
    @State var appears = false
    
    @State  var searchQuery = ""
    @State var selectedOption = ""
    @State  var universityNames: [String] = []
    @State var appeared = false
    
    
    var body: some View{
        ZStack{
            
            LottieView(filename: "birds" ,loop: true)
                .frame(width: 380)
                .offset(x: 0, y: -280)
            
            Color.clear
                .onTapGesture{
                    isFirstnameFocused = false
                    erroralert = false
                    withAnimation(.easeInOut) {
                        appears = true
                    }
                    
                }
            
            if appears {
                LottieView(filename: "confetti" ,loop: false)
                    .frame(width: 380)
                    .scaleEffect(appears ? 1.2 : 1 )
                    .offset(x: 0, y: -60)
                    .opacity(appears ? 1 : 0)
                    .transition(.scale.combined(with: .opacity ))
            } else {
                LottieView(filename: "study" ,loop: true)
                    .frame(width: 340)
                    .offset(x: 0, y: -100)
                    .shadow(color: .black, radius: appears ? 0 : 0.2, x: 4, y: 5)
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
                        GradientText(text: "Where You Studied ?" , gradient: [Color("black"), .blue,Color("black"),.gray])
                            .font(.largeTitle.bold())
                        GradientText(text: "What studies do you focus in." , gradient: [Color("black")])
                            .font(.headline)
                        
                    }.padding(.leading, 15)
                        .padding(.vertical, 0)
                    
                    
                    
                    Spacer()
                    
                    
                    VStack {
                        TextField("\"Where did you study?\"", text: $searchQuery)
                            .padding(.vertical)
                            .padding(.leading, 55)
                            .foregroundColor(Color("black"))
                            .background(Color("offwhite"))
                            .neoButtonOffShadow(cornerRadius: 25, isTapped: false)
                            .focused($isFirstnameFocused)
                            .overlay(  HStack {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .padding(.leading, 10)
                                Spacer()
                            }
                            )
                            .onChange(of: searchQuery) { newValue in
                                
                                search()
                                
                            }
                            .onTapGesture{
                                erroralert = false
                                withAnimation(.easeInOut) {
                                    appears = true
                                }
                                
                            }
                    }.padding()
                    
                    
                    VStack {
                        HStack {
                            ScrollView {
                                VStack {
                                    
                                    
                                    ForEach(universityNames, id: \.self) { option in
                                        HStack {
                                            Text(option)
                                                .padding()
                                            
                                            Spacer()
                                            if searchQuery == option || universityNames.count == 1 {
                                                Image(systemName: "checkmark")
                                                    .padding()
                                            }
                                        }   .neoButtonOff(isToggle: false, cornerRadius: 15) {
                                            //
                                            searchQuery = option
                                        }
                                        
                                    }
                                    
                                    
                                    .padding(.horizontal)
                                    .padding(.vertical,10)
                                }
                                Spacer()
                            }.neoButtonOff(isToggle: false, cornerRadius: 15) {
                                //
                                
                            }
                            
                            
                        }.frame(width: .infinity,height: 200)
                        
                            .padding(0)
                    }
                    
                    
                }
            }
            
            .padding(20)
            .padding(.bottom, 30)
            .frame(maxWidth: .infinity)
            
            
        } .onAppear{
            appeared = true
            search()
        }
        
        .animation(.spring(), value: appeared)
        
    }
    func search() {
        // Placeholder implementation using static data
        // Replace this with your API request implementation
        let currentUni = ["Saint Peter's University"]
        let staticData = ["Saint Peter's University","Healthcare", "Construction", "Marketing"]
        let noData = ["Hmm! You sure that's right?"]
        
        let lowercaseQuery = searchQuery.lowercased() // Convert search query to lowercase
        
        if searchQuery.isEmpty {
            universityNames = staticData
        } else {
            universityNames = staticData.filter { name in
                let lowercaseName = name.lowercased() // Convert university name to lowercase
                let result = lowercaseName.contains(lowercaseQuery)
                return result
            }
            
            
        }
        if universityNames.isEmpty {
            universityNames = noData
        }
    }
    
    
    
}

struct UniversityFullView_Previews: PreviewProvider {
    static var previews: some View {
        UniversityFullView()
    }
}
