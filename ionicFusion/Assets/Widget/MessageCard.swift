//
//  MessageCard.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/19/23.
//



import Foundation
import SwiftUI


struct MessageCard: View {
    var section: MessageUser
    
    @State var isTapped = false
    
    var body: some View {
        VStack {
            
            
            HStack(alignment: .center, spacing: 8) {
                Image("image_05")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                    .frame(width: 49, height: 49)
                    .mask(Circle())
                    .padding(5)
                    .mask(Circle())
                VStack(alignment: .leading, spacing: 4) {
                    
                    
                    // GradientText(text: section.name, gradient: [.black, .blue])
                    Text(section.name.capitalized)
                        .customfontFunc(customFont: "sanfrancisco", style: .headline)
                        .foregroundColor(Color("black"))
                    
                    Text("hey hogn")
                        .customfontFunc(customFont: "sanfrancisco", style: .caption1)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                    
                }
                Spacer()
                HStack {
                    Text("03:23 PM")
                        .font(.caption)
                        .foregroundColor(.gray )
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.gray )
                    
                }
                
                
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            
        }
        // .offwhiteCard(isToggle: false, cornerRadius: 10, action: $isTapped)
        
        
    }
    func formatDate(time:String) -> String{
        
        let dateFormatter = DateFormatter()
        // dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timedate = dateFormatter.date(from: time) ?? Date()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: timedate)
        
    }
    
    
    
}
struct MessageCard_Previews: PreviewProvider {
    
    
    static var previews: some View {
        ViewController()
        
    }
}

