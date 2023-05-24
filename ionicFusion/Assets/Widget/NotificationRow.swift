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
        VStack {
            
            
            HStack(alignment: .center, spacing: 8) {
                Image(section.avatar)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 49, height: 49)
                    .mask(Circle())
                    .padding(5)
                    .mask(Circle())
                VStack(alignment: .leading, spacing: 4) {
                    
                    
                    // GradientText(text: section.name, gradient: [.black, .blue])
                    Text(section.name)
                        .customfontFunc(customFont: "sanfrancisco", style: .headline)
                        .foregroundColor(Color("black"))
                    
                    Text(section.message)
                        .customfontFunc(customFont: "sanfrancisco", style: .caption1)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                    
                }
                Spacer()
                HStack {
                    Text("4 Days")
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
}
struct NotificationRow_Previews: PreviewProvider {
    
    
    static var previews: some View {
        ViewController()
        
    }
}

