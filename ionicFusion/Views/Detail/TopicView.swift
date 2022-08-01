//
//  TopicView.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 3/30/22.
//

import SwiftUI

struct TopicView: View {
    @State var contentHasScrolled = false
    var namespace: Namespace.ID
    @Binding var content: ExploreDetailModel
    var isAnimated = true
    @AppStorage("hidemainTab") var hidemainTab = false
    @State var viewState: CGSize = .zero
    @State var showSection = false
    @State var appear = [false, false, false]
    @State var selectedSection = courseSections[0]
    
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                scrollDetection
                cover
                   
              
                
            }
            .coordinateSpace(name: "scroll")
            .scaleEffect(-viewState.width/500 + 1)
            .gesture(isAnimated ? drag : nil)
            .ignoresSafeArea()
            
            
            
            navbar
        }
        .onAppear{
            hidemainTab = true
        }
        .onDisappear{
            hidemainTab = false
        }
        .customNavbar
        
        
        .zIndex(1)
        
        
        
    }
    var navbar: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    if contentHasScrolled{
                        Color("offwhite")
                            .offset(y:-15)
                    }
                    HStack{
                        
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        },
                               label: {
                            HStack(spacing: 1) {
                                Image(systemName: "chevron.backward")
                                Text("Back")
                            }
                        })
                        Spacer()
                        
                    }.overlay(
                        Text(content.title)
                            .opacity(contentHasScrolled ? 1:0)
                    )
                    .padding(.horizontal)
                    .font(.subheadline)
                    .offset(y:contentHasScrolled ? 9 : -15)
                    
                    
                }   .frame(height: geometry.safeAreaInsets.top)
                    .edgesIgnoringSafeArea(.top)
                
                
                Spacer()
            }
        }
    }
    var info: some View {
        
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            VStack(alignment: .trailing, spacing: 16) {
                Text(content.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)
                
                Text(content.subtitle.uppercased())
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary.opacity(0.7))
                    .matchedGeometryEffect(id: "subtitle\(content.index)", in: namespace)
                
                
                Text(content.text)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary.opacity(0.7))
                    .matchedGeometryEffect(id: "description\(content.index)", in: namespace)
                
                Divider()
                    .foregroundColor(.secondary)
                
                
                HStack{
                    Text("Brought to you by the Fusion team.")
                        .font(.caption)
                        .padding(.trailing)
                        .foregroundStyle(.secondary)
                    LogoView(image: "Logo 3")
                }
                
                
                
                .accessibilityElement(children: .combine)
                
                sectionsSection
            }.padding()
                .background(Color("offwhite"))
                .cornerRadius(15)
            // .offwhite(offwhitecolor: .black.opacity(0.50), offwhitecolorShadow: .black.opacity(0.50), offwhiteisTapped: false)
                .newoffwhite(offwhiteisTapped: false, cornerradius: 16)
            
                .offset(y: scrollY > 0 ? -scrollY * 1.8 : 0)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(y: 160)
                .padding(20)
        }
        
    }
    
    var cover: some View {
        VStack {
            GeometryReader { proxy in
                let scrollY = proxy.frame(in: .named("scroll")).minY
                
                VStack {
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height: scrollY > 0 ? 500 + scrollY : 500)
                //                .background(
                //                    Image(content.image)
                //                        .resizable()
                //                        .aspectRatio(contentMode: .fit)
                //                        .padding(20)
                //                        .matchedGeometryEffect(id: "image\(content.index)", in: namespace)
                //                        .offset(y: scrollY > 0 ? -scrollY : 0)
                //                        .accessibility(hidden: true)
                //                )
                .background(
                    Image(content.background)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .matchedGeometryEffect(id: "background\(content.index)", in: namespace)
                        .offset(y: scrollY > 0 ? -scrollY : 0)
                        .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                        .blur(radius: scrollY > 30 ? scrollY / 10 : 0)
                        .accessibility(hidden: true)
                    
                )
                .mask(
                    RoundedRectangle(cornerRadius: 10)
                        .matchedGeometryEffect(id: "mask\(content.index)", in: namespace)
                        .offset(y: scrollY > 0 ? -scrollY : 0)
                )
                
                
            }
            .frame(height: 580)
            Image("Waves 1")
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .padding(.top, -194)
        }.overlay( info)
    }
    
    var sectionsSection: some View {
        VStack(spacing: 6) {
           
            ForEach(Array(courseSections.enumerated()), id: \.offset) { index, section in
                if index != 0 { Divider() }
                EventComponent(eventTapped: showSection, title: section.title, description: section.text)
                    .onTapGesture {
                        showSection.toggle()
                        selectedSection = section
                    }
                    .accessibilityElement(children: .combine)
            }
        }
        .sheet(isPresented: $showSection) {
            SectionView(section: $selectedSection)
        }
    }
    
    func close() {
        withAnimation {
            viewState = .zero
        }
        withAnimation(.closeCard.delay(0.2)) {
            
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
    
    var scrollDetection: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { offset in
            
            if offset < 0 {
                
                withAnimation(.easeInOut) {
                    contentHasScrolled = true
                }
                
            } else {
                
                withAnimation(.spring()) {
                    contentHasScrolled = false
                }
                
                
            }
            
            
        }
    }
    
}


struct TopicView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
       // TopicView(namespace: namespace, content: .constant(exploreDetailData[0]))
        ViewController()
    }
}
