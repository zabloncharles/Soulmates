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
    @Binding var userScrolledAmount : CGFloat 
    var label = "label"
    var labelicon = ""
    var trailinglabel = ""
    var trailingicon = ""
    @Binding var action : Bool
    @State var showSearch = false
    
    
    @State var tappedAvatar = false
    
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
                            
                                HStack {
                                    if !trailingicon.isEmpty {
                                        Image(systemName: trailingicon)
                                            .font(!trailinglabel.isEmpty ? nil : .title)
                                    }
                                    //number of messages
                                    if !trailinglabel.isEmpty {
                                        Text(trailinglabel)
                                    }
                                }.padding(.horizontal,8)
                                    .padding(.vertical,8)
                                    .background(Color.red.opacity(!trailinglabel.isEmpty ? 0.80 : 0))
                              
                                .neoButtonOff(isToggle: false, cornerRadius: 62, perform: {
                                    withAnimation(.spring()){
                                        action.toggle()
                                    }
                                })
                            
                            
                        }.padding(.top,5)
                            .padding(.horizontal,19)
                            .padding(.bottom,10)
                            .background(Color("offwhiteneo"))
                            .offset(y: userScrolledAmount > -33 ?  -120 : 0)

                    
                    
                  
                Spacer()
            }
            
        
       
          
        
        
    }
    
    
    
}

//struct NavigationBar_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationBar(action: .constant(false))
//            .preferredColorScheme(.dark)
//    }
//}
