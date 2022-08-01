//
//  CustomDatePicker.swift
//  SwiftUI Custom Calender
//
//  Created by Zablon Charles on 11/25/21.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var currentDate: Date
    @State var tappedDate = false
    @State var isToday = false
    @State var isFuture = false
    // month update on array button clicks...
    @State var currentMonth: Int = 0
    @State var animate = false
    @State var eventTapped = false
    
    var body: some View {
        
        VStack(spacing: 35){
            
            //Days
            
            
            monthsection
            
            // Days of the week
            daysoftheweeksection
           
            //the calender
            calendersection
            
            eventsection
            
            eventresultsection
            
        }
        .onChange(of: currentMonth) { newValue in
            
            // updating month
            currentDate = getCurrentMonth()
        }
        
    }
    var monthsection: some View {
        HStack(spacing: 20){
            VStack(alignment: .leading, spacing: 1){
                //the year
                Text (extraDate()[0])
                    .font(.footnote)
                    .fontWeight(.semibold)
                // the month
                Text(extraDate()[1])
                 .font(.title.bold().smallCaps())
                
                
                
            }
            Spacer (minLength : 0)
            Button {
                withAnimation {
                    currentMonth -= 1
                }
            } label: {
                Image (systemName:"chevron.left")
                    .font(.title2)
            }
            Button {
                withAnimation {
                    currentMonth += 1
                }
            } label: {
                Image (systemName:"chevron.right")
                    .font(.title2)
            }
        }.padding(.horizontal, 20)
    }
    var daysoftheweeksection: some View {
        
        VStack {
            let days: [String] =
            ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri" , "Sat"]
            HStack(spacing: 0){
                ForEach(days,id: \.self){day in
                    
                    Text(day)
                        .font(.callout)
                        .fontWeight(.regular)
                        .frame(maxWidth: .infinity)
                    
                    
                    
                }
            }.padding(.horizontal, 5)
                .padding(.vertical, 13)
                .offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 15)
                .padding(.horizontal)
        }
    }
    var calendersection: some View {
        VStack{
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 28) {
                
                ForEach(extractDate()){value in
                    
                    CardView(value: value)
                        .background(
                            Circle() // the pink circle behind the date
                                .fill(Color.pink)
                              
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                            
                                .scaleEffect(0.7)
                            
                        )
                     
                        .onTapGesture {
                            currentDate = value.date
                            withAnimation(.spring()) {
                               
                                tappedDate = true
                                
                                //vibrate a little
                                let impactMed = UIImpactFeedbackGenerator(style: .light)
                                impactMed.impactOccurred()
                                //wait 2 seconds and make user tapped to false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    tappedDate = false
                                }
                            }
                        }
                }
                
            }
            .padding(20)
           // .frame(width: 400, height: 360)
           // .offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 30)
            .background(Color.offWhite)
            .cornerRadius(30)
            .offwhite(offwhitecolor: .black, offwhitecolorShadow: .white, offwhiteisTapped: false)
            .padding(.horizontal)
        }.onAppear{
            withAnimation(.spring()) {
                animate = true
            }
        }
        .onDisappear{
            withAnimation(.spring()) {
                animate = false
            }
        }
      
    }
    var eventsection: some View {
        HStack {
            Text("Recommended".uppercased())
            Spacer()
            Image(systemName: "sparkles")
        } .sectionTitleModifier()
        
            .padding(.leading, 1)
            .offset(y: 19)
    }
    var eventresultsection: some View {
        VStack(spacing: 20){
            
            if let task = tasks.first(where:  { task in return isSameDay(date1: task.taskDate, date2: currentDate)
                
            }) {
                
                ForEach(task.task){task in
                    
                    EventComponent(eventTapped: false, title: task.title, description: task.description, isToday: false)
                        .simultaneousGesture(
                            TapGesture().onEnded { _ in
                                withAnimation(.spring()) {
                                    //  trendingTapped = true
                                    eventTapped.toggle()
                                    
                                }
                            })
                      
                }
            }
            else{
                VStack {
                    Image(systemName: "bell.slash")
                    Text("No Alerts Found")
                }.padding()
                .offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 15)
              
            }
            
        }.padding()
            .padding(.bottom, -30)
    }
    @ViewBuilder
    
    func CardView(value: DateValue)->some View{
        
        //The calender swift
        HStack{
            if value.day != -1{
                
                
                if let task = tasks.first(where: {
                    
                    
                    task in
                    
                    return isSameDay(date1: task.taskDate, date2: value.date)
                    
                }){
                    withAnimation(.easeInOut) {
                        GradientText(text: "\(value.day)", gradient: [.white,.orange])
                            .background(
                                Rectangle()
                                    .fill(isSameDay(date1: task.taskDate, date2: currentDate) ? .blue : .pink)
                                    .cornerRadius(30)
                                
                                    .background(Color.offWhite)
                                    .cornerRadius(30)
                                    .padding(-7)
                                    .shadow(color: Color("black").opacity(0.2), radius: 10, x: 10, y: 10 )
                                    .shadow(color: Color("white").opacity(0.9),radius: 10, x: -5, y: -5)
                                
                                
                            )
                    }
                   
                }
                else {
                    
                    GradientText(text: "\(value.day)", gradient: [.black,.gray])
                     //   .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? Color("black") : Color("black"))
                        //.background(
                         //   Rectangle()
                         //       .fill(isSameDay(date1: value.date, date2: currentDate) ? .green : .blue)
                           //     .padding(-19)
                            
                       // )
                        .frame(width: 38, height: 38)
                        .background(Color.offWhite)
                    
                        .cornerRadius(30)
                       
                        .shadow(color: Color("black").opacity(0.2), radius: 10, x: 10, y: 10 )
                        .shadow(color: Color("white").opacity(0.9),radius: 10, x: -5, y: -5)
                   
                }
            }
            
            
        }
        .frame(width: 40, height: 40)
        .background(Color.offWhite)
        .cornerRadius(80)
       // .shadow(color: Color("black").opacity(0.2), radius: 10, x: 10, y: 10 )
       // .shadow(color: Color("white").opacity(0.9),radius: 10, x: -5, y: -5)
       
        
    }
    // checking dates...
    func isSameDay(date1: Date,date2: Date)->Bool{
        let calendar = Calendar.current
        
        
        return calendar.isDate(date1, inSameDayAs: date2)
        
    }
    //extracting year and month for display
    func extraDate()->[String]{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth()->Date {
        
        let calendar = Calendar.current
        
        // getting current Month Date....
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else{
            return Date()
        }
        return currentMonth
        
    }
    
    
    func extractDate()->[DateValue]{
        
        let calendar = Calendar.current
        
        // getting current Month Date....
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getALLDates().compactMap {date -> DateValue in
            
            //getting day...
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
            
        }
        
        // add offset days to get exact week day...
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
           
        
    }
}


// Extending Date tpo get current month dates..
extension Date{
    
    func getALLDates()->[Date]{
        
        let calendar = Calendar.current
        
        // getting start Date
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for:
                                    startDate)!
        
        
        //getting data
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
    
}
