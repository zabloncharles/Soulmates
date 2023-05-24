//
//  LikesPill.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/24/23.
//

import SwiftUI

struct LikesPill: View {
    var placeholder: String = "hmm"
    @State var icon = ""
    @State var colors = Color(hue: 1.0, saturation: 0.348, brightness: 0.929)
    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(placeholder)
              
        }  .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .background(RandomColorView().opacity(0.5))
            .cornerRadius(15)
            .onAppear{
                if placeholder ==  "singing" {
                    colors = Color(hue: 0.975, saturation: 0.635, brightness: 0.937)
                    icon = "music.quarternote.3"
                }
                else if placeholder == "hiking" {
                    colors = Color(hue: 0.76, saturation: 0.163, brightness: 0.717)
                    icon = "figure.hiking"
                }
                
                else  if placeholder == "dancing" {
                    colors = Color(hue: 1.0, saturation: 0.348, brightness: 0.929)
                    icon = "figure.dance"
                }
                else  if placeholder == "hyper" {
                    colors = Color(hue: 1.0, saturation: 0.348, brightness: 0.929)
                    icon = "figure.gymnastics"
                }
                else  if placeholder == "talkative" {
                    colors = Color(hue: 1.0, saturation: 0.348, brightness: 0.929)
                    icon = "mouth"
                }
                else  {
                    colors = Color(hue: 1.0, saturation: 0.348, brightness: 0.929)
                    icon = "figure.stand"
                }
                
            }
    }
}

struct LikesPill_Previews: PreviewProvider {
    static var previews: some View {
        LikesPill()
    }
}

struct RandomColorView: View {
    var body: some View {
        let randomColor = Color(
            red: Double.random(in: 0.1...1),
            green: Double.random(in: 0.1...1),
            blue: Double.random(in: 0.1...1)
        )
        
        return randomColor
            .frame(width: 200, height: 200)
            .cornerRadius(10)
    }
}
