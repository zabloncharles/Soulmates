//
//  MessageCard.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/19/23.
//



import Foundation
import SwiftUI


struct MessageCard: View {
    var section: UserStruct
    @Binding var profile : UserStruct
    @Binding var showProfile : Bool
    @Binding var userAvatarLoaded : Bool
    @State var isTapped = false
    @State var whoSent = ["Sent","Received","Seen"]
    
    var body: some View {
        VStack {
            
            
            HStack(alignment: .center, spacing: 8) {
              //  Image(section.avatar)
                  //  .resizable()
                  //  .aspectRatio(contentMode: .fill)
                GetImageAndUrl(url:section.avatar, loaded: $userAvatarLoaded, imageUrl: .constant(""))
                    .frame(width: 49, height: 49)
                    .mask(Circle())
                   
                    .neoButton(isToggle: false) {
                        //user tapped the avatar
                        showProfile = true
                        profile = section
                    }
//                    .onTapGesture {
//                        showProfile = true
//                        profile = section
//                    }
                VStack(alignment: .leading, spacing: 4) {
                    
                    
                    // GradientText(text: section.name, gradient: [.black, .blue])
                    Text(section.firstName)
                        .customfontFunc(customFont: "sanfrancisco", style: .title3)
                        .foregroundColor(Color("black"))
                    
                    Text(whoSent[0])
                        .customfontFunc(customFont: "sanfrancisco", style: .footnote)
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
            
            Divider()
        }
    
        
        
    }
    func formatDate(time:String) -> String{
        
        let dateFormatter = DateFormatter()
        // dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timedate = dateFormatter.date(from: time) ?? Date()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: timedate)
        
    }
    
    
    
}


