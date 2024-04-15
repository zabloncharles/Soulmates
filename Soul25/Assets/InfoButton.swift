//
//  InfoButton.swift
//  Soul25
//
//  Created by Zablon Charles on 4/15/24.
//

import SwiftUI

struct InfoButton: View {
    var icon : String = "person"
    var label : String = "label"
    
    
    var body: some View {
        HStack(spacing: 3.9){
            Image(systemName: icon)
                .font(.system(size: 18, weight: .medium))
            
            
            Text(label)
                .font(.footnote)
                .fontWeight(.semibold)
                .lineLimit(1)
            
        }.foregroundColor(Color("black"))
            .padding(.horizontal,5)
            .padding(.vertical,4)
            .background(Color("offwhite"))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("black"), lineWidth: 1)
                
            )
            .cornerRadius(8)
            
    }
}

struct InfoButton_Previews: PreviewProvider {
    static var previews: some View {
        InfoButton()
    }
}
