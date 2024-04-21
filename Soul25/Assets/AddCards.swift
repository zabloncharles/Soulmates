//
//  AddCards.swift
//  Soul25
//
//  Created by Zablon Charles on 4/18/24.
//

import SwiftUI

struct AddCards: View {
    var icon = "plus"
    var caption = "Add a prompt"
    var body: some View {
        VStack{
            Image(systemName: icon)
                .foregroundColor(.blue)
                .font(.system(size: 18, weight: .medium))
            Text(caption)
                .font(.callout)
            
            Text("Add a " + caption)
                .font(.caption)
                .multilineTextAlignment(.leading)
            
        }.frame(width: 120, height: 130)
            .background(Color("offwhiteneo"))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("black"), lineWidth: 1)
                
            )
            .cornerRadius(12)
            
    }
}

struct AddCards_Previews: PreviewProvider {
    static var previews: some View {
        AddCards()
    }
}
