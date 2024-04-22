//
//  QuoteImageCard.swift
//  Soul25
//
//  Created by Zablon Charles on 4/15/24.
//

import SwiftUI

struct QuoteImageCard: View {
    var name : String = "name"
    var day : String = "2d"
    var caption : String = "this is how i like to unwind"
    var url : String = ""
    @Binding var urlReturned : String
    @Binding var loaded : Bool
    @Binding var report : Bool
    var body: some View {
        VStack {
            VStack {
                HStack {
                    HStack(spacing:4) {
                        Text(name)
                            .bold()
                            .font(.subheadline)
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 18, weight: .medium))
                    }
                    
                    Text("2d")
                        .font(.callout)
                    Spacer()
                    Image(systemName: "ellipsis")
                        .onTapGesture {
                            withAnimation(.spring()){
                                report = true
                            }
                        }
                }.padding(.trailing,20)
                Spacer()
                
                HStack {
                    VStack {
                        Image(systemName: "quote.opening")
                            .font(.system(size: 18, weight: .medium))
                        
                    }
                    Text(caption)
                        .font(.callout)
                        .italic()
                    
                    Spacer()
                }.padding(.trailing,10)
            }
            .padding(.leading,20)
            .padding(.vertical)
            
            
            .padding(.top,-10)
            
            
            GetImageAndUrl(url:url, width: UIScreen.main.bounds.width , height: 400, loaded: $loaded, imageUrl: $urlReturned)
                .frame(width:UIScreen.main.bounds.width, height: 400)
                .cornerRadius(0)
                
               
            
            
            
        }
    }
}

//struct QuoteImageCard_Previews: PreviewProvider {
//    static var previews: some View {
//        QuoteImageCard()
//    }
//}
