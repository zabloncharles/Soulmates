//
//  SmallCourseItem.swift
//  SmallCourseItem
//
//  Created by Meng To on 2021-08-13.
//

import SwiftUI

struct WallpaperComponent: View {
    var course: Course
    @State var customfont = "sanfrancisco"
    @State var tapped = false
    var body: some View {
        ZStack {
            VStack {
                
                
                VStack(spacing: 80){
                    Spacer()
                    Text("hey how are you")
                    Spacer()
                }.opacity(0)
                    .overlay(   LazyVStack {
                        Text(course.subtitle)
                            .customfontFunc(customFont: "Davinci", style: .footnote)
                            .foregroundColor(.offWhite)
                        
                        GradientText(text: course.title, gradient: [.blue,.red])
                            .customfontFunc(customFont: "sanfrancisco", style: .body)
                        
                    }.multilineTextAlignment(.center))
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [ .clear, .clear, .clear, .clear]), startPoint: .top, endPoint: .bottom)
                        
                    )
                    .background(
                        Image(course.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .overlay(
                                VStack{
                                    Rectangle()
                                        .fill(Color("offwhite"))
                                        .blur(radius: 15)
                                        .offset(y: -20)
                                    Rectangle()
                                        .fill(Color("offwhite"))
                                        .blur(radius: 18)
                                        .offset(y: -50)
                                    Spacer()
                                    Rectangle()
                                        .fill(Color("offwhite"))
                                        .blur(radius: 29)
                                        .offset(y: 70)
                                    Rectangle()
                                        .fill(Color("offwhite"))
                                        .blur(radius: 15)
                                        .offset(y: 20)
                                        .overlay(
                                            HStack(spacing:0){
                                                
                                                Image(systemName: "eye.circle")
                                                Text("\(course.index)")
                                                
                                            }.font(.caption)
                                                .foregroundColor(Color("black").opacity(0.80))
                                                .offset(x: 45)
                                        )
                                }
                            )
                        
                        
                    )
                
                
                
            }
            
            .newoffwhite(offwhiteisTapped: tapped, cornerradius: 15)
            .animation(.spring(), value: tapped)
            .scaleEffect(tapped ? 0.97 : 1 )
        }
    }
}

struct WallpaperComponent_Previews: PreviewProvider {
    static var previews: some View {
      //  ReaderComponent(course: courses[0])
        ViewController()
    }
}


