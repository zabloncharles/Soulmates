//
//  ReportCard.swift
//  Soul25
//
//  Created by Zablon Charles on 4/17/24.
//

import SwiftUI

struct ReportCard: View {
    var scrolled = 0;
    var options = ["Report","Information"]
    @Binding var report : Bool
    @Binding var appeared : Bool
    var body: some View {
        VStack{
            Spacer()
            ForEach(options, id: \.self) { item in
                HStack {
                    Image(systemName: "shield.slash")
                        .foregroundColor(.red)
                        .font(.title2)
                    Text(item)
                        .padding(.vertical,20)
                    
                    
                }.frame(width: 380)
                    .background(!report ? Color("offwhite") : Color("offwhiteneo"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color("black").opacity(0.20), lineWidth: 1)
                        
                    )
                .cornerRadius(12)
                .onTapGesture {
                    withAnimation {
                        report = false
                    }
                }
            }
                
            
            
        }.background(Color.black.opacity(0.001))
            .onChange(of: scrolled, perform: { scrolled in
                withAnimation {
                    report = false
                }
            })
            .transition(.offset(y:UIScreen.main.bounds.height))
        
            .onTapGesture {
                if report {
                    withAnimation {
                        report = false
                    }
                }
            }
            .onAppear{
                withAnimation {
                    appeared = true
                }
            }
            .onDisappear{
                withAnimation {
                    appeared = false
                }
            }
    }
}


