//
//  ProfileCard.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/13/23.
//

import SwiftUI

struct ProfileCard: View {
    @Binding var showProfile : Bool
    @Binding var matchcard : MatchCardData
    var section : MatchCardData
    @State var welcomingisTapped = false
    var namespace: Namespace.ID
    @State var backViewSize: CGFloat = 80
    @State var size: CGSize = .zero
    @Binding var number : Int
    var index : Int
    @State var dislike = false
    @State var nomorecards = false
    @Binding var dragsize : CGSize
    @State var show = false
    @State var hide = false
    
    var body: some View {
        VStack {
          
                ProfileInfoCard(showProfile: $showProfile, section: section, namespace: namespace, dislike: $dislike)
                  
                .padding(.all, 20.0)
                .background(
                    
                    ZStack{
                        Image(section.background)
                            .resizable(resizingMode: .stretch)
                            .aspectRatio(contentMode: .fill)
                            .matchedGeometryEffect(id: "\(section.background)", in: namespace)
                        
                        Image(section.background)
                            .resizable(resizingMode: .stretch)
                            .aspectRatio(contentMode: .fill)
                            .blur(radius: 5)
                            .matchedGeometryEffect(id: "\(section.background)", in: namespace)
                            
                            .mask(LinearGradient(gradient: Gradient(colors: [.clear, .clear, .black,.black]), startPoint: .top, endPoint: .bottom))
                            .overlay(
                                VStack {
                                    HStack {
                                        Image(systemName: "person.and.background.dotted")
                                        Text("\(section.usernumber)")
                                       // Text("number = \(number) number = \(index) usrnumber = \(section.usernumber)")
                                    }
                                } .padding(.horizontal,10)
                                    .padding(.vertical,4)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(9)
                                    .offset(x:-150,y:-220)
                            )
                      
                        
                    }
                )
                
                .offwhiteCard(isToggle: show, cornerRadius: 25, action: $showProfile, shadow: false, matchcard: $matchcard, section: section)
                .padding(.bottom,12)
                .padding(show ?  0 : 10)
                .offset(y:hide ? 750 : self.size.height)
                .animation(.spring(), value: self.size)
                .gesture(DragGesture().onChanged({ (value) in
                   
                        self.size = value.translation
                        self.dragsize = value.translation
                    
                })
                    .onEnded({ (value) in
                        self.size = .zero
                        self.dragsize = .zero
                       // removeCard()
                    }))
                    .background(
                        VStack {
                            
                            //if dislike is tapped DO THIS
                            if dislike {
                                Color.black
                                    .opacity(0)
                                    .onAppear{
                                       
                                        withAnimation(.spring()) {
                                            hide = true
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            removeCard()
                                        }
                                        
                                    }
                                    
                            }
                        }.opacity(0))
                    .onAppear{
                        withAnimation(.spring()) {
                            show = true
                        }
                    }
                    
            
        }
       
       
        
        
        
        
       
       
    }
 
    func removeCard() {
        
        matchcard = section
       
        number = number - 1
        
        if dislike {
          
            withAnimation(.spring()){
                
                self.size = CGSize(width: -500, height: 0)
                
                    
               
            }
            if section.usernumber >= 0 {
                matchCardData.remove(at: section.usernumber)
            }
        }
        
       
        if matchCardData.indices.contains(section.usernumber){
            
            nomorecards = false
        } else {
            nomorecards = true
        }
        
        
        
    }

    }



struct ProfileInfoCard: View {
    @Binding var showProfile : Bool
    @State var welcomingisTapped = false
     var section: MatchCardData
    var namespace: Namespace.ID
    @Binding var dislike : Bool
    
    var body : some View {
        VStack(alignment: .leading, spacing: 0.0) {
            Spacer()
            
            
            VStack(alignment: .leading, spacing: 0) {
          
                    VStack(alignment: .leading,spacing: 0) {
                        HStack(alignment: .center) {
                            Text(section.name)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .lineLimit(1)
                                .shadow(color:  .black.opacity(0.2), radius: 2, x:3, y: 2 )
                                
                            
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 22, weight: .medium))
                                .foregroundColor(.blue)
                        }
                        
                       
                        
                    }.padding(.bottom,5)
                    
                    
                    
                    
                
                
                HStack {
                    VStack {
                       Image("Avatar 2")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .cornerRadius(6)
                            
                    }.overlay(
                        Text("\(section.name)")
                            .font(.custom("Carlotte", size: 40))
                            .foregroundStyle(.primary)
                            .opacity(0.5)
                            .offset(y:100)
                    )
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack(spacing: 3.5){
                            Image(systemName: "circle.fill")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(section.status == 0 ? .red : .green)
                            
                            Text(section.status == 0 ?  "Offline" : "Online now")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .foregroundColor(.secondary)
                            
                        }
                        
                        HStack(spacing:2) {
                            Image(systemName: "house")
                                .font(.system(size: 18, weight: .medium))
                            
                            
                            Text(section.location)
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .lineLimit(2)
                            
                        }.foregroundColor(.primary)
                        HStack(spacing:20) {
                            HStack {
                                Text("SEX:")
                                    .font(.footnote)
                                    .fontWeight(.regular)
                                    .lineLimit(2)
                                Text("Female")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                .lineLimit(2)
                            }
                            
                            
                            HStack {
                                Text("Height:")
                                    .font(.footnote)
                                    .fontWeight(.regular)
                                    .lineLimit(2)
                                Text("5-09")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .lineLimit(2)
                            }
                            
                        }.foregroundColor(.primary)
                        HStack {
                            Image(systemName: "highlighter")
                            Text(" \"\(section.quote)\" ")
                                .font(.footnote)
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.primary)
                        }
                        
                    }.foregroundColor(.black)
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
                                .offwhitebutton(isTapped: welcomingisTapped, isToggle: true, cornerRadius: 60, action:  $dislike)
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
                                    .offwhitebutton(isTapped: welcomingisTapped, isToggle: false, cornerRadius: 60, action:  $showProfile)
                                
                                
                            }
                            
                            
                        )
                    
                    
                    
                } .frame(maxWidth: .infinity)
                    .padding(15)
                    .background(.ultraThinMaterial)
                    .cornerRadius(30)
                    .padding(5)
                   
            }.padding()
               //
                .background(
                    Image("licensebg")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.4)
                )
                .background(
                    Image("aries")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0.4)
                )
                .background(
                    Image("image_06")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        
                )
                //.offwhitebutton(isTapped: welcomingisTapped, isToggle: false, cornerRadius: 20, action:  .constant(false))
                .cornerRadius(20.0)
                .scaleEffect( dislike ?  0.97 : 1)
                .shadow(color:  .black.opacity(0.6), radius: 8, x:3, y: 2 )
            
                .overlay(
                    Image("Avatar 2")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80.0, height: 80.0)
                        .opacity(0.0)
                        .cornerRadius(60)
                        .background(
                            SmallClock()
                                .scaleEffect(0.84)
                        )
                        .padding([.top],-99)
                        .padding([.leading],240)
                    
                    
                )
        }
        
        
    }
}




struct ProfileCard_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
       // ProfileCard(showProfile: .constant(false), namespace: namespace)
        ViewController()
    }
}
