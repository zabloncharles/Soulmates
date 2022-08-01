//
//  CourseView.swift
//  CourseView
//
//  Created by Meng To on 2021-08-11.
//

import SwiftUI

struct CourseView: View {
    var namespace: Namespace.ID
    @Binding var course: Course
    var isAnimated = true
    
    @State var viewState: CGSize = .zero
    @State var showSection = false
    @State var appear = [false, false, false]
    @State var selectedSection = courseSections[0]
    
   
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                sectionsSection
                    .opacity(appear[2] ? 1 : 0)
            }
            .coordinateSpace(name: "scroll")
            .background(Color("Background"))
            .mask(RoundedRectangle(cornerRadius: appear[0] ? 0 : 30))
            .mask(RoundedRectangle(cornerRadius: viewState.width / 3))
            .modifier(OutlineModifier(cornerRadius: viewState.width / 3))
            .shadow(color: Color("Shadow").opacity(0.5), radius: 30, x: 0, y: 10)
            .scaleEffect(-viewState.width/500 + 1)
            .background(Color("Shadow").opacity(viewState.width / 500))
            .background(.ultraThinMaterial)
            .gesture(isAnimated ? drag : nil)
            .ignoresSafeArea()
            
            Button {
                isAnimated ?
                withAnimation(.closeCard) {
                    
                }
                : presentationMode.wrappedValue.dismiss()
            } label: {
                CloseButton()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
            .ignoresSafeArea()
            
            LogoView(image: course.logo)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(20)
                .matchedGeometryEffect(id: "logo\(course.index)", in: namespace)
                .ignoresSafeArea()
               
        }
        .navigationBarColor()
        .zIndex(1)
        .onAppear { fadeIn() }
        
    }
    
    var cover: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: scrollY > 0 ? 500 + scrollY : 500)
            .background(
                Image(course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .matchedGeometryEffect(id: "image\(course.index)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .accessibility(hidden: true)
            )
            .background(
                Image(course.background)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "background\(course.index)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                    .blur(radius: scrollY > 0 ? scrollY / 10 : 0)
                    .accessibility(hidden: true)
            )
            .mask(
                RoundedRectangle(cornerRadius: appear[0] ? 0 : 30)
                    .matchedGeometryEffect(id: "mask\(course.index)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
            )
            .overlay(
                Image(horizontalSizeClass == .compact ? "Waves 1" : "Waves 2")
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 500 + 1 : 1)
                    .opacity(1)
                    .matchedGeometryEffect(id: "waves\(course.index)", in: namespace)
                    .accessibility(hidden: true)
            )
            .overlay(
                VStack(alignment: .trailing, spacing: 16) {
                    Text(course.title)
                        .font(.custom("WorkSans-Regular", size: 30))
                        .font(.title)
                        .fontWeight(.semibold)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.primary)
                        .matchedGeometryEffect(id: "title\(course.index)", in: namespace)
                    
                    Text(course.subtitle.uppercased())
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.primary.opacity(0.7))
                        .matchedGeometryEffect(id: "subtitle\(course.index)", in: namespace)
                    
               
                    Text(course.text)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.primary.opacity(0.7))
                        .matchedGeometryEffect(id: "description\(course.index)", in: namespace)
                    
                    Divider()
                        .foregroundColor(.secondary)
                        .opacity(appear[1] ? 0.7 : 0)
                        
                        HStack{
                        Text("Brought to you by the Fusion team.")
                            .font(.caption)
                            .padding(.trailing)
                            .foregroundStyle(.secondary)
                        LogoView(image: "Logo 3")
                        }
                        
                            
                    
                    .opacity(appear[1] ? 1 : 0)
                    .accessibilityElement(children: .combine)
                }
                .padding(20)
                .padding(.vertical, 10)
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .cornerRadius(30)
                        .blur(radius: 30)
                        .matchedGeometryEffect(id: "blur\(course.index)", in: namespace)
                        .opacity(appear[0] ? 0 : 1)
                )
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .backgroundStyle(cornerRadius: 30)
                        .opacity(appear[0] ? 1 : 0)
                )
                .offset(y: scrollY > 0 ? -scrollY * 1.8 : 0)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(y: 100)
                .padding(20)
            )
        }
        .frame(height: 500)
    }
    
    var sectionsSection: some View {
        VStack(spacing: 16) {
            ForEach(Array(courseSections.enumerated()), id: \.offset) { index, section in
                if index != 0 { Divider() }
                SectionRow(section: section)
                    .onTapGesture {
                        showSection.toggle()
                        selectedSection = section
                    }
                    .accessibilityElement(children: .combine)
            }
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .backgroundStyle(cornerRadius: 30)
        .padding(20)
        .padding(.vertical, 80)
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
    
    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)) {
            appear[0] = true
        }
        withAnimation(.easeOut.delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.easeOut.delay(0.5)) {
            appear[2] = true
        }
    }
    
    func fadeOut() {
        withAnimation(.easeIn(duration: 0.1)) {
            appear[0] = false
            appear[1] = false
            appear[2] = false
        }
    }
}

struct CourseView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        CourseView(namespace: namespace, course: .constant(courses[0]))
            
    }
}
