//
//  EnterAgeView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 6/5/23.
//

import SwiftUI

struct EnterAgeView: View {
    var title = "age"
    var message = "age"
    var gradientTitle : [Color] =  [.black, .purple]
    var gradientMessage : [Color] =  [.black , .purple, .red]
    @State var appears = false
    @State var firstName = ""
    @Binding var newAge : String
    @State var birthDate = Date()
    @Binding var onScreen : Int
    @Binding var switching : Int
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }
  
    
    
    
    var body: some View {
        
        ZStack{
            
            LottieView(filename: "birds" ,loop: true)
                .frame(width: 380)
                .offset(x: 0, y: -280)
            
            if appears {
                LottieView(filename: "confetti" ,loop: true)
                    .frame(width: 380)
                    .scaleEffect(appears ? 1.2 : 1 )
                    .offset(x: 0, y: -60)
                    .opacity(appears ? 1 : 0)
                    .transition(.scale.combined(with: .opacity ))
            } else {
                LottieView(filename: "girlonphone" ,loop: true)
                    .frame(width: 380)
                    .offset(x: 0, y: -50)
                    .shadow(color: .black, radius: appears ? 0 : 0.4, x: 4, y: 5)
                    .transition(.scale.combined(with: .opacity))
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
                    switching = 2
                }
                VStack(alignment: .leading, spacing: 0) {
                    
                    GradientText(text: "What is " , gradient: [Color("black"), .purple,.yellow])
                        .font(.largeTitle.bold())
                    GradientText(text: "your date of birth ?" , gradient: [Color("black"), .purple,.yellow])
                        .font(.largeTitle.bold())
                    GradientText(text: " Please enter the date of birth below." , gradient: [Color("black")])
                        .font(.headline)
                    
                }.padding(.leading, 15)
                    .padding(.vertical, 0)
                
                Spacer()
                
                VStack {
                    Text("\(birthDate, formatter: dateFormatter)")
                    // Text("\(newAge)")
                        .padding()
                        .foregroundColor(.gray)
                        .opacity(appears ? 0 : 1)
                        .scaleEffect(appears ? 0 : 1)
                        .offset(y: -50)
                    
                    
                    DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                        Text("")
                        
                    }
                    .datePickerStyle(WheelDatePickerStyle())
                    .onChange(of: birthDate) { newValue in
                        convertAge()
                    }
                }.frame(maxWidth: .infinity)
                
                    .padding(30)
            }
            .padding(20)
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            
            withAnimation(.spring().speed(0.04)) {
                appears = true
              
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                withAnimation(.easeInOut) {
                  //  appears = false
                }
            }
        }
        .onDisappear {
            appears = false
        }
        
        
    }
   
    func convertAge(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        
        let date = formatter.string(from: birthDate)
        let tes = "\(date)"
        
        let birthday = formatter.date(from: ("\(tes)"))
        let timeInterval = birthday?.timeIntervalSinceNow
        let age = abs(Int(timeInterval! / 31556926.0))
        
        
        newAge = "\(age)"
        
        
        
        
    }
}

