//
//  LogoLoadingView.swift
//  Soul25
//
//  Created by Zablon Charles on 4/22/24.
//

import SwiftUI

struct LogoLoadingView: View {
    var body: some View {
        ZStack {
            appbackground
            VStack {
                Spacer()
                ShimmerVar(text:"Fumble")
                Spacer()
            }
        }
    }
}

struct LogoLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LogoLoadingView()
    }
}
