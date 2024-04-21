//
//  SettingsView.swift
//  Soul25
//
//  Created by Zablon Charles on 4/20/24.
//

import SwiftUI
import MapKit

struct SettingsView: View {
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
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
      
                        HStack {
                            Text("Match Preferences: \(returnedChange)")

                                .foregroundColor(.gray)
                            Spacer()
                        }.padding(.horizontal)
                            VStack {
                                
                                PreferenceInfoCard(label: "Interested in", sublabel: "Women", option: 0, tapped: $isPresented, optionType: $optionType)
                                
                                PreferenceInfoCard(label: "My hometown", sublabel: "Chicago", option: 1, tapped: $isPresented, optionType: $optionType)
                                PreferenceInfoCard(label: "Maximum distance", sublabel: "100 mi", option: 2, tapped: $isPresented, optionType: $optionType)
                                PreferenceInfoCard(label: "Age range", sublabel: "Women 18 - 30", option: 3, tapped: $isPresented, optionType: $optionType)
                                PreferenceInfoCard(label: "Ethnicity", sublabel: "Black/African", tapped: $isPresented, optionType: $optionType)
                                PreferenceInfoCard(label: "Religion", sublabel: "Christian", option: 4, tapped: $isPresented, optionType: $optionType)
                                // Add more form fields for other personal information
                            }.padding()
                            
                            .neoButtonOff(isToggle: false, cornerRadius: 19, perform: {
                                //
                            })
                            .padding(.horizontal)
                         
                            
                           
                           
                            // Add more sections for additional profile information
                        HStack {
        //
                            Text("Subscribed Member Preferences:")
                                .foregroundColor(.gray)
                            Spacer()
                        }.padding(.top,10)
                            .padding(.horizontal)
                        VStack {
                            
                            PreferenceInfoCard(label: "Height", sublabel: "Open", option: 5, tapped: $isPresented, optionType: $optionType)
                            
                            PreferenceInfoCard(label: "Dating Intentions", sublabel: "Open", option: 6, tapped: $isPresented, optionType: $optionType)
                            PreferenceInfoCard(label: "Children", sublabel: "Open", option: 7, tapped: $isPresented, optionType: $optionType)
                            PreferenceInfoCard(label: "Family Plans", sublabel: "Open", option: 8, tapped: $isPresented, optionType: $optionType)
                            PreferenceInfoCard(label: "Drugs", sublabel: "Open", tapped: $isPresented, optionType: $optionType)
                            PreferenceInfoCard(label: "Smoking", sublabel: "Open", option: 9, tapped: $isPresented, optionType: $optionType)
                            PreferenceInfoCard(label: "Marijuana", sublabel: "Open", option: 10, tapped: $isPresented, optionType: $optionType)
                            PreferenceInfoCard(label: "Drinking", sublabel: "Open", option: 11, tapped: $isPresented, optionType: $optionType)
                            PreferenceInfoCard(label: "Politics", sublabel: "Open", option: 12, tapped: $isPresented, optionType: $optionType)
                            PreferenceInfoCard(label: "Education Level", sublabel: "Open",option: 13, tapped: $isPresented, optionType: $optionType)
                           
                            // Add more form fields for other personal information
                        }.padding()
                        
                            .neoButtonOff(isToggle: false, cornerRadius: 19, perform: {
                                //
                            })
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
                }
                
    //        
               
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


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView( isSheetPresented: .constant(false))
    }
}



struct PicklistSheetView: View {
    @Binding var isPresented: Bool
    @Binding var returned : String
    var title : String
    var label : String
    var sublabel : String
    var list : [String]
    var lottie = "telescope"
    
