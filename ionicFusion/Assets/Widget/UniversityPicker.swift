//
//  UniversityPicker.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/31/23.
//



import SwiftUI



struct UniversityView_Previews: PreviewProvider {
    static var previews: some View {
        UniversityView(done: .constant(0))
    }
}
import SwiftUI

struct UniversityView: View {
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
                    TextField("\"What school did/do you attend?\"", text: $searchQuery)
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
                
                Picker(selection: $selectedOption, label: Text("Select Option")) {
                    ForEach(universityNames, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 200)
                
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
        let currentUni = ["Saint Peter's University"]
        let staticData = ["University A", "University B", "University C"]
        let noData = ["Hmm! You sure that's right?"]
        
        let lowercaseQuery = searchQuery.lowercased() // Convert search query to lowercase
        
        if searchQuery.isEmpty {
            universityNames = currentUni
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


