//
//  BackgroundView.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 3/14/22.
//

import SwiftUI


struct BackgroundView: View {
    
    var body: some View {
       // LinearGradient(gradient: Gradient(colors: [Color("linearoff"), Color("background"), Color("background"),Color("background"), Color("linearoff")]), startPoint: .top, endPoint: .bottom)
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("coloroffneo"),Color("offwhiteneo"), Color("offwhiteneo")]), startPoint: .top, endPoint: .bottom)
            VStack {
                Image("cover9")
                    .resizable()
                    .offset(x: -14, y: -340)
                    .blur(radius: 68)
                
                
                                    
            }
        }.edgesIgnoringSafeArea(.all)

    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