    var body: some View {
        VStack {
            Text(title)
                .padding()
                .bold()
            
            LottieView(filename: lottie ,loop: false)
                .frame(height: 200)
                .padding(.top, 30)
                .padding(.bottom,10)
            
            Text("Tailor Your Preferences")
                .font(.headline)
                .padding(.bottom,5)
            Text("Your choices will help us refine your matches and make your experience more tailored to your preferences.")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal,25)
                .padding(.bottom,5)
           
            
            HStack {
                VStack(alignment: .leading, spacing: 3.0) {
                    Text(label)
                        .foregroundColor(Color("black"))
                    Text(returned.isEmpty ? sublabel :  returned)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                Picker("Picker", selection: $returned) {
                    ForEach(list, id: \.self) { item in
                        Text(item).tag(item)
                    }
                   
                    // Add more gender options as needed
                }
            }.padding(.horizontal)
                .padding(.vertical,10)
                .neoButtonOff(isToggle: false, cornerRadius: 13) {
                    //
                }
                .padding(.horizontal)
              
            Spacer()
            HStack {
                Image(systemName: returned.isEmpty ? "multiply" : "checkmark")
                Text(returned.isEmpty ? "Cancel" : "Done")
            }
                .animation(.easeInOut, value: returned.isEmpty)
                .padding(.horizontal,30)
                .padding(.vertical,10)
                .foregroundColor(Color("black"))
                .neoButtonOff(isToggle: false, cornerRadius: 13) {
                    //
                    isPresented = false
            
            }
            
        }
       
        .background(Color("offwhiteneo"))
        .gesture(
            DragGesture()
                .onChanged { value in
                    if value.translation.height > 150 {
                        isPresented = false
                    }
                }
        )
    }
}

struct MapSheetView: View {
    @Binding var isPresented: Bool
    @Binding var returned : String
    var title : String
    var label : String
    var sublabel : String
    var list : [String]
    var lottie = "telescope"
    @State var cityName = ""
    @State private var middleCoordinate: CLLocationCoordinate2D?
    @State private var coordinates = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194) // San Francisco coordinates
    
                                                                                      // San Francisco coordinates

    
    var body: some View {
        ZStack {
            //our map
            MapView(middleCoordinate: $middleCoordinate, coordinates: $coordinates, cityName: $returned)
                .overlay(
                    ZStack{
                        RippleCircle()
                            .frame(width:140)
                        Circle()
                            .fill(.red.opacity(0.60))
                            .frame(width: 20)
                        VStack {
                            Spacer()
                            HStack {
                                Text("Coordinates: \(middleCoordinate?.latitude ?? 0.45), \(middleCoordinate?.longitude ?? 0.50)")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                    .rotationEffect(.degrees(90))
                                    .offset(x: -110, y:-110)
                                Spacer()
                            }.padding()
                                .padding(.bottom,70)
                        }
                    }
                    
                    
                        
                
                )
                .edgesIgnoringSafeArea(.all)
                
            VStack {
                VStack {
                    Text(title)
                        .padding()
                    .bold()
                    HStack {
                        Image(systemName: "location.north")
                        
                        VStack(alignment: .leading, spacing: 3.0) {
                            Text(label)
                                .foregroundColor(Color("black"))
                            Text(cityName.isEmpty ? returned : cityName)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                        }
                        .overlay(
                            Divider()
                                .offset(x:-46)
                        )
                        Spacer()
                        
                    }.padding(.horizontal)
                        .padding(.vertical,10)
                        .padding(.top,-30)
                       
                      
                    
                } .background(Color("offwhiteneo"))
                
    //            LottieView(filename: lottie ,loop: false)
    //                .frame(height: 200)
    //                .padding(.top, 30)
    //                .padding(.bottom,10)
    //
    //            Text("Tailor Your Preferences")
    //                .font(.headline)
    //                .padding(.bottom,5)
    //            Text("Your choices will help us refine your matches and make your experience more tailored to your preferences.")
    //                .foregroundColor(.secondary)
    //                .multilineTextAlignment(.center)
    //                .padding(.horizontal,25)
    //                .padding(.bottom,5)
                
                
                
                
                
                Spacer()
               
                 
                    HStack {
                       
                        Text(returned.isEmpty ? "Cancel" : "Done")
                    }
                    .animation(.easeInOut, value: returned.isEmpty)
                    .padding(.horizontal,30)
                    .padding(.vertical,10)
                    
                    .foregroundColor(Color("black"))
                    .neoButtonOff(isToggle: false, cornerRadius: 19) {
                        //
                        isPresented = false
                        
                }
              
                
            }
            
           
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.height > 150 {
                            isPresented = false
                        }
                    }
        )
            
            
        }
    }
}
