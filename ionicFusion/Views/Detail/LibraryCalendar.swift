//
//  LibraryCalendar.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 3/16/22.
//



import SwiftUI

struct LibraryCalendar: View {
    @AppStorage("saveinfo") var saveinfo = ""
    @State var currentDate = Date()
    //@Binding var numberTapped: false
    @State var currentMonth: Int = 0
    @State var tappedDate = false
    @State var isToday = false
    @State var isFuture = false
    @State var showNotification = false
    @State var day = "Select the first day"
    @State var thisday = 0
    @State var test = ""
    @State var dayint = 0
    @State var selectedDate = ""
    @State var dateconvert = ""
    @State var animateappear = false
    
    
    
    var body: some View {
        
        
        
        ZStack {
          
            
            VStack {
              
                monthsection
                Divider()
                daysoftheweeksection
                calendsection
                Spacer()
            }
            
            
        } .onAppear{
            
            animateappear = true
            
            
        }
        .onDisappear{
            animateappear = false
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
            Spacer()
            Button {
                withAnimation(.easeInOut) {
                    currentMonth -= 1
                    currentDate = getCurrentMonth()
                    tappedDate = false
                    
                }
            } label: {
                Image (systemName:"chevron.left")
                    .font(.title2)
            }
            Button {
                withAnimation(.easeInOut) {
                    currentMonth += 1
                    currentDate = getCurrentMonth()
                    tappedDate = false
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
                    
                    //                    Text(day)
                    //                        .font(.callout)
                    //                        .fontWeight(.regular)
                    //                        .frame(maxWidth: .infinity)
                    
                    
                    dayweekView(day: day)
                    
                    
                    
                    
                    
                }
            }.padding(.horizontal, 5)
                .padding(.vertical, 10)
                .newoffwhite(offwhiteisTapped: false, cornerradius: 15)
                .padding()
        }
    }
   
