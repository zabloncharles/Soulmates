//
//  MatchCard.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/23/23.
//

import SwiftUI



struct MatchCard_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
    }
}

struct MatchCard: View {

    var section : MatchCardData
    var namespace: Namespace.ID
    @State var dislike = false
    @State var welcomingisTapped = false
   
    
    
    
    
    var body: some View {
     
            info
            
                .padding(.all, 20.0)
            
            
            .frame(height:  530)
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
                                        Text("\(section.usernumber)" )
                                    }
                                } .padding(.horizontal,10)
                                    .padding(.vertical,4)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(6)
                                    .offset(x:-150,y:-230)
                            )
                            
                        
                    }
                )
                .offwhitebutton(isTapped: dislike, isToggle: false, cornerRadius: 15, action: $welcomingisTapped)
                .padding(.horizontal)
                .padding(.vertical,10)
                //
               
     
        
        
        
        
        
        
        
        
        
        
    }
    
    var info : some View {
      VStack  {
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
                    
                    
                    
                }
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








