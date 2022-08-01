//
//  ListRow.swift
//  ListRow
//
//  Created by Meng To on 2021-08-05.
//

import SwiftUI

struct Trending: View {
    var title = "iOS Development"
    var icon = "iphone"
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .frame(width: 36, height: 36)
                .background(.ultraThinMaterial)
                .mask(Circle())
                .backgroundStyle(cornerRadius: 18)
            Text(title)
               
            Spacer()
        }
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
    }
}

struct ListRow: View {
    var title = "iOS Development"
    var subtitle = ""
    var icon = "iphone"
    @State var animate = false
    var tapped = false
    
    var body: some View {
        ZStack {
            VStack {
                
                
                VStack(spacing: 80){
                    Spacer()
                    Text("hey how are you")
                    Spacer()
                }.opacity(0)
                    .overlay(   LazyVStack {
                        Text(subtitle)
                            .customfontFunc(customFont: "Davinci", style: .footnote)
                            .foregroundColor(.offWhite)
                          
                        GradientText(text: title, gradient: [.blue,.red])
                            .customfontFunc(customFont: "sanfrancisco", style: .body)
                        
                    }.multilineTextAlignment(.center))
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [ .clear, .clear, .clear, .clear]), startPoint: .top, endPoint: .bottom)
                    
                    )
                    .background(
                        Image("image_10")
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
                                                Text("234")
                                              
                                            }.font(.caption)
                                                .foregroundColor(Color("black").opacity(0.70))
                                                .padding(4)
                                                .offset(x: -46)
                                        )
                                }
                            )
                            
                            
                    )
                   
                
                
            }
            .scaleEffect(tapped ? 0.99 : 1.03 )
            .newoffwhite(offwhiteisTapped: false, cornerradius: 15)
            .animation(.spring(), value: tapped)
           
            .padding(.bottom, 4)
        }
        .onAppear{
            withAnimation(.easeInOut(duration: 0.5)) {
                animate = true
            }
        }
        .onDisappear{
            withAnimation(.easeInOut(duration: 0.5)) {
                animate = false
            }
        }
    }
}
