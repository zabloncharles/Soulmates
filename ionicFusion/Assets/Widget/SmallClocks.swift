//
//  SmallClocks.swift
//  Fusion
//
//  Created by Zablon Charles on 3/19/22.
//

import SwiftUI
///Small clock code starts her----------------------------------------------------------------------
struct SmallClock: View {
    @State var cycle = 0
    var width = UIScreen.main.bounds.width
    @State var smallClockSize : CGFloat = 320
    @State var tapped = false
    @State var smallClockAppeared = false
    @State var smallClockTapped = false
    
    var body: some View {
        VStack {
            ZStack{
                Circle()
                    .fill(Color("offWhite"))
                    .frame(width: width - smallClockSize, height: width - smallClockSize)
                   // .newoffwhite(offwhiteisTapped: false, cornerradius: 80)
                    .onTapGesture{
                        withAnimation(.spring()) {
                            smallClockTapped.toggle()
                        }
                    }
                
                //"Your-Ovulation-Period"
                HStack {
                    CircleText(radius: 60, text: "Your-Match".uppercased(), kerning: 10, height: 140, width: 70, font: .caption2)
                                            .background(
                                                Circle()
                                                    .trim(from: 0.0, to: 0.99 )
                                                    .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round))
                                                    .fill(.angularGradient(colors: [Color("offwhite")], center: .center, startAngle: .degrees(110), endAngle: .degrees(60)))
                                                    .rotationEffect(.degrees(140)) //turn it around
                    
                                                    .padding(-14)
                                            )
                    
                    
                }
                Image(systemName: "fleuron")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                
                HStack {
                    CircleText(radius: 80, text: " 0%  15%  30%  45%  60%  100%".uppercased(), kerning: 10, height: 90, width:170, font: .caption2)
                       
                    
                    
                }
                Image(systemName: "fleuron")
                    .font(!smallClockAppeared ? .footnote : .largeTitle)
                    .foregroundColor(.gray)
                    
                
                // black seconds
                ForEach(0..<60, id: \.self){ numbers in //tick size in circle
                    Rectangle()
                        .foregroundColor(.red)
                        .frame(width: 10, height: (width - 383) / 207)
                    
                        .offset(y: (width - 235) / 4)
                        .rotationEffect(.init(degrees: Double(numbers) * 100.34))//how many you want shown
                        .rotationEffect(.degrees(smallClockAppeared ? -70 :  20))
                    
                    //Small Clock Tick
                    Rectangle()
                        .fill(.gray)
                        .frame(width: 1, height: (width - 322) / 5)
                        .overlay(
                        Image(systemName: "arrowtriangle.down.fill")
                            .foregroundColor(.gray)
                            .font(.caption2)
                            .rotationEffect(.degrees(180))
                            .offset(y: -7)
                        )
                        .offset(y: (width - 460) / 1)
                    //2 = 0 // 13.6 = 15% // 22.6 = 30% // 31.0 = 45% // 40 = 60% // 50 = 100%
                        .rotationEffect(.init(degrees: Double(abs(smallClockAppeared ? abs(getpercent()) : 40)) * 20 / 3 - 15))
                        .rotationEffect(.degrees(-180))
                        
               
                }
               
                
            }
            
          
            
        }.onAppear {
            withAnimation(.spring()) {
                smallClockAppeared = true
            }
        }
        .onDisappear {
            withAnimation(.spring()) {
                smallClockAppeared = false
            }
        }
    }
    func getpercent() ->  Double  {
        
        var thepercent = 0.0
        
        if cycle == 0 {
            thepercent = 2
        } else if cycle == 15 {
            thepercent = 13.6
        } else if cycle == 30 {
            thepercent = 22.6
        } else if cycle == 45 {
            thepercent = 31.0
        } else if cycle == 60 {
            thepercent = 40
        } else if cycle == 100 {
            thepercent = 50
        }
        
        return thepercent
    }
   
}


func getTime() -> String {
    
    let format = DateFormatter()
    // format.dateFormat = "HH:mm"
    
    // formatter.dateFormat = "E, dd MMM yyyy"
    format.dateFormat = "hh:mm"
    
    return format.string(from: Date())
}


