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
    @Environment(\.colorScheme) var colorScheme
    var titlee = ""
    @Namespace var namespace
    @State var title = ""
    @State var showSearch = false
    @Binding var contentHasScrolled: Bool
    @AppStorage("showAccount") var showAccount = false
    @AppStorage("signIn") var signIn = false
    @AppStorage("notifications") var showNotifications = false
    @AppStorage("editcalendar") var showEditCalendar = false
    @State var tappedAvatar = false
    
    var body: some View {
       
            ZStack {
                Rectangle()
                    .fill(colorScheme == .dark ? Color.black : Color("offwhite"))
                    .frame(maxWidth: .infinity)
                    .frame(height: selected == 1 || selected == 2 ? 180 : 140)
                    .offset(y: selected == 1 || selected == 2  ? -20 : -50)
                    .ignoresSafeArea()
                    .frame(maxHeight: .infinity, alignment: .top)
                    .blur(radius: 1)
                    .opacity(contentHasScrolled ? 1 : 0)
                
                VStack{
                    HStack{
                        VStack {
                      
                            Text("\(title)")
                                .font(.custom("MrDafoe-Regular", size: contentHasScrolled ? 30 : 42))
                                .foregroundStyle(.primary)
                                
                                .padding(.horizontal,15)
                                .offset(y: contentHasScrolled ? 9 : 0)
                               
                          
                        }
                        .onTapGesture {
                            hidemainTab = false
                        }
                        
                       
                        Spacer()
                        HStack() {
                           
                          
                            bell
                          
                            

                            
                            avatar
                            
                            
                        }
                     
                        
                      
                    }
                    .padding(.horizontal)
                    .frame(maxHeight: .infinity, alignment: .top)
                }
                .padding(.horizontal, contentHasScrolled ? 3 : 0)
            }
            .navigationBarHidden(true)
            .offset(y: contentHasScrolled ? -16 : 0)
            .onAppear{
                contentHasScrolled = false
            }
        
        
    }
    
    var bell : some View {
        VStack {
            Image(systemName: selected == 3 ? "calendar.badge.plus" : "bell.fill")
                .font(.system(size: selected == 3 ? 24 : 17, weight: .bold))
                .frame(width: 36, height: 36)
                .foregroundColor(showEditCalendar ? .red : .secondary)
                .background(selected == 3 ? Color.black.opacity(0) : Color("offwhite"))
                
                .scaleEffect(showEditCalendar ? 0.97 : 1)
                .overlay(
                    VStack{
                    if selected != 3 {
                    Text("4")
                        .foregroundColor(.white)
                        .font(.caption)
                        .padding(2)
                        .background(
                            Circle()
                            
                                .fill(.red)
                                .padding(-3)
                        )
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    }
                    }
                )
                .onTapGesture {
                    if selected == 3 {
                        showEditCalendar = true
                 
                    } else {
                        showNotifications = true
                    }
            }
        }
    }
    
    @ViewBuilder
    var avatar: some View {
       
            Avatar()
            .frame(width: 30, height: 30)
            
            .cornerRadius(30)
            .background(
                Circle()
                    .fill(Color("offWhite"))
                    .shadow( color: Color.black.opacity(0.2), radius: 10, x: tappedAvatar ? -5 : 10, y:tappedAvatar ?  -5 : 10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x:tappedAvatar ?  10 : -5, y: tappedAvatar ? 10 : -5)
                
                    .transition(.scale.combined(with: .opacity))
                    .padding(-2)
            ).scaleEffect(tappedAvatar ? 0.97 : 1)
                .transition(.scale.combined(with: .slide))
                .onTapGesture {
                    showAccount = true
                    withAnimation(.spring()){
                        tappedAvatar = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        withAnimation(.spring()){
                            tappedAvatar = false
                        }
                    }
                }
       
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        //        NavigationBar(contentHasScrolled: .constant(false))
        //            .preferredColorScheme(.dark)
        //            .environmentObject(Model())
        ViewController()
            .preferredColorScheme(.dark)
    }
}
