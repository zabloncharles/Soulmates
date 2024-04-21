//
//  ExploreMenuRow.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/27/23.
//

import SwiftUI

struct TypeofMenuRow:  View {
    @Binding var tap : Int
    var selected = 0
    var placeholder = "name?"
    let completion: () -> Void
    
    
    var body: some View {
        VStack {
            ZStack {
                if tap == selected  {
                    VStack {
                        Text(placeholder)
                            .font(.footnote)
                            .padding(.vertical,5)
                            .padding(.horizontal,8)
                            .foregroundColor(.red)
//                            .background(Color("offwhite"))
                            .cornerRadius(10)
                        
                        
                    }
                }
                
                else {
                    Text(placeholder)
                        .font(.footnote)
                        .padding(.vertical,5)
                        .padding(.horizontal,8)
                    
                    
                }
            }
            .onTapGesture {
                completion()
                
                withAnimation(.spring()){
                    tap = selected
                }
            }
            
            
            
            
        }
        
        
    }
    
}
