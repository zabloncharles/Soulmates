//
//  ClockButton.swift
//  iOS15
//
//  Created by Zablon Charles on 12/2/21.
//


import SwiftUI
import UserNotificationsUI



struct ClockButtonView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ViewController()
            .preferredColorScheme(.dark)
    }
}

struct ClockView: View {
    @State var currentTime = Time(sec: 0, min: 0, hour: 0)
    @State var receiver = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    var width = UIScreen.main.bounds.width
    @State var smallClockSize : CGFloat = 320
    @State var appear = false
    @State var dial : Double = 0.50
    @State var dayofweek : Double = 59
    @Binding var clockAppeared : Bool
    var periodPercent : Double = 0.50
    @Binding var clockisTapped : Bool
    var periodCount = 12
    var pregnancyCount = "High"
  
    
    
    
    var body: some View {
        VStack {
            ZStack {
              dayhand
                   
                // Dial
                 firstcircle
                    .overlay(
                        theblueandreddial
                    )
                    .overlay(
                        
                        thedayoftheweek
                    )
                    .overlay(
                        thetextontheblueandreddial
                    )
                
                // Seconds And Min dots...
                firstcircle
                theticks
                
                
                //Minutes
                minutehand
                
                //Hours
                hourhand
                
                //Seconds
                secondshand
                
                //Day of week
                Text("\(getTime().uppercased())")
                    .offset(y:130)
                
            }
               
                .onAppear{
                    clockappearedFunc()
                }
                .onReceive(receiver){ _ in
                    let calender = Calendar.current
                    let sec = calender.component(.second, from: Date())
                    let min = calender.component(.minute, from: Date())
                    let hour = calender.component(.hour, from: Date())
                    
                    withAnimation(Animation.linear(duration: 0.01)){
                        currentTime = Time(sec: sec, min: min, hour: hour)
                        dial = Double("0.\(currentTime.sec)") ?? 0.50
                        
                    }
                }
        }.frame(width: width - 80, height: width - 80)
           
        
    }
    var dayhand: some View {
        Rectangle()
            .fill(Color("offWhite"))
            .frame(width: 14, height: (width - 10) / 1)
            .cornerRadius(80)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            .offset(y: -(width - 180) / 6)
            .rotationEffect(.degrees(appear ? dayofweek : -55.3))
            .animation(.spring(response: 0.5, dampingFraction: 5, blendDuration: 5), value: appear)
            .overlay(
                Rectangle()
                    .fill(.red.opacity(0.89))
                    .frame(width: 12, height: (width - 10) / 1)
                    .cornerRadius(80)
                    .offset(y: -(width - 180) / 6)
                    .rotationEffect(.degrees(appear ? dayofweek : -55.3))
                    .animation(.spring(response: 0.5, dampingFraction: 5, blendDuration: 5), value: appear)
            )
    }
    var firstcircle: some View {
        
        //Small circle
        Circle()
            .fill(Color("offwhite"))
            .shadow(color:  .black.opacity(clockAppeared ? 0.2 : 0), radius: 10, x: 10, y: 10)
            .shadow(color: .black.opacity(clockAppeared ? 0.2 : 0), radius: 10, x: -5, y: -5)
            .scaleEffect(1.2)
            .overlay(
                VStack{
                    Text("PEK \((currentTime.sec))")
                        .offset(y:-70)
                }
                
            )
            
          
    }
    var theblueandreddial: some View {
        // the blue green dial in middle
        Circle()
            .trim(from: 0.0, to: (periodCount > 1 && periodCount < 5) ? 0.99 : (periodCount > 5 && periodCount < 10) ? 0.60 : (periodCount > 10 && periodCount < 15) ? 0.30 : 0.10)
            .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
            .fill(.angularGradient(colors: [Color("offWhite"),.blue,Color("offWhite")], center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
            .shadow(color:  Color("black").opacity(clockAppeared ? 0.2 : 0), radius: 10, x: 10, y: 10)
            .shadow(color: Color("white").opacity(clockAppeared ? 0.9 : 0), radius: 10, x: -5, y: -5)
            .rotationEffect(.degrees(-88))
            .background(Circle()
                            .trim(from: 0.0, to: 0.99 )
                            .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                            .fill(.angularGradient(colors: [Color("offWhite"),.green,Color("offWhite")], center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
                            .shadow(color:  Color("black").opacity(clockAppeared ? 0.2 : 0), radius: 10, x: 10, y: 10)
                            .shadow(color: Color("white").opacity(clockAppeared ? 0.9 : 0), radius: 10, x: -5, y: -5)
                            .rotationEffect(.degrees(-88)))
            .overlay(
                
                //MARK: The moon dial
                Circle()
                    .fill(Color("offWhite"))
                    .frame(width: 20, height: (width - 170) / 3)
                    .cornerRadius(40)
                    .overlay(
                        Circle() //the blue revolving circle
                            .fill(.blue)
                            .frame(width: 16, height: (width - 170) / 3)
                     
                    )
                
                .shadow(color:  Color("black").opacity(clockAppeared ? 0.2 : 0), radius: 10, x: 10, y: 10)
                .shadow(color: Color("white").opacity(clockAppeared ? 0.9 : 0), radius: 10, x: -5, y: -5)
                    .offset(y: -(width - 2) / -1.9)
                
                    .rotationEffect(.init(degrees: Double((currentTime.sec)))) //turn it around
            )
           
          
            .onAppear {
                withAnimation(.spring().delay(0.5)) {
                    appear = true
                    
                }
            }
            .onDisappear {
                appear = false
            }
            .padding(-50)
    }
    var thedayoftheweek: some View {
        HStack(spacing: 0){
            // The day of the week
            CircleText(radius: 240, text: "This part is responsible for the text reveal animation")
                .scaleEffect(1.2)
                .rotationEffect(.degrees(178))
                .opacity(0)
            
                .background(
                    Circle()
                        .trim(from: 0.50, to:  0.89)
                        .stroke(style: StrokeStyle(lineWidth: 33, lineCap: .round))
                        .fill(.angularGradient(colors: [Color("offWhite"), .clear, .clear], center: .center, startAngle: .degrees(0), endAngle: .degrees(appear ? 290 : 0)))
                    
                        .rotationEffect(.degrees(19)) //turn it around
                        .padding(-32)
                        .offset(y: -10)
                        .animation(.spring(response: 0.3, dampingFraction: 7, blendDuration: 9), value: appear)

                        
                )
            
                .background(
            CircleText(radius: 210, text: "Mon Tues Wed Thurs Fri Sat Sun")
                .scaleEffect(1.2)
                .offset(y: -17)
              
            )
        }.padding(5)
    }
    var thetextontheblueandreddial: some View {
        HStack(spacing: 0){
            // chance of pregnacny down right
            CircleText(radius: 240, text: "\(pregnancyCount) Chance of pregnancy    -    Period in \(periodCount) days")
               
                .scaleEffect(1.2)
                .rotationEffect(.degrees(178))
            
                .background(
                    Circle()
                        .trim(from: 0.46, to: appear ? 0.99 : 0.0)
                        .stroke(style: StrokeStyle(lineWidth: 39, lineCap: .round))
                        .fill(.angularGradient(colors: [Color("offWhite"),Color("offWhite"),  pregnancyCount == "High" ? .red : pregnancyCount == "Medium" ? .blue : pregnancyCount == "Low" ? .green : Color("offwhite") , pregnancyCount == "High" ? .red : .green], center: .center, startAngle: .degrees(340), endAngle: .degrees(110)))
                        .shadow(color:  .black.opacity(clockAppeared ? 0.2 : 0), radius: 10, x: 10, y: 10)
                        .shadow(color: Color("white").opacity(clockAppeared ? 0.9 : 0), radius: 10, x: -5, y: -5)
                        .scaleEffect()
                        .rotationEffect(.degrees(189)) //turn it around
                        .padding(-32)
                )
                
        }
        
    }
    var theticks: some View {
        
        
        ForEach(0..<60, id: \.self){ i in
            Rectangle()
                .fill(Color("black")) //middle ticks
                .frame(width: 2, height: (i % 5) == 0 ? 29 : 6)// 60/12 = 5
                .offset(y: (width - 91) / 2)
                .rotationEffect(.init(degrees: Double(i) * 6)) // clip parts of the ticks till its circle
                .rotationEffect(.degrees(clockAppeared ? 180 : 100)) //turn it around
        
        }
    }
    var minutehand: some View {
        Rectangle()
            .fill(Color("black"))
            .frame(width: 4, height: (width - 150) / 2)
            .cornerRadius(80)
            .offset(y: -(width - 180) / 4)
            .rotationEffect(.init(degrees: Double(currentTime.min) * 6))
            .overlay(
                Rectangle()
                    .fill(Color("white"))
                    .border(Color("black"), width: 4)
                    .frame(width: 12, height: (width - 170) / 2)
                    .cornerRadius(40)
                    .offset(y: -(width - 90) / 4)
                    .rotationEffect(.init(degrees: Double(currentTime.min) * 6))
            )
    }
    var hourhand: some View {
        Rectangle()
            .fill(Color("black"))
            .frame(width: 4, height: (width - 240) / 2)
            .cornerRadius(80)
            .offset(y: -(width - 240) / 4)
            .rotationEffect(.init(degrees: Double(currentTime.hour + currentTime.min / 60) * 30))
            .overlay(
                Rectangle()
                    .fill(Color("white"))
                    .border(Color("black"), width: 4)
                    .cornerRadius(80)
                    .frame(width: 12, height: (width - 240) / 2)
                    .offset(y: -(width - 240) / 3)
                    .rotationEffect(.init(degrees: Double(currentTime.hour + currentTime.min / 60) * 30))
                
            )
    }
    
    var secondshand: some View {
        
        Rectangle()
            .fill(Color.red)
            .frame(width: 2, height: (width - 0) / 2) //how tall the tick is
            .offset(y: -(width - 182) / 4)
            .rotationEffect(.init(degrees: Double(currentTime.sec) * 5))
            .overlay(
                Circle()
                        .fill(Color.red)
                        .frame(width: 15, height: 15)
                        .overlay(
                            Circle()
                                    .fill(Color("black"))
                                    .frame(width: 10, height: 10)
                                )
            )
    }
    func clockappearedFunc() {
                    let calender = Calendar.current
                    //58mon,64tues,70wed,77thurs,814fri,86sat,99sun
                    if  getTime() == "Mon" {
                        dayofweek = -55.3
                    }
                    if  getTime() == "Tues" {
                        dayofweek = -35.9
                    }
                    if  getTime() == "Wed" {
                        dayofweek = -15
                    }
                    if  getTime() == "Thurs" {
                        dayofweek = 5
                    }
                    if  getTime() == "Fri" {
                        dayofweek = 26
                    }
                    if  getTime() == "Sat" {
                        dayofweek = 41
                    }
                    if  getTime() == "Sun" {
                        dayofweek = 58
                    }
                    
                    let sec = calender.component(.second, from: Date())
                    let min = calender.component(.minute, from: Date())
                    let hour = calender.component(.hour, from: Date())
                    
                    withAnimation(Animation.linear(duration: 0.05)){
                        currentTime = Time(sec: sec, min: min, hour: hour)
                    }
       
                }
              

    
    func vibrationFeedback() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func getTime() -> String {
        let format = DateFormatter()
        format.dateFormat = "E"
        return format.string(from: Date())
    }
}




