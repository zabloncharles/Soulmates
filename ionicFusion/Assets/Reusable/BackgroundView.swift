//
//  BackgroundView.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 3/14/22.
//

import SwiftUI


struct BackgroundView: View {
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color("linearoff"), Color("background"), Color("background"),Color("background"), Color("linearoff")]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