struct SmallClock2: View {
    @State var smallClockSize : CGFloat = 320
    @State var smallClockAppeared = false
    var pregnancyCount = ""
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            ZStack{
                Circle()
                    .fill(Color("offWhite"))
                    .frame(width: width - smallClockSize, height: width - smallClockSize)
                    .shadow(color:  Color("black").opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color("white").opacity(0.9 ), radius: 10, x: -5, y: -5)
                
                HStack {
                    Text("Low".uppercased())
                    
                    Spacer()
                    Text("High".uppercased())
                        .foregroundColor(.red)
                    
                }.frame(width: 70 )
                    .padding(30)
                    .font(.caption2)
                    .offset(y: 27)
                    .scaleEffect(0.80)
                
                HStack {
                    CircleText(radius: 60, text: "Chance-of-Pregnancy".uppercased(), kerning: 7, height: 135, width: 50, font: .caption2)
                    
                }
                
                Image("")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width - smallClockSize, height: width - smallClockSize)
                    .cornerRadius(150)
                    .offset(y: (width - 427) / 4)
                
                
                // black seconds
                ForEach(0..<30, id: \.self){ numbers in //tick size in circle
                    Rectangle()
                        .foregroundColor(numbers > 20 ? .red : numbers > 7 ? .blue : .black)
                        .background(.ultraThinMaterial)
                        .frame(width: 1, height: (width - 380) / 6)
                    
                        .offset(y: (width - 252) / 4)
                        .rotationEffect(.init(degrees: Double(numbers) * 7.7))//how many you want shown
                        .rotationEffect(.degrees(69))
                    //Small Clock Tick
                    Rectangle()
                        .fill(Color.pink)
                        .frame(width: 1, height: (width - 310) / 2)
                        .offset(y: -(width - 400) / 1.5)
                        .rotationEffect(.init(degrees: smallClockAppeared ? (Double(pregnancyCount == "High" ? 18.6 : pregnancyCount == "Medium" ? 60 :  pregnancyCount == "Low" ? 41.54 : 41.54) * 6) : 480 ))
                    
                        .onAppear {
                            withAnimation(.spring(response: 2, dampingFraction: 2, blendDuration: 7)) {
                                smallClockAppeared = true
                            }
                        }
                        .onDisappear {
                            withAnimation(.spring()) {
                                smallClockAppeared = false
                            }
                        }
                    
                    Circle()
                        .fill(Color("black"))
                        .frame(width: 5, height: 5)
                    
                }
            }
        }
    }
}

struct SmallClock3: View {
    @State var receiver = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    var width = UIScreen.main.bounds.width
    @State var smallClockSize : CGFloat = 320
    @State var smallClockAppeared = false
    
    
    var body: some View {
        VStack {
            ZStack{
                Circle()
                    .fill(Color("offwhite"))
                    .frame(width: width - smallClockSize, height: width - smallClockSize)
                
                    .shadow(color: Color("black").opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color("white").opacity(0.9 ), radius: 10, x: -5, y: -5)
                
                
                //Small Clock Tick
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 2, height: (width - 350) / 5)
                    .offset(y: (width - -90) / -11.2)
                    .rotationEffect(.init(degrees: Double(32) * 6))
                
                Circle()
                
                    .fill(.black)
                    .padding(15)
                    .frame(width: (width - smallClockSize), height: (width - smallClockSize))
                
                //  .shadow(color:  Color("black").opacity(0.2), radius: 10, x: 10, y: 10)
                //  .shadow(color: Color("white").opacity(0.9 ), radius: 10, x: -5, y: -5)
                
                
                HStack {
                    CircleText(radius: 80, text: "Your-Astronomy-calendar".uppercased(), kerning: 7, height: 140, width: 70, font: .caption2)
                    
                }
                
                //                Image("")
                //                    .resizable(resizingMode: .stretch)
                //                    .aspectRatio(contentMode: .fill)
                //                    .frame(width: width - smallClockSize, height: width - smallClockSize)
                //                    .cornerRadius(150)
                //                    .offset(y: (width - 427) / 4)
                //                    .offset(x: -(width - 40) / 4)
                //                    .shadow(color: Color("Shadow"), radius: 2, x: 0, y: 0)
                
                
                // black seconds
                ForEach(0..<30, id: \.self){ numbers in //tick size in circle
                    Circle()
                        .fill(.blue)
                        .foregroundColor(.blue)
                        .frame(width: 7, height: (width - 390) / 2)
                        .rotationEffect(.degrees(180))
                        .offset(y: (width - 252) / 6)
                        .rotationEffect(.init(degrees: Double(numbers) * 140))//how many you want shown
                        .onAppear {
                            withAnimation(.spring(response: 2, dampingFraction: 2, blendDuration: 7)) {
                                smallClockAppeared = true
                            }
                        }
                        .onDisappear {
                            withAnimation(.spring()) {
                                smallClockAppeared = false
                            }
                        }
                    
                    
                    
                    
                    Circle()
                        .fill(Color("black"))
                        .frame(width: 5, height: 5)
                    
                }
                
            }
          
        }
    }
    
}


struct SMallClocksView_Previews: PreviewProvider {
    static var previews: some View {
     
        SmallClock()
    }
}
