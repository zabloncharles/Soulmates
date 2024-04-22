//
//  DynamicTopBar.swift
//  Soul25
//
//  Created by Zablon Charles on 4/21/24.
//

import SwiftUI

struct DynamicTopBar: View {
    var label : String
    var labelicon : String
    var trailinglabel = ""
    var trailinglabelicon = ""
    var notification = false
    let completion: () -> Void
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
                                
                                Text(label)
                                    .font(.title)
                                    .bold()
                                
                                
                                Image(systemName: labelicon)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                
                            }
                            
                            Spacer()
                            
                            if notification {
                                Text(trailinglabel)
                                    .padding(5)
                                    .background(Circle()
                                        .fill(.red)
                                                
                                    .padding(-2))
                                    .neoButton(isToggle: false) {
                                        withAnimation(.spring()) {
                                            completion()
                                        }
                                    }
                            } else {
                                
                                HStack {
                                    
                                    Image(systemName: trailinglabelicon)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.red)
                                    //number of messages
                                    if  !trailinglabel.isEmpty {
                                        Text(trailinglabel)
                                    }
                                }.padding(.horizontal,12)
                                    .padding(.vertical,5)
                                    .background(Color.red.opacity(!trailinglabelicon.isEmpty ? trailinglabel.isEmpty && !trailinglabelicon.isEmpty ? 0 : 0.8 : 0))
                                    .cornerRadius(20)
                                    .neoButton(isToggle: false) {
                                        withAnimation(.spring()) {
                                            completion()
                                        }
                                    }
                                
                            }
                            
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


