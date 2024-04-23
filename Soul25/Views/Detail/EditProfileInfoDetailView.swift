//
//  EditProfileInfoDetailView.swift
//  Soul25
//
//  Created by Zablon Charles on 4/20/24.
//

import SwiftUI
import MapKit

struct EditProfileInfoDetailView: View {
    @State var userScrolledAmount : CGFloat = 0
    @State  var firstName: String = ""
    @State  var lastName: String = ""
    @State  var age: String = ""
    @State  var gender: String = ""
    @State  var occupation: String = ""
    @State var returnedChange = ""
    @State var isPresented = false
    @State var list : [String] = []
    @State var title = "title"
    @State var label = "label"
    @State var sublabel = "sublabel"
    @State var optionType = 0
    @State var trackChanges : Set<Int> = []
    @Binding var isSheetPresented: Bool
    
    // Add more @State properties for other user profile information
    
    var body: some View {
        ZStack {
            BackgroundView()
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    Text("Match Preferences: \(returnedChange)")
                    
                        .foregroundColor(.gray)
                    Spacer()
                }.padding(.horizontal)
                VStack {
                    
                    PreferenceInfoCard(label: "Interested in", sublabel: "Women")
                    
                    PreferenceInfoCard(label: "My hometown", sublabel: "Chicago")
                    PreferenceInfoCard(label: "Maximum distance", sublabel: "100 mi")
                    PreferenceInfoCard(label: "Age range", sublabel: "Women 18 - 30")
                    PreferenceInfoCard(label: "Ethnicity", sublabel: "Black/African")
                    PreferenceInfoCard(label: "Religion", sublabel: "Christian")
                    // Add more form fields for other personal information
                }.padding()
                
                    .neoButtonOff(isToggle: false, cornerRadius: 19, perform: {
                        //
                    })
                    .padding(.horizontal)
                
                
                
                
                // Add more sections for additional profile information
                HStack {
                    //                    Text("Subscribed Member Preferences: \(Array(trackChanges).map { "\($0)" }.joined(separator: ", "))")
                    Text("Subscribed Member Preferences:")
                        .foregroundColor(.gray)
                    Spacer()
                }.padding(.top,10)
                    .padding(.horizontal)
            
                
                
                Section {
                    Text("Save Changes")
                        .padding(.horizontal,10)
                        .padding(.vertical,10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .neoButton(isToggle: false, perform: {
                            // Add code to save changes to the user's profile
                            trackChanges.removeAll()
                        })
                }.padding(.top,20)
                
                Spacer()
            }
            .padding(.top, 60)
          
        }.sheet(isPresented: $isPresented) {
            
            //optiontype helps us know where we are making the change
            
            if optionType != 1 {
                PicklistSheetView(isPresented: $isPresented, returned: $returnedChange, title: "Preferences", label: label, sublabel: sublabel, list: list)
                    .onAppear{
                        // if the modal sheet is showing
                        if isPresented {
                            
                            // if we are editing the gender preference
                            if  optionType == 0 {
                                
                                label = "Gender"
                                sublabel = "Woman"
                                list = ["Male", "Female"]
                            }
                            // if we are editing hometown
                            
                        }
                    }
                    .onDisappear{
                        list = []
                        label = ""
                        //                    title = ""
                        sublabel = ""
                    }
            } else {
                MapSheetView(isPresented: $isPresented, returned: $returnedChange, title: "Preferences", label: label, sublabel: sublabel, list: list)
                    .onAppear{
                        if isPresented {
                            if  optionType == 1 {
                                label = "Hometown"
                                sublabel = "Chicago"
                                list = ["Maryland", "Chestnut"]
                            }
                        }
                    }
            }
            
        }
        .onChange(of: isPresented) { newValue in
            
            
            if !isPresented && !returnedChange.isEmpty {
                trackChanges.insert(optionType)
            }
        }
    }
}


struct EditProfileInfoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileInfoDetailView( isSheetPresented: .constant(false))
    }
}

