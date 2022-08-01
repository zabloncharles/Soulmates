//
//  BackButton.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 3/24/22.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode
    var contentHasScrolled = false
    var body: some View {
        VStack{
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    
                    HStack(spacing:2){
                        Image(systemName: "chevron.left")
                        Text("Back")
                        
                    }
                }
                Spacer()
            }.padding(.horizontal, 20)
                .background(
                    Rectangle()
                    
                        .fill(Color("white"))
                        .frame(width: .infinity, height: 94)
                        .offset(y: -25)
                        .opacity(contentHasScrolled ? 1 : 0)
                    
                )
            
            
            Spacer()
        }
      
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}
