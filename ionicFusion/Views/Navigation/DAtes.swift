//
//  DAtes.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 3/26/22.
//

import SwiftUI

struct DAtes: View {
    @State var display = "false"
    @State var date = Date()
    @State var calendarTapped = false
    @State var daysPassed = 0
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Text("\(date.formatted(date:.numeric , time: .omitted)) days ago")
               Text("\(compare(thisDate: (date.formatted(date:.numeric , time: .omitted))))")
                Text(display)
                DatePicker("hey", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding(10)
                    .newoffwhite(offwhiteisTapped: calendarTapped, cornerradius: 15)
                    .padding()
                    .animation(.spring(), value: calendarTapped)
                   
                    
            
            }.onChange(of: date, perform: { newValue in
                compute()
                calendarTapped = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    calendarTapped = false
                }
            })
            .onAppear {
                compute()
        }
        }
        
       
    }

    func compute() {
         daysPassed =  Int(compare(thisDate: "\(date.formatted(date:.numeric , time: .omitted))"))!
        
        
        if daysPassed < 5
        {
            display = "you just got off \(daysPassed)"
        }
    }
    
    func compare(thisDate: String) -> String{
     let result = calculateDaysBetweenTwoDates(start: Date(), end: stringtodate(whatsthedateinstring: thisDate))
        
        return String(result)
    }
  
    func stringtodate(whatsthedateinstring: String) -> Date {
        
        let isoDate = whatsthedateinstring
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MM/dd/yyyy"
        guard let date = dateFormatter.date(from:isoDate) else { return Date() }
        
        
        
        return date
    }
  
    private func calculateDaysBetweenTwoDates(start: Date, end: Date) -> Int {
        
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: .day, in: .month, for: start) else {
            return 0
        }
        guard let end = currentCalendar.ordinality(of: .day, in: .month, for: end) else {
            return 0
        }
        return end - start
    }
    
   
    
 
    
}

struct DAtes_Previews: PreviewProvider {
    static var previews: some View {
        DAtes()
    }
}
