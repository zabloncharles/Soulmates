//
//  MessageBubble.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 3/20/22.
//

import SwiftUI

struct MessageBubble: View {
    

    var section: MessagesModel
    @State var messageTapped = false
    var message = "You still tryna go"
    var messageTime = "2:30 PM"
    var body: some View {
     
        if section.response {
            
            HStack {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 100, height: 20)
                Spacer()
                VStack(alignment: .trailing, spacing: 2.0) {
                    Text(section.message)
                        .font(.subheadline)
                        .padding(.horizontal, 11.0)
                        .padding(.vertical, 9.0)
                        .background(Color.gray)
                        .cornerRadius(9)
                        .padding(.bottom,9)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                messageTapped.toggle()
                            }
                        }
                    
                    
                    Text(section.time)
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 3.0)
                }
                .padding(.horizontal)
                .multilineTextAlignment(.leading)
            }
        } else {
          
            HStack {
                
                VStack(alignment: .leading, spacing: 2.0) {
                    Text(section.message)
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding(.horizontal, 11.0)
                        .padding(.vertical, 9.0)
                        .background(.blue)
                        .cornerRadius(9)
                        .padding(.bottom,9)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                messageTapped.toggle()
                            }
                    }
                    
                    
                    Text(section.time)
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 3.0)
                }
                .padding(.horizontal)
                .multilineTextAlignment(.leading)
                
                
                Spacer()
                
                Rectangle()
                    .fill(.clear)
                    .frame(width: 100, height: 20)
            }
        }
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
      //  MessageBubble()
        ViewController()
           
    }
}


