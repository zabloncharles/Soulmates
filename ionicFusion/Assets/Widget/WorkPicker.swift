//
//  TestView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/31/23.
//

import SwiftUI



struct WorkPickerView_Previews: PreviewProvider {
    static var previews: some View {
        WorkPicker(done: .constant(0))
    }
}
import SwiftUI

struct WorkPicker: View {
    @Binding var done : Int
    
    @State  var searchQuery = ""
    @State var selectedOption = ""
    @State  var universityNames: [String] = []
    @State var appeared = false
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                VStack {
                    TextField("\"Where do you work?\"", text: $searchQuery)
                        .padding(.vertical)
                        .padding(.leading, 55)
                        .foregroundColor(Color.black)
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
                        ScrollView {
                        VStack {
                            
                            
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
                            }
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
    
    func searchUniversities() {
        // Placeholder implementation using static data
        // Replace this with your API request implementation
        let currentUni = ["Tech"]
        let staticData = ["Healthcare", "Construction", "Marketing"]
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