    var calendsection : some View {
        
        VStack{
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 29) {
                
                ForEach(extractDate()){value in
                    
                  
                       
                           //|| (value.day > Int(offsetday(offset: -7 )) ?? 1 && value.day < Int(offsetday(offset: 1 )) ?? 1)
                                
                            
                  //if the day equals the last time period day and the month of the period
                    if value.day == Int(returnperiodday()) && extraDate()[1].uppercased() == returnperiodmonth().uppercased()  || value.day == Int(nextPeriod()[1]) && extraDate()[1].uppercased() == nextPeriod()[3].uppercased() {
                        // &&  extraDate()[1] == nextPeriod()[3].uppercased()
                            Image(systemName: "drop.fill")
                                .foregroundColor(.red)
                                .font(.callout)
                                .background(
                                    Image(systemName: "circle.dotted")
                                    .foregroundColor(.clear)
                                    .background(LinearGradient(colors: [Color.red, Color.green, Color.pink], startPoint: .leading, endPoint: .trailing))
                                    .mask(Image(systemName: "circle.dotted"))
                                    .font(.largeTitle)
                                    .font(.callout)
                                    .rotationEffect(Angle(degrees: animateappear ? 0 : 190))
                                    .animation(.spring().repeatForever(), value: animateappear)
                                    .newoffwhite(offwhiteisTapped: false, cornerradius: 0)
                                )
                                .background(
                                    Circle() // the pink circle behind the date
                                        .fill(Color("offwhite"))
                                        .padding(-17)
                                        .newoffwhite(offwhiteisTapped: false, cornerradius: 0)
                            )
                              
                               
                                
                               
                               
                           
                        
                        
                            
                    } else {
                        CardView(value: value)
                            .background(
                                Circle() // the pink circle behind the date
                                    .fill(value.day == -1 ? .clear : !tappedDate ? .clear : Color.red)
                                    .overlay(
                                        Circle()
                                            .fill(value.day == -1 ? .clear : !tappedDate ? .clear : .pink)
                                            .padding(2)
                                        
                                    )
                                    .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                                    .padding(-3)
                                )
                    }
                    
                    
                    
                    
                    
                }
                
            }
//            .onChange(of: currentMonth, perform: { V in
//               // test = "\(offsetday(offset: 28)) : \(returnperiodmonth())  : \(returnperiodday()) : \(extraDate()[1])"
//                test = "\(nextPeriod()[1]) \(nextPeriod()[3].uppercased())"
//            })
            
            .padding(20)
            .newoffwhite(offwhiteisTapped: false, cornerradius: 17)
            .padding(.horizontal)
    
        }
        
    }
    
    @ViewBuilder
    
    func CardView(value: DateValue)->some View{
        
        //The calender swift
        HStack{
            if value.day != -1 {
                
                
                Text("55")
                    .padding(0.20)
                    .opacity(0.002)
                    .background(GradientText(text: value.day == -1 ? "" : value.day < 10 ? "\(value.day)" : "\(value.day)", gradient: currentMonth > 0 ? [.white,.gray] : (dayint >= value.day || currentMonth < 0 ? [ Color("black"),Color.orange] : [ Color("black"),Color.gray])))
                
                
                // .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? Color("black") : Color("black"))
                
                    .background(
                        Circle()
                            .fill( currentMonth < 1 ? (dayint >= value.day || currentMonth < 0 ? value.day == dayint ? currentMonth > 0 || currentMonth < 0 ? Color("offWhite") : .blue : Color("offWhite") : .clear) : .clear)
                            .newoffwhite(offwhiteisTapped: false,  cornerradius: 80)
                            .padding(currentMonth < 1 ? (dayint >= value.day || currentMonth < 0 ? value.day == dayint ? currentMonth > 0 || currentMonth < 0 ? -11 : -11 : -12 : 12) : 11)
                            .animation(.easeInOut, value: value.day)
                          
                        
                        
                        
                        
                        
                    )
                    
            }
            else {
                
                GradientText(text: value.day == -1 ? "" : "\(value.day)", gradient: [.orange,.gray])
                
                // .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? Color("black") : Color("black"))
                
                    .background(
                        Circle()
                            .fill(value.day == value.day ? Color.offWhite : .clear)
                            .padding(-11)
                            .shadow(color:  Color("black").opacity(0.2), radius: 10, x:value.day == value.day ? -5 : 10, y:value.day == value.day ? -5 : 10 )
                            .shadow(color: Color("white").opacity(0.9),radius: 10, x:value.day == value.day ? 10 : -5, y:value.day == value.day ? 10 : -5)
                            .animation(.spring(), value: value.day)
                    )
                
                
                
                
            }
        }
        .frame(width: 67, height: 40)
      
        //.offwhitebutton(isTapped: tappedDate, isToggle: false, cornerRadius: 15)
        .onAppear{
            dayint = Int(turntoday()) ?? 6
           // saveinfo()[ = "\(nextPeriod()[0]) \(nextPeriod()[1]) \(nextPeriod()[2])"
        }
      
        .onTapGesture {
            
            day = "\(value.day) \(extraDate()[1]) \(extraDate()[0])"
            // dayint = value.day
            dateTapped()
            // day = convertDate()
            
            
            
        }
        
        
        
        
    }
    func data()->[String]{
        
        let data = saveinfo
        // 0:name , 1:lname , 2:notifications, 3:period, 4:medium, 5:cycledate, 6:age, 7:email
        return data.components(separatedBy: ",")
    }
    
    func stringtodate(whatsthedateinstring: String) -> Date {
        
        let isoDate = whatsthedateinstring
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MM/dd/yyyy"
        guard let date = dateFormatter.date(from:isoDate) else { return Date() }
        
        
        
        return date
    }
    func offsetday (offset: Int)->String{
        let calendar = Calendar . current
        let date = calendar.date(byAdding : .day, value: offset, to: stringtodate(whatsthedateinstring: data()[3]))
        return date!.formatted(.dateTime.day())
    }
    func periodDate()->Date{
        let currentDate = stringtodate(whatsthedateinstring: data()[3])
        var dateComponent = DateComponents()
        dateComponent.day = 28
        
        let futureDate = Calendar.current.date(byAdding: dateComponent,  to: currentDate) ?? Date()
      
        return futureDate
    }
    func nextPeriod()->[String]{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM d yyyy MMMM"
        
        let date = formatter.string(from: periodDate())
        
        return date.components(separatedBy: " ")
    }
    
    func dateTapped() {
        
        dateconvert = "\(returnDate().formatted(.dateTime.day()))"
        // thisday = Int(dayint)
        tappedDate = true
        currentDate = returnDate()
    }
    func returnday() -> String{
        
        return currentDate.formatted(.dateTime.day())
        
    }
    func returndayofweek() -> String{
        
        return currentDate.formatted(.dateTime.weekday(.wide))
        
    }
    func returnmonth() -> String{
        
        return currentDate.formatted(.dateTime.month(.wide))
        
    }
    func returnperiodmonth() -> String{
        
        let perioddate = stringtodate(whatsthedateinstring: (data()[3]))
                                      
                                      
        return perioddate.formatted(.dateTime.month(.wide))
        
    }
    func returnperiodday() -> String{
        
        let perioddate = stringtodate(whatsthedateinstring: (data()[3]))
        
        
        return perioddate.formatted(.dateTime.day())
        
    }
    func turntoday() -> String{
        let format = DateFormatter()
        format.dateFormat = "d"
        
        return format.string(from: Date())
    }
    //sample date for testing...
    func getSampleDate (offset: Int)->Date{
        let calendar = Calendar . current
        let date = calendar.date(byAdding : .day, value: offset, to: currentDate)
        return date ?? Date()
    }
    func returnDate() -> Date{
        
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "d MMMM yyyy"
        
        return convertDateFormatter.date(from: (convertDateFormat(inputDate: day))) ?? Date()
    }
    func convertDateFormat(inputDate: String) -> String {
        
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "d MMMM yyyy"
        
        let oldDate = olDateFormatter.date(from: inputDate)
        
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "d MMMM yyyy"
        
        return convertDateFormatter.string(from: oldDate!)
    }
    
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
    
    func convertDate() -> String {
        let format = DateFormatter()
        format.dateFormat = "d MMMM yyyy"
        
        return format.string(from: Date())
    }
    
    func isSameDay(date1: Date,date2: Date)->Bool{
        let calendar = Calendar.current
        
        
        return calendar.isDate(date1, inSameDayAs: date2)
        
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



struct LibraryCalendar_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
            .preferredColorScheme(.dark)
    }
}
