//
//  SuccessView.swift
//  DesignCode
//
//  Created by Meng To on 2020-04-01.
//  Copyright © 2020 Meng To. All rights reserved.
//

import SwiftUI

struct SuccessView: View {
    @State var show = false
    @State var textt: String = ""
    @State var togglee = false
    var body: some View {
        VStack {
   
            
            LottieView(filename: "error1")
               
                .opacity(show ? 1 : 0)
                .animation(.linear(duration: 0.5))
                .scaleEffect(show ? 1.2 : 0.5)
           
            Text(textt).animation(.spring())
            
            .onChange(of: togglee) { toggle in
               if toggle {
                 textt = ""
                 "You forgot your name".enumerated().forEach { index, character in
                   DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) {
                     textt += String(character)
                   }
                 }
               }
             }
        }
        .frame(width: 300, height: show ? 250 : 0)
        .padding(20)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 30, x: 0, y: 30)
        .scaleEffect(show ? 1 : 0.5)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .onAppear {
            self.show = true
            self.togglee = true
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(show ? 0.5 : 0))
        .edgesIgnoringSafeArea(.all)
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
            .background(.blue)
    }
}
