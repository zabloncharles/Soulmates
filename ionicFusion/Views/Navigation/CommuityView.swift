//
//  ExploreView.swift
//  ExploreView
//
//  Created by Zablon Charles.
//

import SwiftUI

struct CommunityView: View {
    @AppStorage("hidemainTab") var hidemainTab = false
    @State var contentHasScrolled = false
    @State var text = ""
    @State var showCourse = false
    @State var selectedCourse = postData[0]
    @Namespace var namespace
    @State var searchbarTapped = false
    @State var trendingTapped = false
    @State var postTapped = false
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
                
            }.onAppear{
                hidemainTab = false
            }
            
        }.navigationBarHidden(true)
        
    }
    
    var overlaynav: some View{
      
            
            NavigationBar(title: "Community", contentHasScrolled: $contentHasScrolled)
            .opacity(searchbarTapped ? 0 : 1)
        
        
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
                       
                            VStack {
                                
                                ForEach(Array(results.enumerated()), id: \.offset) { index, course in
                                  
                                   
                                    NavigationLink(destination:
                                    
                                                   // CommentsView(section: $selectedCourse)
                                        .onAppear{
                                            selectedCourse = course
                                        }
                                      
                                                   
                                    ) {
                                        PostComponent(post: course, tapped: postTapped)
                                            .padding(.bottom,10)
                                          
                                    }

                                    
                                }
                                
                                if results.isEmpty {
                                    Text("No results found")
                                }
                            }.padding()
                         
                            
                            
                        
                        
                        
                        
                        
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
                    ForEach(Array(trendingresults.enumerated()), id: \.offset) { index, course in
                        if index != 0 { Divider() }
                        
                        VStack {
                            Trending(title: course.post , icon: "magnifyingglass")
                                .padding(.horizontal, 10)
                                .padding(.vertical, 9)
                                .offwhitebutton(isTapped: isSearchFocused, isToggle: false, cornerRadius: 15)
                                .simultaneousGesture(
                                    TapGesture() .onEnded { _ in
                                        withAnimation(.spring()) {
                                            //  trendingTapped = true
                                            text = "\(course.post)"
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
                   
                
                
            }
            .padding(.top, isSearchFocused ? 40 : 160)
            .animation(.spring(), value: isSearchFocused)
            
            
            Spacer()
        }
        
        
    }
    
    var misc: some View {
       VStack {
           if text.isEmpty {
               VStack {
                    HStack {
                        Text("Misc".uppercased())
                        Spacer()
                        Image(systemName: "filemenu.and.selection")
                    } .sectionTitleModifier()
                    
                        .padding(.leading, 1)
                        .offset(y: 19)
                   
                        VStack(spacing: 20) {
                            ForEach(postData) { item in
                                NavigationLink(destination:
                                              //  CommentsView(section: $selectedCourse)
                                    .onAppear{
                                        selectedCourse = item
                                    }
                                
                                ) {
                                    PostComponent(post: item)
                                }
                        
                              
                                 
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 25)
                    
               }.padding(.top , -10)
           }
        }
        
        
    }
    
    
    var results: [PostModel] {
        if text.isEmpty {
            return postData
        } else {
            return postData.filter { $0.post.contains(text) }
        }
    }
    
    var trendingresults: [PostModel] {
        if text.isEmpty {
            return postData
        } else {
            return postData.filter { $0.post.contains(text) }
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

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        
        CommunityView()
            .preferredColorScheme(.dark)
        
        
    }
}


