//
//  CalenderComponent.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 2/25/22.
//

import SwiftUI

struct CalenderComponent: View {
    @Binding var currentDate: Date
    //@Binding var numberTapped: false
    @State var currentMonth: Int = 0
    @State var tappedDate = false
    @State var isToday = false
    @State var isFuture = false
    
    
    var body: some View {
        
        
        
        calendsection
        
        
    }
    var calendsection : some View {
        
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
                        .onTapGesture(perform: {
                            tappedDate = true
                            
                            //vibrate a little
                            let impactMed = UIImpactFeedbackGenerator(style: .light)
                            impactMed.impactOccurred()
                            //wait 2 seconds and make user tapped to false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                tappedDate = false
                            }
                        })
                     
                }
                
            }
            .padding(20)
            // .frame(width: 400, height: 360)
            // .offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 30)
            .background(Color.offWhite)
            .cornerRadius(30)
            .offwhite(offwhitecolor: .black, offwhitecolorShadow: .white, offwhiteisTapped: false)
            .padding(.horizontal)
        }

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
                    
                    GradientText(text: "\(value.day)", gradient: [.black,.orange])
                    
                        .background(
                            Rectangle()
                                .fill(isSameDay(date1: task.taskDate, date2: currentDate) ? .green : .red)
                                .cornerRadius(30)
                                .padding(-19)
                            
                            
                        )
                    
                    
                    
                    
                }
                else {
                    
                    GradientText(text: "\(value.day)", gradient: [.black,.gray])
                    
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? Color("black") : Color("black"))
                    
                        .background(
                            Rectangle()
                                .fill(isSameDay(date1: value.date, date2: currentDate) ? .green : .clear)
                                .padding(-19)
                            
                        )
                    
                }
            }
            
            
        }
        .frame(width: 47, height: 40)
        .background(Color.offWhite)
        .cornerRadius(6)
        .offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 15)
        
        
    }
    func isSameDay(date1: Date,date2: Date)->Bool{
        let calendar = Calendar.current
        
        
        return calendar.isDate(date1, inSameDayAs: date2)
        
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

struct CalenderComponent_Previews: PreviewProvider {
    static var previews: some View {
       ViewController()
           
    }
}
