//
//  LikesPillView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 6/2/23.
//

import SwiftUI

struct LikesPillView: View {
    @State var erroralert = false
    @State var firstname = ""
    @State var errormessage = "Something isn't quite right"
    @FocusState var isFirstnameFocused: Bool
    @State var onScreen : Int = 0
    @State var appears = false
    @State var crv = false
    @State var pill = [""]
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
                LottieView(filename: "likethumb" ,loop: true)
                    .frame(width: 340)
                    .offset(x: 0, y: -100)
                    .shadow(color: .black, radius: appears ? 0 : 0.2, x: 4, y: 5)
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
                        
                        GradientText(text: "Tell Us" , gradient: [Color("black"), .blue,Color("black"),.gray])
                            .font(.largeTitle.bold())
                        GradientText(text: "Your Likes ?" , gradient: [Color("black"), .blue,Color("black"),.gray])
                            .font(.largeTitle.bold())
                        Text(" What do you like.")
                            .font(.headline)
                        
                    }.padding(.leading, 15)
                        .padding(.vertical, 0)
                    
                   
                    VStack {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                            ForEach(Array(pill.enumerated()), id: \.1.self) { (index, item) in
                                if !(item.count < 1) {
                                  LikesPill(placeholder: item, icon: "")
                                        .frame(width:100)
                                        .lineLimit(1)
                                        .onTapGesture {
                                            pill.remove(at: index)
                                        }
                                }
                                        
                            }
                        }
                    }.padding(.vertical)
                    
                    
                    Spacer()
                    
                    
                    VStack {
                        TextField("\"What do you like?\"", text: $searchQuery)
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
                                            if searchQuery == option {
                                                Image(systemName: "checkmark")
                                                    .padding()
                                            }
                                        }   .neoButtonOff(isToggle: false, cornerRadius: 15) {
                                            //
                                            searchQuery = option
                                            if !searchQuery.isEmpty {
                                                pill.append(searchQuery)
                                            }
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
        let currentUni = ["Hiking"]
        let staticData = ["Hiking","Singing", "Dancing", "Crochet"]
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

struct LikesPillView_Previews: PreviewProvider {
    static var previews: some View {
        LikesPillView()
    }
}
