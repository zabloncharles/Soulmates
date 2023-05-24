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
    @State var text = "yo"
    @Binding var section: NotificationModel
    @State var hideNav = false
    @State var scrolling = CGFloat(0)
    @State var scrolledItem: Int = 0
  
    @FocusState private var keyboardFocus: Bool
    var body: some View {
        NavigationView {
            ZStack {
              BackgroundView()
                content
                cover
                texting
              
                
            }
            .zIndex(1)
        }.onAppear{
            withAnimation(.spring()) {
                hidemainTab = true
            }
        }
        .onDisappear {
            withAnimation(.spring()) {
                hidemainTab = false
            }
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
                            .frame(width: 60, height: 60)
                            .padding(10)
                        VStack{
                            Text(section.name)
                                .font(.title2).bold()
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
                        
                        Image(systemName: "exclamationmark.circle")
                            .foregroundColor(.gray )
                            .font(.title2)
                            .padding(.trailing,10)
                    }
                    
                
                   
                }
                    .background(Color("white").opacity(0.5))
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                  
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(20)
                    .offset(y: 80)
            )
         
            Spacer()
        }//.offset(y: scrolling > 20.0 ? -CGFloat(scrolling - 20) : CGFloat(scrolling - 20))
        .edgesIgnoringSafeArea(.all)
    }
    
    var content: some View {
        
                    
            VStack{
                 Spacer()
                VStack {
                    
                    ScrollViewReader { proxy in
                        ScrollView (showsIndicators: false){
                            
                            VStack {
                                ForEach(Array(messages.enumerated()), id: \.offset) { index, section in
                                    if index != 0 {  }
                                    
                                    MessageBubble(section: section)
                                        .tag(index)
                                        .onAppear{
                                            proxy.scrollTo((Array(messages.enumerated()).endIndex)-1)
                                        }
                                    
                                       
                                }
                            }.onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { offset in
                                let itemIndex = Int(offset.y / 20)
                                if scrolledItem != itemIndex {
                                    scrolledItem = itemIndex
                                    // Perform any desired action when the scroll changes
                                }
                            }
                            .background(GeometryReader { geometry in
                                Color.clear
                                    .preference(key: ScrollViewOffsetPreferenceKey.self, value: geometry.frame(in: .named("scrollView")).origin)
                            })
                            .coordinateSpace(name: "scrollView")
                        }
                    }
                
                
            }
               
                .padding(.top, 114)
                .padding(.bottom,90)
            .coordinateSpace(name: "scroll")
        }.background(Color("offwhiteneo"))
            //.overlay(Text("\(scrolledItem)"))
            .onTapGesture{
                keyboardFocus = false
            }
        
        
        
    }
    var texting: some View {
       
           
            VStack{
                Spacer()
                
                HStack {
                    TextField("Message\(scrolledItem)" , text: $text)
                        .padding(.vertical)
                        .padding(.leading, 55)
                        .background(Color("offwhite"))
                        .focused($keyboardFocus)
                        .cornerRadius(25)
                        .overlay(  Image(systemName: "pencil.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .offset(x: -145)
                        )
                        .offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 25, action:  .constant(false))
                    
                    Button(action: buttonsend) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                            .neumorphiccircle(padding: -5, opacity: 1)
                    }
                    
                }.padding()
                   // .background(Color("offwhite"))
                    .background(
                        VStack{
                            Rectangle()
                                .fill(.ultraThinMaterial)
                                .frame(width: .infinity,height: 190)
                                .cornerRadius(35)
                                .offset(y:55)
                        }
                           
                            
                    )
                    
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
                       //  text = "ii\(offset)"
                    }
                    if offset > 903 && offset < 1120 {
                        withAnimation(.easeInOut) {
                            
                          //   text = "yo\(offset)"
                        }
                    }
                    else {
                        withAnimation(.easeInOut) {
                          
                           //  text = "huh\(offset)"
                          //  scrolling = offset
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




struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}
