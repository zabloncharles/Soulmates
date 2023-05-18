//
//  ProfileCard.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/13/23.
//

import SwiftUI

struct Standoutcard: View {
    @Binding var showProfile : Bool
    @Binding var matchcard : MatchCardData
    var section : MatchCardData
    @State var welcomingisTapped = false
    var namespace: Namespace.ID
    @Binding var hideCard : Bool
    @State var backViewSize: CGFloat = 80
    @State var size: CGSize = .zero
    @Binding var number : Int
    var index : Int
    @Binding var nomorecards : Bool
    @State var dislike = false
 
    
    
    
    var body: some View {
        StandoutcardInfoCard(showProfile: $showProfile, section: section, namespace: namespace, dislike: $dislike)
          
            .padding(.all, 20.0)
        
        
        //.frame(height:  530)
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
                                    Text("\(index)" )
                                }
                            } .padding(.horizontal,10)
                                .padding(.vertical,4)
                                .background(.ultraThinMaterial)
                                .cornerRadius(6)
                                .offset(x:-150,y:-230)
                        )
                    // Text("\(size.width)")
                    // Text("\(number)")
                    
                }
            )
        
            .offwhiteCard(isToggle: false, cornerRadius: 15, action: $showProfile, matchcard: $matchcard, section: section)
            .padding(.horizontal,10)
            .padding(.bottom,15)
            .background(
                VStack {
                    if dislike {
                        Color.black
                            .opacity(0)
                            .onAppear{
                                removeCard()
                            }
                    }
                }.opacity(0))
            .gesture(DragGesture().onChanged({ (value) in
                dislike = false
                self.size = value.translation
                self.backViewSize = 20
            })
                .onEnded({ (value) in
                    
                              removeCard()
                }))
            .offset(y: self.size.height)
            .animation(.spring(), value: self.size)
            
        
        
        
        
        
        
        
        
        
    }
    
    func removeCard() {
        //  matchCardData.remove(at: index)
        matchcard = section
        
        number = number - 1
        
        switch self.size.height {
            case -500...(-110):
                
                
                
                
                    withAnimation(.spring()){
                        self.size = CGSize(width: 0, height: -1000)
                    }
                
                
                
            case 110...500:
             
            
                    withAnimation(.spring()){
                        self.size = CGSize(width: 0, height: 1000)
                    }
                
               
                
                
            default:
                self.size = .zero
                
        }

        if dislike {
            matchCardData.remove(at: section.usernumber)
            withAnimation(.spring()){
                self.size = CGSize(width: 0, height: 700)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    
                }
            }
        }
        
        if !dislike && (index >= 1) {
            matchCardData.remove(at: section.usernumber)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
            }
            
        }
        
      
         
            if index < 1 {
                nomorecards = true
            } else {
                nomorecards = false
            }
            
        
        
    }
    
}



struct StandoutcardInfoCard: View {
    @Binding var showProfile : Bool
    @State var welcomingisTapped = false
    var section: MatchCardData
    var namespace: Namespace.ID
    @Binding var dislike : Bool
    
    
    var body : some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Spacer()
            
            
            VStack(spacing: 2) {
                
                HStack{
                    VStack(alignment: .leading,spacing: 0) {
                        HStack(alignment: .center) {
                            Text(section.name)
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
                                .foregroundColor(section.status == 0 ? .red : .green)
                            
                            Text(section.status == 0 ?  "Offline" : "Online now")
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
                        
                        
                        Text(section.location)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                        
                    }.foregroundColor(.secondary)
                    Text(section.quote)
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
                                .offwhitebutton(isTapped: welcomingisTapped, isToggle: false, cornerRadius: 60, action: $dislike)
                        )
                    
                    Spacer()
                    
                    Image(systemName: "xmark")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor( Color.red)
                    
                        .background(
                            Circle()
                                .fill(Color("offwhite"))
                                .frame(width:46, height:  46)
                                .offwhitebutton(isTapped: welcomingisTapped, isToggle: false, cornerRadius: 60, action: $dislike)
                        )
                       
                    
                    Spacer()
                    
                    Image(systemName: "star.fill")
                        .font(.system(size: 26, weight: .thin))
                        .foregroundColor( Color.blue)
                    
                        .background(
                            Circle()
                                .fill(Color("offwhite"))
                                .frame(width:46, height:  46)
                                .offwhitebutton(isTapped: welcomingisTapped, isToggle: false, cornerRadius: 60, action: $dislike)
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
                                    .offwhitebutton(isTapped: welcomingisTapped, isToggle: false, cornerRadius: 60, action: $dislike)
                                
                                
                            }
                            
                            
                        )
                    
                    
                    
                } .frame(maxWidth: .infinity)
                    .padding(10)
                    .padding(.bottom, 5)
            }.padding()
                .offwhitebutton(isTapped: welcomingisTapped, isToggle: false, cornerRadius: 20, action: .constant(false))
                .cornerRadius(25.0)
            
                .overlay(
                    Image(section.profilepic)
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80.0, height: 80.0)
                        .cornerRadius(60)
                        .background(
                            SmallClock()
                        )
                        .padding([.top],-139)
                        .padding([.leading],199)
                    
                    
                )
        }
        
        
    }
}




struct Standoutcard_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        // ProfileCard(showProfile: .constant(false), namespace: namespace)
        ViewController()
    }
}
