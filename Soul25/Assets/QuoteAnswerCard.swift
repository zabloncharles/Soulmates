//
//  QuoteAnswerCard.swift
//  Soul25
//
//  Created by Zablon Charles on 4/15/24.
//

import SwiftUI

struct QuoteAnswerCard: View {
    var name : String = "name"
    var day : String = "2d"
    var caption : String = "\"I like going going out to clubs and studying for my mcat lol.\""
    var question : String = "What do you like to do for fun?"
    var body: some View {
        VStack(alignment: .leading, spacing: 15.0){
            
            HStack {
                
                
                
                
                HStack {
                    HStack(spacing:4) {
                        Text(name)
                            .bold()
                            .font(.subheadline)
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 18, weight: .medium))
                    }
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
            
            
            //                        the prompt
            HStack {
                VStack{
                    Spacer()
                }.frame(width: 1, height: .infinity)
                   
                HStack {
                    Spacer()
                    Text(question)
                        .bold()
                        .font(.callout)
                        .multilineTextAlignment(.trailing)
                        .lineLimit(3)
                    
                    
                }.padding(20)
                
                    .cornerRadius(12)
                    .padding(.leading,20)
            }
            
            
        }.foregroundColor(Color("black"))
    }
}

struct QuoteAnswerCard_Previews: PreviewProvider {
    static var previews: some View {
        QuoteAnswerCard()
    }
}
