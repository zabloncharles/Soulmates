//
//  SetView.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 3/8/22.
//

import SwiftUI
import Firebase

struct SetView: View {
    @AppStorage("firstday") var firstday = false
    @AppStorage("saveinfo") var saveinfo = ""
    @State var currentDate = Date()
    @Environment(\.presentationMode) var presentationMode
    //@Binding var numberTapped: false
    @State var currentMonth: Int = 0
    @State var tappedDate = false
    @State var tappedComplete = false
    @State var isToday = false
    @State var isFuture = false
    @State var tapcard = false
    @State var areyousureTapped = 0
    @State var showareyouSure = false
    @State var day = "Select the first day of your last period"
    @State var thisday = 0
    @State var dayint = 0
    @State var selectedDate = ""
    @State var dateconvert = ""
    @State var uploadProgress = 0
    
    
    
    var body: some View {
        
        
        
        ZStack {
           BackgroundView()
               
            
           
                
           
           
            VStack {
                if !firstday {
                Button(action:  dismiss) {
                    HStack(spacing: 1.0){
                        Image(systemName: "chevron.backward")
                        Text("Back")
                        Spacer()
                    }.padding(.horizontal)
                      
                }
            }
              
                gradients
                monthsection
                Divider()
                daysoftheweeksection
                ZStack {
                    if !showareyouSure {
                    calendsection
                        .offset(x: showareyouSure ? UIScreen.main.bounds.height * -1.50 : 0 )
                        .opacity(showareyouSure ? 0 : 1)
                    }
                    areyousure
                        .offset(x: showareyouSure ? 0 : UIScreen.main.bounds.height * 1.50)
                        .opacity(showareyouSure ? 1 : 0)
                }
                Divider()
                    .offset(y:20)
                notification
            }
        
          
        }
       
           
        
      
        
        
    }
    var areyousure: some View {
        ZStack {
          
            
            VStack{
                HStack{
                    
                    VStack {
                        Text("Notification")
                            .padding(.bottom)
                        Text(firstday ? "Are you sure this was the first day of your last period? " : "Are you sure you want to change your cycle date?")
                            .multilineTextAlignment(.center)
                    }
                }.frame(width: 300, height: 250)
                    .padding()
                    .newoffwhite(offwhiteisTapped: false, cornerradius: 15)
                
                HStack {
                    Text("Confirm")
                        .frame(width: 80, height: 9)
                        .padding()
                        .newoffwhite(offwhiteisTapped:  areyousureTapped == 1, cornerradius: 8)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                areyousureTapped = 1
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                   
                                tappedCompleteFunc()
                                    firstday = false
                                }
                            }
                        }
                  
                        Text("Cancel")
                            .frame(width: 80, height: 9)
                            .padding()
                            .newoffwhite(offwhiteisTapped: areyousureTapped == 2, cornerradius: 8)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    showareyouSure = false
                                }
                                
                            }
                
                }.padding(.top)
                  
                    .onDisappear{
                        areyousureTapped = 0
                        withAnimation(.easeInOut) {
                        showareyouSure = false
                        }
                    }
                
            }
        }.onDisappear{
            presentationMode.wrappedValue.dismiss()
            
        }
    }
    var gradients: some View{
        HStack{
            Text(firstday ? "Select the first day of your last period to get started." : "Select the first day of your last period.")
            
        Spacer()
        }.font(.title.bold())
            .padding(.horizontal)
            .padding(.bottom)
            .padding(.vertical)
         
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
    var notification : some View {
        VStack(spacing:30){
            Spacer()
          
                HStack {
                  // Text("You have selected \"\(returnmonth())/\(returnday())/\(returnyear())\" as your first day of your last period")
    //                    .font(.subheadline)
                   
                        Image(systemName: "drop.circle")
                        .font(.title2)
                            .foregroundColor(tappedDate ? .pink : .gray)
                            .padding()
                           // .newoffwhite(offwhiteisTapped: false, cornerradius: 30)
                    
                    HStack {
                        Text("You have selected \"\("\( returnmonthwide()) \( returnday()) on a \(returndayofweek())\"")")
                            .font(.subheadline)
                            .transition(.scale.combined(with: .opacity ))
                        Spacer()
                    }.padding(.leading, 1)
                       
                            
                    Spacer()
                }.padding(.horizontal, 8)
                .padding(.vertical, 2)
                .newoffwhite(offwhiteisTapped: false, cornerradius: 16)
                .padding(.horizontal, 8)
                
            HStack{
                if uploadProgress == 3 {
                    LottieView(filename: "setComplete",loop: false)
                        .frame(width: 30, height: 30)
                } else if uploadProgress == 2 {
                    ProgressView()
                        .frame(width: 30, height: 30)
                }
                Text(uploadProgress == 4 ? "Complete" : tappedDate ? "Confirm" : "Cancel")
                    .font(.headline)
            }
            .transition(.scale.combined(with: .opacity ))
            .frame(width: 130, height: 48)
            .newoffwhite(offwhiteisTapped: tappedComplete, cornerradius: 15)
            .padding(.bottom, 10)
            .opacity(showareyouSure ? 0 : 1)
            .onTapGesture {
                
                tappedCompleteFunc()
            }
                
                
         
            
        }
            .padding(.horizontal,11)
        //.offset(y: tappedDate ? 0 : 250)
            .animation(.spring(), value: tappedDate)
    }
    var calendsection : some View {
        
        VStack{
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 23) {
                
                ForEach(extractDate()){value in
                    
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
            .padding(15)
            .newoffwhite(offwhiteisTapped: tapcard, cornerradius: 19)
            .padding(.horizontal)
            .onTapGesture {
                withAnimation(.spring()) {
                    tapcard = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(.spring()) {
                        tapcard = false
                    }

                }
            }
        }
        
    }
    
    @ViewBuilder
    
    func CardView(value: DateValue)->some View{
        
        //The calender swift
        HStack{
            if value.day != -1 {
              
                
                Text("29")
                    .padding(0.20)
                    .opacity(0.002)
                    .background(GradientText(text: value.day == -1 ? "" : value.day < 10 ? "\(value.day)" : "\(value.day)", gradient: currentMonth > 0 ? [.black,.gray] : (dayint >= value.day || currentMonth < 0 ? [ Color("black"),Color.orange] : [ Color("black"),Color.gray])))
                    
                
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
                                .animation(.easeInOut, value: value.day)
                        )
                    
                
            
            
            }
        }
        .frame(width: 67, height: 40)
        
        //.offwhitebutton(isTapped: tappedDate, isToggle: false, cornerRadius: 15)
        .onAppear{
            dayint = Int(turntoday()) ?? 6
           
        }
        .onDisappear{
            //let da = "\(returnmonth())/\(returnday())/\(returnyear())"
        
           
        }
        .onTapGesture {
           
            day = "\(value.day) \(extraDate()[1]) \(extraDate()[0])"
            
           // dayint = value.day
            dateTapped()
           // day = convertDate()
        
          
            
        }
       
     
        
        
    }
    func tappedCompleteFunc(){
        if uploadProgress != 4{
            if areyousureTapped == 1 {
                withAnimation(.spring()) {
                    tappedComplete = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    uploadtodatabasefunc()
                    presentationMode.wrappedValue.dismiss()
                }
            } else {
                if tappedDate {
                    withAnimation(.spring()) {
                        showareyouSure = true
                    }
                } else {
                    presentationMode.wrappedValue.dismiss()
                }
            }
           
           
        } else {
            presentationMode.wrappedValue.dismiss()
        }

    }
    func uploadtodatabasefunc(){
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        // Set the data to update
        
        uploadProgress = 1
        
        
        db.collection("users").whereField("email", isEqualTo: user?.email ?? "")
            .getDocuments() { (querySnapshot, error) in
                if error != nil {
                    
                    //     notificationMessage = "there was an error getting the right dociment with emal"
                } else {
                    uploadProgress = 2
                    for document in querySnapshot!.documents {
                        db.collection("users").document("\(document.documentID)").setData(["cycle": "\(returnmonth())/\(returnday())/\(returnyear())"], merge: true) { error in
                            
                            if error == nil {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9)  {
                                    uploadProgress = 3
                                   
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2)  {
                                    
                                    uploadProgress = 4
                                }
                                
                            } else {
                                
                            }
                        }
                    }
                }
            }
        tappedCompleteFunc()
    }
    func dismiss(){
        presentationMode.wrappedValue.dismiss()
    }
    func dateTapped() {
        
        dateconvert = "\(returnDate().formatted(.dateTime.day()))"
       // thisday = Int(dayint)
        tappedDate = true
        currentDate = returnDate()
    }
    func returnday() -> String{
        
        return currentDate.formatted(.dateTime.day(.twoDigits))
        
    }
    func returndayofweek() -> String{
        
        return currentDate.formatted(.dateTime.weekday(.wide))
        
    }
    func returnmonth() -> String{
        
        return currentDate.formatted(.dateTime.month(.twoDigits))
        
    }
    func returnmonthwide() -> String{
        
        return currentDate.formatted(.dateTime.month(.wide))
        
    }
    func returnyear() -> String{
        
        return currentDate.formatted(.dateTime.year())
        
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

struct SetView_Previews: PreviewProvider {
    static var previews: some View {
      // SetView()
       ViewController()
            
    }
}



struct dayweekView: View {
    var day = ""
    @State var y = ""
    var body: some View {
        VStack {
            Text(day)
                .font(.callout)
                .fontWeight(.regular)
                .frame(maxWidth: .infinity)
               
        }
        .padding(.horizontal, 5)
        .padding(.vertical, 7)
        .background(
            Rectangle()
                .fill(y == day ? .pink : .clear)
                .padding(.horizontal, -1)
                .padding(.vertical,-11)
                .cornerRadius(8)
                .newoffwhite(offwhiteisTapped: false, cornerradius: 8)
            
        )
        .onAppear{
            getTime()
        }
    }
    func getTime() -> String {
        let format = DateFormatter()
        format.dateFormat = "E"
        y = format.string(from: Date())
        return format.string(from: Date())
    }
    
   
}

