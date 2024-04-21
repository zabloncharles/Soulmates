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
    var option = 0
    @Binding var tapped : Bool
    @Binding var optionType : Int

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
                    .foregroundColor(tapped ? .blue : .gray)
            }.background(Color("white").opacity(0.02))
            Divider()
        }.neoButton(isToggle: false) {
            withAnimation(.spring()){
                tapped = true
                optionType = option
            }
        }
    }
}

struct PreferenceInfoCard_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceInfoCard(tapped: .constant(false), optionType: .constant(0))
    }
}
