//
//  HomeView.swift
//  iOS15
//
//  Created by Meng To on 2021-06-22.
//

import SwiftUI
import Lottie
import FirebaseFirestore
import Firebase

struct HomeView: View {
    @AppStorage("saveinfo") var saveinfo = ""
    @ObservedObject var viewModel = UserViewModel()
    @State var pregnancyChance = "Low"
    @State var welcomeMessage = ""
    @State var animateChance = false
    @State var show = false
    @State var showStatusBar = true
    @State var contentHasScrolled = false
    @State var appeared = false
    @State var clockAppeared = false
    @Namespace var namespace
    @State var clockisTapped = false
    @State var welcomingisTapped = false
    @State var animateGreeting = false
    @State var cycleChangeSoon = false
    @AppStorage("signInAnimation") var signInAnimation = false
    
    
    var body: some View {
        ZStack {
            
            BackgroundView()
                .edgesIgnoringSafeArea(.all)
            //Background Color
         //   Color("background").ignoresSafeArea()
                
            navigation
                .offset(y: appeared  ? 0 :  signInAnimation ? -200 : 0)
            
            VStack {
            
                welcoming
                    .offset(y:appeared ? 0 : signInAnimation ? -200 : 0)
                
                clock
                   // .offset(y:appeared ? 0 : 300)
                info
                    .offset(y:appeared ? 0 : signInAnimation ? 200 : 0)
                 
            }
            
            
            
        }
        
    }
    var navigation: some View {
        NavigationBar( title: "Fusion",
                       contentHasScrolled: $contentHasScrolled)
    }
 
    var topspacer: some View{
        Rectangle()
            .frame(width: 100, height: 70)
            .opacity(0)
        
    }
    var welcoming : some View {
        VStack {
           
                HStack(spacing: 16){
                    VStack(alignment: .leading, spacing: 5) {
                        
                        ShimmerVar(text: "W\("elcome back \(data()[1])".lowercased())" , useCustomFont: true)
                            
                        
                        VStack {
                            if show {
                            
                                
                                    VStack {
                                        Text(welcomeMessage)
                                           
                                            .opacity(show ? 1:0)
                                            
                                            .onDisappear{
                                                show = false
                                            }
                                           
                                    }
                                    
                                
                                       
                              
                            } else {
                                Text("Your cycle is on schedule")
                                   .onAppear{
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        show = true
                                       }
                                    }
                                
                            }
                            
                        }.font(.subheadline)
                            .animation(.spring(), value: show)
                            .transition(.asymmetric(
                                insertion: .move(edge: .bottom),
                                removal: .move(edge: .top)
                            ))
                            
                           
                          
                        
                    }
                    
                    
                    
                    Spacer()
                    Image("Background 9")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 70, height: 70)
                        .overlay(
                            VStack {
                                //days left
                                Text("4")
                                    .font(.subheadline)
                                //Text(Int(data()[3]) ?? 0 < 1 ? "Day" :"Days")
                                Text("Day")
                                    .font(.caption2)
                                    .fontWeight(.light)
                            }
                        )
                        .background(
                            Circle()
                                .fill(Color("offWhite"))
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray, lineWidth: 4)
                                        .blur(radius: 4)
                                        .offset(x: 2, y: 2)
                                        .mask(Circle().fill(LinearGradient(Color("black"), Color.clear)))
                                )
                                .overlay(
                                    Circle()
                                        .stroke(Color("offWhite"), lineWidth: 8)
                                        .blur(radius: 4)
                                        .offset(x: -2, y: -2)
                                        .mask(Circle().fill(LinearGradient(Color.clear, Color("black"))))
                                )
                                .padding(-1.3)
                        )
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(Color("offWhite"))
                .scaleEffect(welcomingisTapped ? 0.98 : 1)
                .offwhitebutton(isTapped: welcomingisTapped, isToggle: false, cornerRadius: 15)
                .padding(.horizontal,20)
            .padding(.bottom, 5)
            .onAppear {
                
                    getpregnacnychanceFunc()
                    animateChance = true
                
                withAnimation(.spring(response: 1.9, dampingFraction: 1.5, blendDuration: 8)) {
                    if signInAnimation {
                        appeared = true
                    }
                }
            }
            .onDisappear {
                withAnimation(.spring()) {
                    
                    appeared = false
                    signInAnimation = false
                   
                }
            }
            
        }
       
    }
    
    var clock : some View {
        VStack {
            
            ClockView(clockAppeared: $clockAppeared, clockisTapped: $clockisTapped, periodCount: Int(data()[3]) ?? 0, pregnancyCount: data()[4])
                
                    .scaleEffect(clockisTapped ? 0.57 : 0.58)
                    .newoffwhite(offwhiteisTapped: clockisTapped, cornerradius: 180)
                    .scaleEffect((clockisTapped ? 0.97 : clockAppeared ? 1 : signInAnimation ? 0.90 : 1))
                 
                    
                   
                    
                    .padding(20)
                    .onAppear{
                   
                        withAnimation(.spring(response: 2, dampingFraction: 2, blendDuration: 7)){
                           
                            clockAppeared = true
                        }
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                        clockisTapped.toggle()
                        }
                    }
                    .onDisappear{
                        withAnimation(.spring()) {
                            clockAppeared = false
                        }
                        
                      
                }
            
               
        }.padding(.vertical, 10)
    }
    
    var info: some View {
        VStack {
            
                HStack(spacing:26){
                    
                   SmallClock(periodCount: Int(data()[3]) ?? 0)
                    SmallClock2(pregnancyCount: data()[4])
                    SmallClock3()
                    
                }.padding(10)
                    .scaleEffect(0.94)
            
        }
    }
    //return an array of string
    func data()->[String]{
        
        let data = saveinfo
        // 0:name , 1:lname , 2:notifications, 3:period, 4:medium, 5:cycledate, 6:age, 7:email
        return data.components(separatedBy: ",")
    }
    func getpregnacnychanceFunc(){
        let cycle = Int(data()[2]) ?? 0
        
        if cycle >= 1 && cycle <= 2{
            welcomeMessage = "Possible To Conceive"
        }
        else if cycle >= 3 && cycle <= 7{
            welcomeMessage = "Ovulation: \"The Fertile Window\" Best Chance of Conception"
          
        }
        else if cycle >= 8 && cycle <= 9{
            welcomeMessage = "Possible To Conceive"
        }
        else if cycle >= 10 && cycle <= 21{
            welcomeMessage = "Unlikely to Conceive"
        }
        else if cycle >= 22 && cycle <= 28{
            welcomeMessage = "Menstruation: Least Fertile"
        }
    }
 
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
      
        ViewController()
            .preferredColorScheme(.light)
        
    }
}
