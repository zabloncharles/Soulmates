//
//  NavigationBar.swift
//  iOS15
//
//  Created by Meng To on 2021-07-16.
//

import SwiftUI

struct NavigationBar: View {
    @AppStorage("hidemainTab") var hidemainTab = false
    @AppStorage("currentPage") var selected = 0
    @Binding var userScrolledAmount : Bool
    var label = "label"
    var labelicon = ""
    var trailinglabel = ""
    var trailingicon = ""
    var notification = false
    @State var showSearch = false
    @State var appeared = false
    
    
    @State var tappedAvatar = false
    let completion: () -> Void
    
    var body: some View {
       
     
            VStack {
                        HStack {
                            HStack(spacing: 3.0) {
                                
                                
                                
                                Text(label)
                                    .font(.title)
                                    .bold()
                                  
                                
                                
                                if !labelicon.isEmpty {
                                    Image(systemName: labelicon)
                                        .font(.title3)
                                    .fontWeight(.bold)
                                }
                            }
                            
                            Spacer()
                            
                            if notification {
                                Text(trailinglabel)
                                    .font(.title3)
                                    .padding(5)
                                    .background(Circle()
                                        .fill(.red.opacity(0.76))
                                                
                                        .padding(-1))
                            }
                            
                            else  {
                                HStack {
                                        if !trailingicon.isEmpty {
                                            Image(systemName: trailingicon)
                                                .font(!trailinglabel.isEmpty ? nil : .title)
                                                .foregroundColor(.red)
                                                .bold()
                                        }
                                        //number of messages
                                        if !trailinglabel.isEmpty {
                                            Text(trailinglabel)
                                        }
                                    }.padding(.horizontal,8)
                                        .padding(.vertical,8)
                                        .background(Color.red.opacity(!trailinglabel.isEmpty ? 0.80 : 0))
                                  
                                    .neoButton(isToggle: false, perform: {
                                        withAnimation(.spring()){
                                            completion()
                                            appeared = false
                                        }
                                })
                            }
                            
                            
                        }.padding(.top,5)
                            .padding(.horizontal,19)
                            .padding(.bottom,5)
                            .background(Color("offwhiteneo"))
                            .offset(y: userScrolledAmount ?  -120 : !appeared ? -120 : 0)
                            .opacity(userScrolledAmount ? 0 : 1)
                    
                    
                    
                  
                Spacer()
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.spring()) {
                        appeared = true
                    }
                }
            }
        
    }
    
}
