//
//  EditPostPopUp.swift
//  Soul25
//
//  Created by Zablon Charles on 4/21/24.
//

import SwiftUI

struct EditPostPopUp: View {
    @AppStorage("hidemainTab") var hidemainTab = false
    @State var appeared = false
    @State var cancel = false
    @Binding var report : Bool
    var body: some View {
        VStack {
            Color("offwhiteneo")
                .opacity(0.0002)
                .onTapGesture {
                    withAnimation(.spring()) {
                        appeared = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            report = false
                        }
                    }
                }
            Spacer()
            VStack {
                VStack {
                    Text("Please don't hesitate to report any inappropriate content you come across.")
                        .foregroundColor(Color("black"))
                        .multilineTextAlignment(.center)
                        .padding(.top,10)
                    Divider()
                    HStack {
                        Spacer()
                        Text("Report")
                            .foregroundColor(.red)
                        Spacer()
                    } .padding(.vertical)
                        .padding(.horizontal)
                    
                        .cornerRadius(12)
                        .padding(.horizontal)
                } .background(Color("offwhite"))
                    .cornerRadius(12)
                    .neoButton(isToggle: false, perform: {
//                        report = true
                        // report the post
                    })
                    .padding()
                    .padding(.bottom,-20)
                
                
                
                HStack {
                    Spacer()
                    Text("Cancel")
                        .foregroundColor(Color("black"))
                    Spacer()
                } .padding(.vertical)
                    .padding(.horizontal)
                    .background(Color("offwhite"))
                    .cornerRadius(12)
                    .neoButton(isToggle: false, perform: {
                        
                        appeared = false
                        
                    })
                    .padding()
                    .padding(.bottom,20)
                
            }
            .offset(y: appeared ? 0 : UIScreen.main.bounds.height)
            .animation(.spring(), value: appeared)
            
            
        }
            
            .onAppear{
                withAnimation(.spring()){
                    appeared = true
                    hidemainTab = true
                }
            }
            .onDisappear{
                withAnimation(.spring()){
                    appeared = false
                    hidemainTab = false
                }
            }
       
    }
}

struct EditPostPopUp_Previews: PreviewProvider {
    static var previews: some View {
        EditPostPopUp( report: .constant(false))
    }
}
