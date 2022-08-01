//
//  ExploreView.swift
//  ExploreView
//
//  Created by Meng To on 2021-08-04.
//

import SwiftUI

struct ExploreView: View {
    @AppStorage("hidemainTab") var hidemainTab = false
    @State var contentHasScrolled = false
    @State var text = ""
    @State var showCourse = false
    @State var selectedCourse = courses[0]
    @State var getDetail = exploreDetailData[0]
    @Namespace var namespace
    @State var searchbarTapped = false
    @State var trendingTapped = false
    @FocusState var isSearchFocused: Bool
    @State var typing = false
    @State var blurNav = false
    
    
    
    var body: some View {
       
        NavigationView {
        ZStack {
           
            BackgroundView()
                .edgesIgnoringSafeArea(.all)
                
            
            
         
            ScrollView (showsIndicators: false){
                scrollDetection
                VStack {
                    
                    Group  {
                        
                        
                        result
                   if !isSearchFocused {
                       readerSection
                    goodreads
                    misc
                       
                   }
                        
                    }
                    
                    
                    Spacer()
                    
                }
                    .padding(.bottom,50)
               
            }.onTapGesture {
                isSearchFocused = false
            }
            overlaynav
            searchbar
            
        }
            
        }.navigationBarHidden(true)
        
    }
    
    var overlaynav: some View{
      
            
     
            NavigationBar(title: "Explore", contentHasScrolled: $contentHasScrolled)
            .opacity(isSearchFocused ? 0 : 1)
               
      
        
    }
    
