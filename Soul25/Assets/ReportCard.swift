//
//  ReportCard.swift
//  Soul25
//
//  Created by Zablon Charles on 4/17/24.
//

import SwiftUI

struct ReportCard: View {
    var scrolled = 0;
    @Binding var report : Bool
    @Binding var appeared : Bool
    var body: some View {
        VStack{
            Spacer()
            HStack {
                Image(systemName: "shield.slash")
                    .foregroundColor(.red)
                    .font(.title2)
                Text("Report")
                    .padding(.vertical,20)
                
                
            }.padding(.horizontal,150)
                .background(!report ? Color("offwhite") : Color("offwhiteneo"))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color("black").opacity(0.20), lineWidth: 1)
                    
                )
                .cornerRadius(12)
            
            
            HStack {
                Image(systemName: "xmark")
                    .foregroundColor(Color("black"))
                    .font(.title3)
                Text("Cancel")
                    .padding(.vertical,20)
                
                
            }.padding(.horizontal,150)
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
            
                .padding(.bottom,50)
            
            
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


