//
//  PreferenceInfoCard.swift
//  Soul25
//
//  Created by Zablon Charles on 4/20/24.
//

import SwiftUI

struct PreferenceInfoCard: View {
    var label = "I'm Interested in"
    var sublabel = "Women"
    
 

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 3.0) {
                    Text(label)
                        .foregroundColor(Color("black"))
                    Text(sublabel)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                Image(systemName:"arrow.right")
                    .foregroundColor(.gray)
            }.background(Color("white").opacity(0.02))
            Divider()
        }
    
    }
}

struct PreferenceInfoCard_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceInfoCard()
    }
}
