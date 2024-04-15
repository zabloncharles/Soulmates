//
//  QuotePillsCard.swift
//  Soul25
//
//  Created by Zablon Charles on 4/15/24.
//

import SwiftUI

struct QuotePillsCard: View {
    var name : String = "name"
    var day : String = "2d"
    var caption : String = "\"Fun loving and looking to settle up with this stuff and do me. its really not like that said no one ever.\""
    var pills = userStruct[0]
    var body: some View {
        VStack(alignment: .leading, spacing: 15.0){
            
            HStack {
                
                
                
                
                HStack {
                    Text(name)
                        .bold()
                        .font(.subheadline)
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 18, weight: .medium))
                    Text(day)
                    
                        .font(.callout)
                    
                    Spacer()
                    Image(systemName: "ellipsis")
                }.padding(.trailing,10)
                Spacer()
            }
            Text(caption)
            
                .font(.callout)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
                .padding(.trailing,10)
            
            
            
            HStack {
                ForEach(pills.likes, id: \.self) { like in
                    LikesPill(placeholder: like)
                    
                }
                
                
            }
        }.foregroundColor(Color("black"))
    }
}

struct QuotePillsCard_Previews: PreviewProvider {
    static var previews: some View {
        QuotePillsCard()
    }
}
