//
//  DynamicTopBar.swift
//  Soul25
//
//  Created by Zablon Charles on 4/21/24.
//

import SwiftUI

struct DynamicTopBar: View {
    var body: some View {
        VStack {
            GeometryReader { proxy in
                
                
                VStack {
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height:40)
                
                
                
                .overlay(
                    VStack(alignment: .trailing, spacing: 8) {
                        HStack {
                            HStack(spacing: 3.0) {
                                
                                
                                
                                Text("Chat")
                                    .font(.title)
                                    .bold()
                                
                                
                                Image(systemName: "bubble.left.and.bubble.right")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                
                                
                                
                                
                                
                                
                            }
                            
                            Spacer()
                            HStack {
                                Image(systemName: "bell")
                                
                                
                                //number of messages
                                Text("23")
                            }.padding(.horizontal,12)
                                .padding(.vertical,5)
                                .background(Color.red.opacity(0.8))
                                .cornerRadius(20)
                            
                        }.padding(.top,10)
                            .padding(.horizontal,8)
                        
                        
                        
                        
                        
                        
                        
                        
                        Divider()
                            .foregroundColor(.secondary)
                            .opacity(0.9)
                        
                        
                            .accessibilityElement(children: .combine)
                    }
                    
                        .background(
                            Rectangle()
                                .fill(Color("offWhite"))
                                
                        )
                    
                    
                    
                        .padding(10)
                )
            }
        }
    }
}

struct DynamicTopBar_Previews: PreviewProvider {
    static var previews: some View {
        DynamicTopBar()
    }
}
