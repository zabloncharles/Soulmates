//
//  GoodReadComponent.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 2/24/22.
//


import SwiftUI
struct TopicComponent: View {
    var course: ExploreDetailModel
    @State var customfont = "sanfrancisco"
    @State var tapped = false
    @State private var notificationPosition = CGSize.zero
    @State var colorvar = ([Color.orange, Color.white, Color.red])
    
    var body: some View {
        ZStack {
            VStack {
                
                
                HStack(spacing: 40){
                   
                  
                    Text(course.subtitle.uppercased())
                            .customfontFunc(customFont: customfont, style: .caption1)
                            .foregroundColor(.white)
                            .lineLimit(1)
                        
                    GradientText(text: course.title, gradient: colorvar)
                        .customfontFunc(customFont: customfont, style: .caption1)
                  
                }.opacity(1)
                    .padding()
                    .background(
                       
                        Image(course.background)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .background(Color.offWhite)
                           
                    )
                    .cornerRadius(12)
             
            }
                .newoffwhite(offwhiteisTapped: tapped, cornerradius: 13)
                
            
        }
    }
}

struct TopicComponent_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
    }
}
