//
//  SettingsMenuItems.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 2/17/22.
//

import SwiftUI

struct settingsMenuItems: View {
    var text = "edit"
    var icon = "person"
    var itemTapped = false
  
    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(text)
                .lineLimit(1)
           
        }.foregroundColor(Color("white"))
            .padding(.horizontal,18)
            .padding(.vertical, 7)
            .background(itemTapped ? .pink : (Color("black").opacity(0.99)))
            .cornerRadius(13)
            .scaleEffect(itemTapped ? 0.9 : 1)
            .animation(.spring(), value: itemTapped)
        
    }
  
}
