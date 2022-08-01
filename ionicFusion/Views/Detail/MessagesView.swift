//
//  MessagesView.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 2/28/22.
//

import SwiftUI

struct MessagesView: View {
    @AppStorage("hidemainTab") var hidemainTab = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State var text = ""
    @Binding var section: NotificationModel
    @State var hideNav = false
    @State var texty = ""
    @State var scrolling = CGFloat(0)
    
    
    var body: some View {
        NavigationView {
            ZStack {
             
                    
                
                  
                    
                    content
                cover
                       
                   
                   
                
              
                
                texting
              
                Text(texty)
            }.blueNavigation
            .zIndex(1)
        }.onAppear{
            hidemainTab = true
        }
        .onDisappear {
            hidemainTab = false
        }
    }
    
    var cover: some View {
        VStack {
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 120)
         
            .background(
               // Image(section.background)
                Image("image_10")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .accessibility(hidden: true)
            )
            .mask(
                RoundedRectangle(cornerRadius: 0)
            )
    //        .overlay(
    //            Image(horizontalSizeClass == .compact ? "Waves 1" : "Waves 2")
    //                .frame(maxHeight: .infinity, alignment: .bottom)
    //                .accessibility(hidden: true)
    //        )
            .overlay(
                VStack(alignment: .leading, spacing: 8) {
                    
                    
                    HStack {
                        Image(section.avatar)
                            .resizable(resizingMode: .stretch)
                            .aspectRatio(contentMode: .fill)
                            
                            .cornerRadius(80)
                            .mask(Circle())
                            .background(
                                Circle()
                                    .fill(Color.blue)
                                    .padding(-2)
                                    
                            )
                            .frame(width: 70, height: 70)
                            .newoffwhite(offwhiteisTapped: false, cornerradius: 180)
                            .padding(10)
                        VStack{
                            Text(section.name)
                            .font(.title).bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.primary)
                        
                            HStack(spacing:2) {
                                Image(systemName: "circlebadge.fill")
                                    .foregroundColor(section.online == false ? .red : .green)
                                    .font(.caption2)
                                Text(section.online == true ? "Online" : "Was online 5 minutes ago")
                                .font(.footnote)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.primary.opacity(0.7))
                            }
                         
                        }
                        Spacer()
                    }
                    
                
                   
                }
                    .padding(1)
                    .background(Color("offwhite"))
                    .cornerRadius(19)
                    .offwhite(offwhitecolor: .white.opacity(0.30), offwhitecolorShadow: .black.opacity(0.30), offwhiteisTapped: false)
                   // .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(20)
                    .offset(y: 70)
            )
            .overlay(
               
                    HStack(spacing:1) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                       HStack(spacing:3) {
                           Image(systemName: "chevron.left")
                        Text("Back")

                       }
                        }
                        
                        Spacer()
                        
                        Image(systemName: "info.circle")
                            .foregroundColor(.secondary)
                    }
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(20)
                        .padding(.top, 6)
                        .padding(.leading, -7)
                
               
                
        )
            Spacer()
        }//.offset(y: scrolling > 20.0 ? -CGFloat(scrolling - 20) : CGFloat(scrolling - 20))
        .edgesIgnoringSafeArea(.all)
    }
    
    var content: some View {
        
        VStack {
            
            ScrollView{
                 Spacer()
                VStack {
                    ScrollViewReader { proxy in
                    ForEach(Array(messages.enumerated()), id: \.offset) { index, section in
                            if index != 0 {  }
                        
                            MessageBubble(section: section)
                            .tag(index)
                                .onAppear{
                                    proxy.scrollTo((Array(messages.enumerated()).endIndex)-1)
                                }
                        }
                    }
                }//.padding(.top, 50)
                 .padding(.bottom, 70)
            }
               
                //.padding(.top, 54)
            .coordinateSpace(name: "scroll")
        }.background(Color("background"))
        
        
        
    }
    var texting: some View {
        VStack{
            Spacer()
            
            HStack {
                TextField("Message" , text: $text)
                    .padding(.vertical)
                    .padding(.leading, 55)
                    .background(Color.offWhite)
                    .cornerRadius(25)
                    .overlay(  Image(systemName: "pencil.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .offset(x: -145)
                    )
                    .offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 25)
                
                Button(action: buttonsend) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                        .neumorphiccircle(padding: -5, opacity: 1)
                }
                
            }.padding()
                .background(Color.offWhite)
        }
    }
    var scrollDetection: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { offset in
            withAnimation(.easeInOut) {
                
                    if offset > 1120 {
                       
                       // hideNav = true
                        // text = "ii\(offset)"
                    }
                    if offset > 903 && offset < 1120 {
                        withAnimation(.easeInOut) {
                            
                           //  text = "yo\(offset)"
                        }
                    }
                    else {
                        withAnimation(.easeInOut) {
                          
                            // text = "huh\(offset)"
                            scrolling = offset
                        }
                        
                        
                    }
                    
                }
            }
        }
    func buttonsend(){
        
    }
    }


struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
       MessagesView(section: .constant(messageSections[0]))
       // ViewController()
    }
}




