//
//  HomeView.swift
//  iOS15
//
//  Created by Zablon Charles on 2021-06-22.


import SwiftUI
import Lottie
import Firebase
struct StandoutsView: View {
    @ObservedObject var viewModel = UserViewModel()
    @State var showProfile = false
    @Binding var matchcard : MatchCardData
    @Namespace var namespace
    @State var welcomingisTapped = false
    @AppStorage("signInAnimation") var signInAnimation = false
    @State private var offset = CGSize.zero
    @State var hideCard = false
    @State var nomoreCards = false
    @State var pageAppeared = false
    
    
    @State var number = matchCardData.count
    @State var backViewSize: CGFloat = 80
    
    
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(number - 1 - id) * -10
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
    
    // Compute what the max ID in the given users array is.
    private var maxID: Int {
        return  matchCardData.map{ $0.usernumber}.max() ?? 0
        
    }
    
    var body: some View {
        
            ZStack {
                GeometryReader { reader in
                BackgroundView()
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack {
                    welcoming
                        .offset(y: showProfile ? -600 : pageAppeared ? 0 : -300)
                        .animation(.spring(), value: showProfile)
                    
                    
                    if nomoreCards {
                        nocards
                    }
                   
                    
                    
                   
                    if !nomoreCards {
                        VStack {
                                 
                                        ZStack{
                                            
                                            
                                            ForEach(Array(matchCardData.enumerated()), id: \.offset) { index, section in
                                                if index != 0 {  }
                                                if section.usernumber > self.maxID - 3   {
                                                    
                                                    Standoutcard(showProfile: $showProfile, matchcard: $matchcard, section: section, namespace: namespace, hideCard: $hideCard, number: $number, index: index, nomorecards: $nomoreCards)
                                                
                                                   
                                                        .frame( height: 570)
                                                        .padding(.horizontal,self.getCardWidth(reader, id: index) )
                                                        .padding(.top,30)
                                                        .padding(.horizontal, 5)
                                                     .rotation3DEffect(.degrees(-1), axis: (x:10 ,y:0, z:0))
                                                    .offset(y: self.getCardOffset(reader, id: index))
                                                    .animation(.spring())
                                                    
                                                }
                                            }
                                          
                                        }
                                  
                        }.offset(x: pageAppeared ? 0 : 300)
                    }
                    
              
                }
                
                

                
                
            }
            }.onAppear{
                withAnimation(.spring()){
                    pageAppeared = true
                }
            }
            .onDisappear{
                withAnimation(.spring()){
                    pageAppeared = false
                }
            }
        
    }
    
    var nocards: some View {
        VStack {
            VStack {
                LottieView(filename: "loveflying" ,loop: true)
                    .frame(width: 100)
                
            }.offset( x:25, y:400)
                .opacity(0.8)
            
            VStack {
                LottieView(filename: "nomorecards" ,loop: true)
                    .frame(width: 280)
                
            }.offset(y:-160)
            
            
            VStack {
                
                
                
                
                VStack(alignment: .center, spacing: 20.0) {
                    
                    Text("You're new here! No explore cards yet")
                        .font(.headline)
                    Text("Come back later and check for new profiles in your area.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    HStack {
                        Text("Try boosting your profile")
                            .font(.body)
                            .fontWeight(.semibold)
                    }.padding(.horizontal,15)
                        .padding(.vertical,10)
                        .background(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
                        .cornerRadius(30)
                }.padding(10)
                    .offset(y: -190)
                
                
                
            }.padding(20)
            Spacer()
        }
    }
    
    var topspacer: some View{
        Rectangle()
            .frame(width: 100, height: 70)
            .opacity(0)
        
    }
    var welcoming : some View {
        VStack {
            
            HStack {
                HStack {
                    Image(systemName: "person.2.fill")
                    Text("Explore")
                        
                }.font(.title3)
                    .fontWeight(.bold)
                Spacer()
                HStack {
                    Image(systemName: "fleuron")
                    Text("Boost")
                }.padding(.horizontal,12)
                    .padding(.vertical,5)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(20)
                
            }.padding(15).offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 15, action:  .constant(false))
                
            
            typeofprofiles
            
        }.padding(20)
        
    }
    
    var typeofprofiles : some View {
        HStack{
            HStack {
                Text("Compatible")
                    .padding(.vertical,5)
                    .padding(.horizontal,8)
                    .offwhitebutton(isTapped: welcomingisTapped, isToggle: false, cornerRadius: 15, action:  .constant(false))
                
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
                .foregroundColor(.blue)
            
            
        }
            .padding(.top,20)
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
    
    
  
 
    
}



//struct StandoutsView_Previews: PreviewProvider {
//    static var previews: some View {
//        
//      //  StandoutsView( matchcard: Binding<matchCardData>)
//        
//        
//    }
//}
