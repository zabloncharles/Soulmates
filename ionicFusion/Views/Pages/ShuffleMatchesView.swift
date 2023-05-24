//
//  ShuffleMatchesView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/23/23.
//

import SwiftUI

struct ShuffleMatchesView: View {
    @State var matchcard = matchCardData[0]
    @Namespace var namespace
    var body: some View {
        VStack{
            FullProfileView(namespace: namespace, matchcard: $matchcard, showProfile: .constant(false))
                .background(
            Image("Blob 1")
                .offset(x: -154, y: -340)
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 58))
        }
    }
}

struct ShuffleMatchesView_Previews: PreviewProvider {
    static var previews: some View {
        ShuffleMatchesView()
    }
}
