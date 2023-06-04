//
//  LookingForView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 6/2/23.
//

import SwiftUI

struct LookingForView: View {
    @State var erroralert = false
    @State var firstname = ""
    @State var errormessage = "Something isn't quite right"
    @State var lottie = ""
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
                    .scaleEffect(appears ? 1.4 : 1 )
                    .offset(x: 0, y: -100)
                    .opacity(appears ? 1 : 0)
                    .transition(.scale.combined(with: .opacity ))
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                            withAnimation(.spring()) {
                                appears = false
                            }
                        }
                    }
            } else {
                LottieView(filename: "telescope" ,loop: true)
                    .frame(width: 340)
                    .offset(x: 0, y: -100)
                    .shadow(color: .black, radius: appears ? 0 : 0.2, x: 4, y: 5)
                    .opacity(appears ? 0 : 1)
                    .transition(.scale.combined(with: .opacity))
                //.opacity(isFirstnameFocused ? 0 : 0)
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
                        
                        GradientText(text: "Tell Us What" , gradient: [Color("black"), .blue,Color("black"),.gray])
                            .font(.largeTitle.bold())
                        GradientText(text: "You're Looking For" , gradient: [Color("black"), .blue,Color("black"),.gray])
                            .font(.largeTitle.bold())
                        Text(" What do you want.")
                            .font(.headline)
                        
                    }.padding(.leading, 15)
                        .padding(.vertical, 0)
                    
                    
          
                    
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            ScrollView {
                                VStack {
                                    
                                    
                                    ForEach(universityNames, id: \.self) { option in
                                        HStack {
                                            Text(option)
                                                .padding()
                                            
                                            
                                            Spacer()
                                            if searchQuery == option {
                                                Image(systemName: "checkmark")
                                                    .padding()
                                            }
                                        }   .neoButtonOff(isToggle: false, cornerRadius: 15) {
                                            //
                                            searchQuery = option
                                            appears = true
                                        }
                                        
                                    }
                                    
                                    
                                    .padding(.horizontal)
                                    .padding(.vertical,10)
                                }
                                Spacer()
                            }.neoButtonOff(isToggle: false, cornerRadius: 15) {
                                //
                                
                            }
                           //
                            
                            
                            
                        }.frame(width: .infinity,height: 300)
                            .offset(y: appeared ? 0 : 100)
                           // .transition(.asymmetric(
                              //  insertion: .move(edge: .bottom),
                             //   removal: .move(edge: .bottom)))
                    }
                    
                    
                }
            }
            
            .padding(20)
            .padding(.bottom, 30)
            .frame(maxWidth: .infinity)
            
            
        } .onAppear{
            withAnimation(.spring().delay(1)) {
                appeared = true
            }
            search()
        }
        
        .animation(.spring(), value: appeared)
        
    }
    func search() {
        // Placeholder implementation using static data
        // Replace this with your API request implementation
        let currentUni = ["Hiking"]
        let staticData = ["A Relationship","A Serious Relationship", "I Don't Know", "I Want To See Where Things Go", "Fun"]
        let noData = ["\(searchQuery)"]
        
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

struct LookingForView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            LookingForView()
        }
    }
}
