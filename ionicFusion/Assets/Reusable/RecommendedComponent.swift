//
//  RecommendedComponent.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 2/24/22.
//

import SwiftUI
struct RecommendedComponent: View {
    var recommended: ExploreDetailModel
    @State var customfont = "sanfrancisco"
    @State var tapped = false
    @State private var notificationPosition = CGSize.zero
    @State var colorvar = ([Color.blue, Color.white, Color.red])
    
    var body: some View {
          ZStack {
            VStack {
                    ZStack {
                        Image(recommended.background)
                            .resizable(resizingMode: .stretch)
                                .aspectRatio(contentMode: .fill)
                            
                        
                        VStack {
                            Text(recommended.subtitle)
                                .customfontFunc(customFont: "Davinci", style: .body)
                                .foregroundColor(.offWhite)
                          
                            GradientText(text: recommended.title, gradient: colorvar)
                                .customfontFunc(customFont: customfont, style: .body)
                                
                        }.frame(width: 140)
                            .multilineTextAlignment(.center)
                        
                       
                    }
                
                
            }.frame(width: 160, height: 222)
                  .newoffwhite(offwhiteisTapped: tapped, cornerradius: 18)
                  .padding(.bottom,5)
                  .overlay(
                    VStack {
                        HStack {
                            Spacer()
                            HStack(spacing: 1.0) {
                                Image(systemName: "eye")
                                Text("\(recommended.index)")
                            }.font(.caption)
                                .foregroundColor(.gray)
                        }.padding(10)
                        Spacer()
                    }
                  )
            
        }
    }
}

struct RecommendedComponent_Previews: PreviewProvider {
    static var previews: some View {
        //  ReaderComponent(course: courses[0])
        ViewController()
    }
}
