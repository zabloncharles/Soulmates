//
//  SmallMatchActive.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/23/23.
//

import SwiftUI


struct SmallMatchActive_Previews: PreviewProvider {
    static var previews: some View {
       // SmallMatchActive()
        ViewController()
    }
}


struct SmallMatchActive: View {
    @Binding var matchcard : MatchCardData
    @Binding var showprof : Bool
    var section : MatchCardData
    var namespace: Namespace.ID
    @State var dislike = false
    @State var welcomingisTapped = false
    
    
    
    
    
    var body: some View {
        
        VStack {
               
                    Spacer()
                    HStack {
                        VStack(alignment: .leading) {
                            HStack(spacing: 3.0) {
                                Text(section.name)
                                    .lineLimit(1)
                                    .foregroundColor(.white)
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(.blue)
                            }
                            HStack(spacing: 3.0) {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(.green)
                                    .font(.caption2)
                                Text("5 minutes ago")
                                    .font(.footnote)
                                    .foregroundColor(Color.gray)
                                .lineLimit(1)
                            }
                        }
                        Spacer()
                        Image(section.profilepic)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .cornerRadius(60)
                    }.padding(6)
                        .background(.ultraThinMaterial.opacity(0.5))
                        .cornerRadius(13)
                        .padding(.horizontal,5)
                        .padding(.vertical,5)
                        
              
                
                
              
               
        }.background(
            Image(section.background)
                .resizable()
                .matchedGeometryEffect(id: "som\(section.usernumber)", in: namespace)
        )
            .offwhitebutton(isTapped: dislike, isToggle: false, cornerRadius: 10, action: $welcomingisTapped)
            
            .padding(.horizontal)
            .background(VStack {
                if welcomingisTapped {
                    Color.clear
                        .onAppear{
                            matchcard = section
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                showprof = true
                                welcomingisTapped = false
                            }
                    }
                }
            }.opacity(0))
            
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
}