    var searchbar: some View {
        VStack {
            TextField(searchbarTapped ? "looking for \" something \" ? " : "What would you like to search for?", text: $text)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .focused(
                    withAnimation(.spring()){
                        $isSearchFocused
                    }
                )
            
                .padding()
                .newoffwhite(offwhiteisTapped: searchbarTapped, cornerradius: 13)
                
            //.scaleEffect(searchbarTapped ? 0.97 : 1)
                .overlay(
                    HStack {
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .padding(searchbarTapped ? 10 : 10 )
                            .newoffwhite(offwhiteisTapped: searchbarTapped, cornerradius: 10)
                            .padding(.trailing, 12)
                            .scaleEffect(searchbarTapped ? 0.97 : 1)
                            .animation(.easeIn, value: searchbarTapped)
                            .onTapGesture{
                                text = "a"
                            }
                        
                        
                    }
                )
                .onChange(of: text, perform: { newValue in
                    if isSearchFocused {
                        typing = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            typing = false
                        }
                    }
                    
                })
                .onChange(of: isSearchFocused) { newValue in
                    if isSearchFocused {
                        hidemainTab = true
                        withAnimation(.spring(response: 0.3, dampingFraction: 6, blendDuration: 6)) {
                            hidemainTab = true
                            searchbarTapped = true
                        }
                    } else {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            hidemainTab = false
                            searchbarTapped = false
                        }
                    }
                    
                }
            Spacer()
            
        }.padding()
            .padding(.top, isSearchFocused ? 0 : 60)
            .animation(.spring(), value: isSearchFocused)
            .offset(y:  contentHasScrolled ? -30 : 0)
            
    }
    
    
    var result: some View {
        VStack {
            HStack {
                Text((text.isEmpty ? "Trending" : "Results for  \" \(self.text)\"").uppercased())
                
                Spacer()
                Image(systemName: typing ? "rays" : "rectangle.righthalf.inset.filled.arrow.right")
            } .sectionTitleModifier()
                .padding(.leading, 1)
                .offset(y: 169)
                .opacity(isSearchFocused ? 0 : 1)
            //beautiful
            if  !text.isEmpty && !isSearchFocused {
                VStack {
                    
                    HStack {
                        ScrollView(.horizontal) {
                            HStack {
                              
                                ForEach(Array(results.enumerated()), id: \.offset) { index, course in
                                    if index != 0 {
                                        // Divider()
                                        // Text("hey")
                                        
                                    }
                                    withAnimation(.spring()) {
                                        NavigationLink(destination:
                                        ResultsDetail(namespace: namespace, content: $getDetail, isAnimated: false)
                                                        
                                                      
                                                        .onAppear{
                                                            selectedCourse = course
                                        }
                                                       
                                        
                                        ) {
                                            ListRow(title: course.title, subtitle: course.subtitle, icon: "magnifyingglass", tapped: showCourse )
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 2)
//                                                .onTapGesture {
//                                                    trendingTapped.toggle()
//                                                    withAnimation(.spring()){
//                                                        showCourse = true
//                                                    }
//                                                    selectedCourse = course
//                                                }
                                        }
                                      
                                        
                                    }
                                    
                                    
                                }
                                
                                if results.isEmpty {
                                    Text("No results found")
                                }
                            }.padding()
//                                .fullScreenCover(isPresented: $showCourse) {
//                                    CourseView(namespace: namespace, course: $selectedCourse, isAnimated: false)
//                                }
                            
                                
                        }
                        
                        
                        
                        
                    }  .offset(x: text.isEmpty ? 450 : 0)
                }.padding(.top, isSearchFocused ? 60 : 158)
                   
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .trailing)
                    ))
                
            }
            
            else {
                trending
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading),
                        removal: .move(edge: .leading)
                    ))
            }
            
        }.padding(.top,-20)
    }
    
    
    var trending: some View {
        VStack {
            VStack {
                VStack {
                    ForEach(Array(results.enumerated()), id: \.offset) { index, course in
                        if index != 0 { Divider() }
                        
                        VStack {
                            Trending(title: course.title, icon: "magnifyingglass")
                                .padding(.horizontal, 10)
                                .padding(.vertical, 9)
                                .offwhitebutton(isTapped: isSearchFocused, isToggle: false, cornerRadius: 15)
                                .simultaneousGesture(
                                    TapGesture() .onEnded { _ in
                                        withAnimation(.spring()) {
                                            //  trendingTapped = true
                                            text = "\(course.title)"
                                            trendingTapped = true
                                            isSearchFocused = false
                                            
                                        }
                                    })
                        }
                        
                    }
                    
                    if results.isEmpty {
                        Text("No results found")
                    }
                }.padding(.vertical, 15)
                    .padding(.horizontal, 12)
                    .newoffwhite(offwhiteisTapped: false, cornerradius: 17)
                    .padding(18)
                   
                
                
            }//.offset(x: isSearchFocused && text.isEmpty ? 0 : -431)
            .padding(.top, isSearchFocused ? 40 : 160)
            .animation(.spring(), value: isSearchFocused)
            
            
            Spacer()
        }
        
        
    }
    
    var readerSection: some View {
        VStack{
            HStack {
                Text("Recommended".uppercased())
                Spacer()
                Image(systemName: "sparkles")
            } .sectionTitleModifier()
            
              
               
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(exploreDetailData) { item in
                        NavigationLink(destination:
                                        ResultsDetail(namespace: namespace, content: $getDetail, isAnimated: false)
                            .onAppear{
                               // showCourse = true
                                getDetail = item
                            }
                        ) {
                            RecommendedComponent(recommended: item)
                        }
                        
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 19)
            }
        }
        
    }
    var goodreads: some View {
        VStack{
            HStack {
                Text("Good Reads".uppercased())
                Spacer()
                Image(systemName: "books.vertical.fill")
            } .sectionTitleModifier()
            
                .padding(.leading, 1)
                .offset(y: 19)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(exploreDetailData) { item in
                        NavigationLink(destination:
                                        TopicView(namespace: namespace, content: $getDetail, isAnimated: false)
                            .onAppear{
                                // showCourse = true
                                getDetail = item
                            }
                        ) {
                            TopicComponent(course: item)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 25)
            }
        }
        
    }
    
  
    var misc: some View {
        VStack{
            HStack {
                Text("Misc".uppercased())
                Spacer()
                Image(systemName: "filemenu.and.selection")
            } .sectionTitleModifier()
            
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(exploreDetailData) { item in
                        NavigationLink(destination:
                                        ResultsDetail(namespace: namespace, content: $getDetail, isAnimated: false)
                            .onAppear{
                                // showCourse = true
                                getDetail = item
                            }
                        ) {
                            RecommendedComponent(recommended: item)
                        }
                        
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 19)
            }
        }
        
    }
    
    
    var results: [Course] {
        if text.isEmpty {
            return courses
        } else {
            return courses.filter { $0.title.contains(text) }
        }
    }
    
    var suggestions: [Suggestion] {
        if text.isEmpty {
            return suggestionsData
        } else {
            return suggestionsData.filter { $0.text.contains(text) }
        }
    }
    
    var scrollDetection: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { offset in
            
            if offset < 0 {
                
                contentHasScrolled = true
                
            } else {
                
                contentHasScrolled = false
                
                
            }
            
            
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        
        ViewController()
            .preferredColorScheme(.dark)
        
        
    }
}


