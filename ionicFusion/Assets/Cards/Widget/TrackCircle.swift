//
//  TrackCircle.swift
//  Fusion
//
//  Created by Zablon Charles on 2/21/22.
//

import SwiftUI


struct TrackCircle: View {
    
    @State var appear = false
    var background : String = "image_03"
    var value: String = ""
    var name : String =  "Period"
    var percent : Double = 0.90
    @State var appeared = false
    @State var trackcircleappeared = false
    @State var tapped = false
    @State var colors = [Color.red,Color.blue,Color.green]
    
    
    var body: some View {
        
        VStack { //Circle
            VStack(spacing:21){
                ringimage
                    .overlay(
                        valueinsidecircle
                        
                    )
                    .scaleEffect(tapped ? 0.97 : 1)
                    .background(
                        progressring
                    )
                
            }
            
            
            .onTapGesture {
                withAnimation(.spring()) {
                    tapped.toggle()
                }
            }
           // nameundercircle
            
        }
        
    }
    var ringimage: some View {
        VStack {
            Image(background)
                
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fill)
                .padding(trackcircleappeared && !tapped ? 0 : tapped ? -15 : -20)
            
                .animation(.easeIn(duration: 4), value: trackcircleappeared)
                .clipShape(
                    Circle()
                    
                )
                .frame(width: 80, height: 80)
            
        }
    }
    var progressring: some View {
        VStack {
            Circle() // the blue dial
            
                .trim(from: 0, to: appear ? percent : 0)
            
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
                .fill(
                    LinearGradient(gradient: Gradient(colors: colors), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                
            
                .rotationEffect(.degrees(272))
                .onAppear {
                    withAnimation(.spring().delay(0.5)) {
                        appear = true
                    }
                }
                .onDisappear {
                    appear = false
                }
                .padding(-5.0)
                .scaleEffect(tapped ? 1.059 : 1)
                .neumorphiccircle(padding: -9.3, opacity: tapped ? 1 : 0)
        }
    }
    var valueinsidecircle: some View {
        VStack {
            
            //The value inside the circle
            Text(value.lowercased())
                .foregroundColor(.clear)
                .font(.callout)
                .lineLimit(1)
                .multilineTextAlignment(.center)
                
                .background(
                    LinearGradient(gradient: Gradient(colors: colors), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                        .mask(
                            Text(value.lowercased())
                                .font(.callout)
                                .lineLimit(1)
                                .multilineTextAlignment(.center)
                        )
                )
               
        }
            .opacity(trackcircleappeared ? 1 : 0)
            .animation(.easeIn(duration: 5), value: trackcircleappeared)
            .onAppear{
                trackcircleappeared = true
            }
            .onDisappear{
                trackcircleappeared = false
            }
    }
    var offwhiteeffect: some View {
        Circle()
            .fill(Color.offWhite)
            .shadow(color:  Color("black").opacity(appear ? 0.2 : 0), radius: 10, x: 10, y: 10)
            .shadow(color: Color("white").opacity(appear ? 0.7 : 0), radius: 10, x: -5, y: -5)
            .padding(-1)
    }
    var nameundercircle: some View {
        VStack {
            Text(name)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.vertical, 4)
                .padding(.horizontal, 13)
                .padding(.top, 9)
        }
    }
}


struct TrackCircle_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
            .preferredColorScheme(.dark)
    }
}
