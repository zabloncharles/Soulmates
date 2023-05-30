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
//    @AppStorage("currentclickedprof") var sectionData : UserStruct = []
    @State var section : UserStruct = fakeUser
    var namespace: Namespace.ID
    @State var dislike = false
    @State var welcomingisTapped = false
    let completion: () -> Void
    
    
    
    
    var body: some View {
     
            info
            
                .padding(.all, 20.0)
            
            
                .frame(width: 400,height:  500)
                .background(
                    
                    ZStack{
                        Image("image_02")
                            .resizable(resizingMode: .stretch)
                            .aspectRatio(contentMode: .fill)
                          //  .matchedGeometryEffect(id: "\(section.background)", in: namespace)
                        
                        Image("image_02")
                            .resizable(resizingMode: .stretch)
                            .aspectRatio(contentMode: .fill)
                            .blur(radius: 5)
                         //   .matchedGeometryEffect(id: "\(section.background)", in: namespace)
                        
                            .mask(LinearGradient(gradient: Gradient(colors: [.clear, .clear, .black,.black]), startPoint: .top, endPoint: .bottom))
                            .overlay(
                                VStack {
                                    HStack {
                                        Image(systemName: "person.and.background.dotted")
                                        Text("\(section.age)" )
                                    }
                                } .padding(.horizontal,10)
                                    .padding(.vertical,4)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(6)
                                    .offset(x:-150,y:-230)
                            )
                            
                        
                    }
                )
                .background(Color.gray)
                .cornerRadius(20)
                .padding(.horizontal,20)
                .padding(.vertical)
                .neoButton(isToggle: false) {
                    //
                    completion()
                }
              
              
    }
    
    var info : some View {
      VStack  {
            Spacer()
            
            
            VStack(spacing: 2) {
                
                HStack{
                    VStack(alignment: .leading,spacing: 0) {
                        HStack(alignment: .center) {
                            Text(section.firstname + " " + section.lastname)
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
                                .foregroundColor(!section.online ? .red : .green)
                            
                            Text(!section.online ?  "Offline" : "Online now")
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
                        
                        
                        Text(section.location[0])
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                        
                    }.foregroundColor(.secondary)
                    Text(section.aboutme)
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
                    //Image(section.avatar)
                    ImageViewer(url: section.avatar)
                       // .resizable(resizingMode: .stretch)
                      //  .aspectRatio(contentMode: .fill)
                        .frame(width: 90.0, height: 90.0)
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








