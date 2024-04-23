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
    @State var storedValues = ["Woman","Chicago"]
    @State var title = "title"
    @State var label = "label"
    @State var sublabel = "sublabel"
    @State var optionType = 500
    @State var trackChanges : Set<Int> = []
    @Binding var isSheetPresented: Bool
    
    // Add more @State properties for other user profile information
    
    var body: some View {
       
            ZStack {
                BackgroundView()
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
      
                        HStack {
                            Text("Match Preferences: \(returnedChange) + \(storedValues[0]) + \(optionType)")

                                .foregroundColor(.gray)
                            Spacer()
                        }.padding(.horizontal)
                            VStack {
                                
                                NavigationLink(destination: picklistview
                                    .onAppear{
                                        label = "Gender"
                                        sublabel = "Woman"
                                        list = ["Male", "Female"]
                                    }
                                    .onDisappear{
                                         storedValues[0] = returnedChange
                                    }
                                
                                ) {
                                    VStack {
                                        PreferenceInfoCard(label: "Interested in", sublabel: storedValues[0])
                                    }
                                }
                                
                                NavigationLink(destination:
                                                mapview
                                    .onAppear{
                                        label = "Hometown"
                                      
                                        
                                    }
                                    .onDisappear{
                                        storedValues[1] = returnedChange
                                    }
                                
                                
                                ) {
                                    VStack {
                                        PreferenceInfoCard(label: "My hometown", sublabel: storedValues[1])
                                    }
                                }
                                
                                NavigationLink(destination: picklistview) {
                                    VStack {
                                        PreferenceInfoCard(label: "Maximum distance", sublabel: "100 mi")
                                    }
                                }
                                
                                NavigationLink(destination: picklistview) {
                                    VStack {
                                        PreferenceInfoCard(label: "Age range", sublabel: "Women 18 - 30")
                                    }
                                }
                                
                                NavigationLink(destination: picklistview) {
                                    VStack {
                                        PreferenceInfoCard(label: "Ethnicity", sublabel: "Black/African")
                                    }
                                }
                                
                                NavigationLink(destination: picklistview) {
                                    VStack {
                                        PreferenceInfoCard(label: "Religion", sublabel: "Christian")
                                    }
                                }
                                // Add more form fields for other personal information
                            }.padding()
                            
                            
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
                            
                            NavigationLink(destination:picklistview) {
                                VStack {
                                    PreferenceInfoCard(label: "Height", sublabel: "Open")
                                }
                            }
                            
                            NavigationLink(destination: picklistview) {
                                VStack {
                                    PreferenceInfoCard(label: "Dating Intentions", sublabel: "Open")
                                }
                            }
                            
                            NavigationLink(destination: picklistview) {
                                VStack {
                                    PreferenceInfoCard(label: "Children", sublabel: "Open")
                                }
                            }
                            
                            NavigationLink(destination: picklistview) {
                                VStack {
                                    PreferenceInfoCard(label: "Family Plans", sublabel: "Open")
                                }
                            }
                            
                            NavigationLink(destination: picklistview) {
                                VStack {
                                    PreferenceInfoCard(label: "Drugs", sublabel: "Open")
                                }
                            }
                            
                            NavigationLink(destination: picklistview) {
                                VStack {
                                    PreferenceInfoCard(label: "Smoking", sublabel: "Open")
                                }
                            }
                            
                            NavigationLink(destination: picklistview) {
                                VStack {
                                    PreferenceInfoCard(label: "Marijuana", sublabel: "Open")
                                }
                            }
                            
                            NavigationLink(destination: picklistview) {
                                VStack {
                                    PreferenceInfoCard(label: "Drinking", sublabel: "Open")
                                }
                            }
                            
                            NavigationLink(destination: picklistview) {
                                VStack {
                                    PreferenceInfoCard(label: "Politics", sublabel: "Open")
                                }
                            }
                            
                            NavigationLink(destination: picklistview) {
                                VStack {
                                    PreferenceInfoCard(label: "Education Level", sublabel: "Open")
                                }
                            }

                           
                            // Add more form fields for other personal information
                        }.padding()
                        
                            .padding(.horizontal)
                        
                        
                
                        Spacer()
                    }
                    .padding(.top, 60)
                }
                
    //        
               
            }
            .onChange(of: optionType) { newValue in
               
               
                if !isPresented && !returnedChange.isEmpty {
                    trackChanges.insert(optionType)
                }
                // if we are editing the gender preference
               
        }
        }
    
    var picklistview : some View{
        PicklistSheetView(isPresented: $isPresented, returned: $returnedChange, title: "Preferences", label: label, sublabel: sublabel, list: list)
            .onAppear{
                // if the modal sheet is showing
              
            }
            .onDisappear{
                list = []
                label = ""
                //                    title = ""
                sublabel = ""
                if  optionType == 0 {
                    withAnimation(){
                        storedValues[0] = returnedChange
                    }
                    
                }
            }
    }
    var mapview: some View {
        MapSheetView(isPresented: $isPresented, returned: $returnedChange, title: "Preferences", label: label, sublabel: sublabel, list: list)
            .onAppear{
             
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
                .neoButtonOff(isToggle: true, cornerRadius: 13) {
                    //
                }
                .padding(.horizontal)
              
            Spacer()
            HStack(spacing: 2.0) {
                Image(systemName: returned.isEmpty ? "multiply" : "checkmark")
//                Text(returned.isEmpty ? "Cancel" : "Done")
            }
                .animation(.easeInOut, value: returned.isEmpty)
                .padding(.horizontal,30)
                .padding(.vertical,10)
                .foregroundColor(!returned.isEmpty ? .green : Color("black"))
                .neoButtonOff(isToggle: false, cornerRadius: 13) {
                    //
                    isPresented = false
            
            }
            
        }.navigationBarTitle(title, displayMode: .inline)
       
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
                                Text("Coordinates: \(middleCoordinate?.latitude ?? 0.00), \(middleCoordinate?.longitude ?? 0.00)")
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
                VStack(alignment: .center) {
                    
                    HStack {
                        Spacer()
                        
                        
                        VStack(alignment: .center, spacing: 3.0) {
                            Text(label)
                                .foregroundColor(Color("black"))
                            HStack {
                                Image(systemName: "location.north")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text(cityName.isEmpty ? returned : cityName)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                        }.multilineTextAlignment(.center)
                        
                        Spacer()
                        
                    }.padding(.horizontal)
                        .padding(.vertical,10)
                        .padding(.top,-30)
                    
                    
                    
                }
                .padding(.top,20)
                .background(Color("offwhiteneo"))
                
                
                
                
                
                
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
            
            
        }.navigationBarTitle(title, displayMode: .inline)
    }
}
