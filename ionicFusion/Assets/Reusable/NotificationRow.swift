//
//  NotificationRow.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 2/26/22.
//

import Foundation
import SwiftUI


struct NotificationRow: View {
    var section: NotificationModel
    @State var isTapped = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(section.avatar)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 49, height: 49)
                .mask(Circle())
                .padding(5)
                .mask(Circle())
            VStack(alignment: .leading, spacing: 4) {
                Text("\(section.numberofmessages) New Messages")
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)
                
                GradientText(text: section.name, gradient: [.black, .blue])
                    .customfontFunc(customFont: "sanfrancisco", style: .headline)
                
                Text(section.message)
                    .customfontFunc(customFont: "sanfrancisco", style: .caption1)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                
            }
            Spacer()
            Image(systemName: section.numberofmessages > 0 ? "bell.fill" : "bell")
                .font(.caption)
                .foregroundColor(.red )
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
        .newoffwhite(offwhiteisTapped: isTapped, cornerradius: 10)
       
    }
}
struct NotificationRow_Previews: PreviewProvider {
    
    
    static var previews: some View {
        ViewController()
        
    }
}

