//
//  Walls.swift
//  Fusion
//
//  Created by Zablon Charles on 2/20/22.
//

import SwiftUI

struct NotificationsDetail: View {
    @AppStorage("wallpaper") var wallpaper = "ob1"
    var namespace: Namespace.ID
    @Binding var notification: NotificationModel
    var isAnimated = true
    @State var viewState: CGSize = .zero
    @State var showSection = false
    @State var appear = [false, false, false]
    @State var selectedSection = messageSections[0]
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
   
 
    
    var body: some View {
        ZStack {
        NavigationView  {
              VStack {
              ScrollView(showsIndicators: false) {
              cover
             
            }
            .coordinateSpace(name: "scroll")
            .background(Color("background"))
            .mask(RoundedRectangle(cornerRadius: appear[0] ? 0 : 30))
            .mask(RoundedRectangle(cornerRadius: viewState.width / 3))
            .scaleEffect(-viewState.width/500 + 1)
            .gesture(isAnimated ? drag : nil)
            .ignoresSafeArea()}
             
            
//
//            .fullScreenCover(isPresented: $showSection) {
//                MessagesView(section: $selectedSection)
//            }
            
        }
           BackButton()
        }
        .zIndex(1)
       
        .blueNavigation
    }
    
    var cover: some View {
        VStack {
            GeometryReader { proxy in
                let scrollY = proxy.frame(in: .named("scroll")).minY
                
                VStack {
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height: scrollY > 0 ? 220 + scrollY : 220)
              
                .background(
                    //Image(course.background)
                    Image(wallpaper)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        
                        .offset(y: scrollY > 0 ? -scrollY : 0)
                        .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                        .blur(radius: scrollY > 0 ? scrollY / 10 : 0)
                        .accessibility(hidden: true)
                        
                )
                .mask(
                    RoundedRectangle(cornerRadius: 0)
                        
                        .offset(y: scrollY > 0 ? -scrollY : 0)
                )
               
                .overlay(
                    VStack(alignment: .trailing, spacing: 8) {
                  
                        
                        Text("Notifications")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(Color("black"))
                      
                        
                   
                        Text("By default, Fusion alerts you whenever someone, or extension wants to send you notifications. You can change this setting at any time.")
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(Color("black"))
                            
                            
                        
                        Divider()
                            .foregroundColor(.secondary)
                            .opacity(0.7)
                            
                            HStack{
                            Text("Messages")
                                .font(.caption)
                                .padding(.trailing)
                                .foregroundStyle(Color("black"))
//                            LogoView(image: "Logo 3")
                                Spacer()
                                Image(systemName: notification.numberofmessages > 0 ? "bell.badge.fill" : "bell")
                                    .font(.caption)
                            }
                            
                                
                        
                      
                        .accessibilityElement(children: .combine)
                    }
                    .padding(20)
                    .background(Color("offwhite"))
                    .cornerRadius(15)
                    .offwhite(offwhitecolor: .black.opacity(0.20), offwhitecolorShadow: .black.opacity(0.30), offwhiteisTapped: false)
                    .padding(10)
                    .padding(.vertical, 20)
                   
                    .background(
                        Rectangle()
                            .fill(Color("offWhite"))
                            .opacity(appear[0] ? 1 : 0)
                    )
                   
                    .offset(y:scrollY > 0 ? -scrollY  : scrollY)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y: 50)
                    .padding(0)
                )
            }
            .frame(height: 150)
            
            sectionsSection
                
        }
    }
    
    var sectionsSection: some View {
        
        VStack(spacing: 13) {
           
            ForEach(Array(messageSections.enumerated()), id: \.offset) { index, section in
                if index != 0 {  }
                NavigationLink(destination:
                                MessagesView(section: $selectedSection)
                    .onAppear{
                        selectedSection = section
                    }
                )
                {
                    NotificationRow(section: section)
                        
                   
                }
            }
        }
        .padding(20)
        .padding(.vertical, 80)
        
    }
    
    func close() {
        withAnimation {
            viewState = .zero
        }
       
    }
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged { value in
                guard value.translation.width > 0 else { return }
                
                if value.startLocation.x < 100 {
                    withAnimation {
                        viewState = value.translation
                    }
                }
                
                if viewState.width > 120 {
                    close()
                }
            }
            .onEnded { value in
                if viewState.width > 80 {
                    close()
                } else {
                    withAnimation(.openCard) {
                        viewState = .zero
                    }
                }
            }
    }
    
 
    
   
}

struct NotificationsDetail_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
      //  NotificationsDetail(namespace: namespace, notification: .constant(messageSections[0]))
           ViewController()
    }
}
