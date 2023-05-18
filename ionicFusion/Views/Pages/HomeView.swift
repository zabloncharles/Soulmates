//
//  HomeView.swift
//  iOS15
//
//  Created by Zablon Charles on 2021-06-22.


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
    @State var showProfile = false
    @Binding var matchcard : MatchCardData
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
    @State private var offset = CGSize.zero
    @State var hideCard = false
    @State var pageAppeared = false
    @State var dislike = false
    
    @State var number = matchCardData.count
    @State var backViewSize: CGFloat = 80
    
    
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(number - 1 - id) * -20
    }
    // Compute what the max ID in the given users array is.
    /// Return the CardViews width for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current user
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset = CGFloat(number - 1 - id) * 10
        return  offset
    }
    private func get3d(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset = CGFloat(number - 1 - id) * 10
        return  offset
    }
    // Compute what the max ID in the given users array is.
    private var maxID: Int {
        return  matchCardData.map{ $0.usernumber}.max() ?? 0
        
    }
    
    var body: some View {
        
            ZStack {
                
                BackgroundView()
                    .edgesIgnoringSafeArea(.all)
                
                        GeometryReader { reader in
                            
                                
                         //   ScrollView(.vertical){
                    
                VStack {
                   
                    
                    
                    welcoming
                        .offset(y: showProfile ? -600 : 0)
                        .animation(.spring(), value: showProfile)
                        .offset(y: pageAppeared ? 0 : reader.size.height * -1)
                        
                   
                                
                                
                    
                    VStack {
                        VStack{
                            
                                                
                                                
                            ForEach(Array(matchCardData.enumerated().reversed()), id: \.offset) { index, section in
                                                    if index != 0 {  }
                                                    if section.usernumber > self.maxID - 3   {
                                                        
                                                        ProfileCard(showProfile: $showProfile, matchcard: $matchcard, section: section, namespace: namespace, hideCard: $hideCard, number: $number, index: index)
                                                          //  .frame(width:reader.size.width - 20, height:  530)
                                                        
                                                            .frame( height: 530)
                                                            .padding(.horizontal,self.getCardWidth(reader, id: index) )
                                                            .padding(.top,0)
                                                            .padding(.bottom,20)
                                                            .padding(.horizontal, 8)
                                                            .rotation3DEffect(.degrees(self.get3d(reader, id: index)), axis: (x:10 ,y:0, z:0))
                                                            .offset(y: self.getCardOffset(reader, id: index))
                                                            .animation(.spring())
                                                        
                                                        
                                                    }
                                                }
                            }.offset(y: pageAppeared ? 0 : reader.size.height * 2)
                            .opacity(pageAppeared ? 1 : 0)
                    }
                        
                }.padding(.top, reader.size.height / 13 )
                                    
                                
                                
                            
                            
                         
                            
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    
              //  }
                
                
                
                if showProfile {
                    FullProfileView(namespace: namespace, matchcard: $matchcard, showProfile: $showProfile)
                        .matchedGeometryEffect(id: "page", in: namespace, isSource: showProfile)
                    
                }
                
                
            }
                
                navigation
                    .offset(y: showProfile || !pageAppeared ? -200 : 0)
                    .animation(.spring(), value: showProfile)
            }.onAppear{
                withAnimation(.spring().speed(0.4)){
                    pageAppeared = true
                }
            }
            .onDisappear{
                withAnimation(.spring()){
                    pageAppeared = false
                }
            }
        
    }
    
    var navigation: some View {
        NavigationBar( title: "Soulmate",
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
                    ///  ShimmerVar(text: "W\("elcome back vera".lowercased())" , useCustomFont: true)
                    
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
                            Text("Find your soulmate")
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
                            Text("Matches")
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
            .offwhitebutton(isTapped: welcomingisTapped, isToggle: false, cornerRadius: 15, action: .constant(false))
            .padding(.horizontal,20)
            .padding(.bottom, 5)
            .onAppear {
                
                getuserData()
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
            
            typeofprofiles
            
        }
        
    }
    
    var typeofprofiles : some View {
        HStack{
            HStack {
                Text("Compatible")
                    .padding(.vertical,5)
                    .padding(.horizontal,8)
                
                    .cornerRadius(40)
                    .offwhitebutton(isTapped: welcomingisTapped, isToggle: false, cornerRadius: 20, action:  .constant(false))
                
                Spacer()
                Text("Active")
                Spacer()
                Text("Nearby")
                Spacer()
                Text("New Here")
                
                
            }
            
            Spacer()
            
            Image(systemName: "person.fill.badge.plus")
                .font(.system(size: 26, weight: .thin))
                .foregroundColor(.black)
            
            
        }.padding(.horizontal)
            .padding(.top,10)
            .padding(.bottom,13)
    }
    
    var profile : some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Spacer()
            
            
            VStack(spacing: 2) {
                
                HStack{
                    VStack(alignment: .leading,spacing: 0) {
                        HStack(alignment: .center) {
                            Text("Jenna Mars")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                                .lineLimit(1)
                            
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 22, weight: .medium))
                                .foregroundColor(.blue)
                        }
                        
                        HStack(spacing: 3.5){
                            Image(systemName: "circle.fill")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(.green)
                            
                            Text("Online now")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .foregroundColor(.secondary)
                        }
                        
                    }
                    
                    
                    
                    
                    Spacer()
                    
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    HStack {
                        Image(systemName: "house")
                            .font(.system(size: 18, weight: .medium))
                        
                        
                        Text("Lives in Rochester")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                        
                    }.foregroundColor(.secondary)
                    Text("Fun loving and looking to settle up with this stuff and do me. its really not like that said no one ever.")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.secondary)
                    
                }
                
                HStack {
                    Rectangle()
                        .frame(height: 0.2)
                        .opacity(0.1)
                        .padding(5)
                }
                HStack{
                    Image(systemName: "arrow.counterclockwise")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor( Color.teal)
                    
                        .background(
                            Circle()
                                .fill(Color("offwhite"))
                                .frame(width:46, height:  46)
                                .offwhitebutton(isTapped: welcomingisTapped, isToggle: false, cornerRadius: 60, action:  .constant(false))
                        )
                    
                    Spacer()
                    
                    Image(systemName: "xmark")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor( Color.red)
                    
                        .background(
                            Circle()
                                .fill(Color("offwhite"))
                                .frame(width:46, height:  46)
                                .offwhitebutton(isTapped: welcomingisTapped, isToggle: false, cornerRadius: 60, action:  .constant(false))
                        )
                    
                    Spacer()
                    
                    Image(systemName: "star.fill")
                        .font(.system(size: 26, weight: .thin))
                        .foregroundColor( Color.blue)
                    
                        .background(
                            Circle()
                                .fill(Color("offwhite"))
                                .frame(width:46, height:  46)
                                .offwhitebutton(isTapped: welcomingisTapped, isToggle: false, cornerRadius: 60, action:  .constant(false))
                        )
                    
                    Spacer()
                    
                    Image(systemName: "heart.fill")
                        .font(.system(size:  26, weight: .bold))
                        .foregroundColor(Color.green)
                    
                        .background(
                            
                            
                            ZStack {
                                Circle()
                                    .fill(Color("offwhite"))
                                    .frame(width:46, height:  46)
                                    .offwhitebutton(isTapped: welcomingisTapped, isToggle: false, cornerRadius: 60, action:  .constant(false))
                                
                                
                            }
                            
                            
                        )
                    
                    
                    
                } .frame(maxWidth: .infinity)
                    .padding(10)
            }.padding()
                .offwhitebutton(isTapped: welcomingisTapped, isToggle: false, cornerRadius: 20, action:  .constant(false))
                .cornerRadius(25.0)
            
                .overlay(
                    Image("Avatar 3")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80.0, height: 80.0)
                        .cornerRadius(60)
                        .background(
                            SmallClock()
                        )
                        .padding([.top],-139)
                        .padding([.leading],199)
                    
                    
                )
        }
        .padding(.all, 20.0)
        
        
        .frame(height:  530)
        .background(
            
            ZStack{
                Image("image_02")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                Image("image_02")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 5)
                    .mask(LinearGradient(gradient: Gradient(colors: [.clear, .clear, .black,.black]), startPoint: .top, endPoint: .bottom))
            }
        )
        
        .offwhitebutton(isTapped: welcomingisTapped, isToggle: false, cornerRadius: 25, action:  .constant(false))
        .padding(.horizontal,10)
        .padding(.bottom,15)
    }
    
    
    //return an array of string
    func data()->[String]{
        
        //   var data = saveinfo
        let data = "Bridget,Miller,5,4,Possible,4,04/25/2000,z.test@gmail.com"
        
        // 0:name , 1:lname , 2:notifications, 3:period, 4:medium, 5:cycledate, 6:age, 7:email
        return data.components(separatedBy: ",")
    }
    func getuserData(){
        let cycle = Int(data()[2]) ?? 0
        
        if cycle >= 1 && cycle <= 2{
            welcomeMessage = "Possible To Conceive"
        }
        else
        {
            welcomeMessage = "You're on a roll, you have many matches today"
            
        }
      
    }
    
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        ViewController()
        
        
    }
}
