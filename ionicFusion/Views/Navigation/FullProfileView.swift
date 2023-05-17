//
//  CourseView.swift
//  CourseView
//
//  Created by Meng To on 2021-08-11.
//

import SwiftUI

struct FullProfileView: View {
    var namespace: Namespace.ID
    @Binding var matchcard : MatchCardData
    var isAnimated = true
    @Binding var showProfile : Bool
    @State var viewState: CGSize = .zero
    @State var selectedSection = courseSections[0]
    @State var showText = false
    @State var dislike = false
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
           
            ScrollView {
                cover
                    .matchedGeometryEffect(id: "Cardbackground", in: namespace)
                    
                content
                    .offset(y: showText ? 0 : 650)
                    
                   
            }
            .coordinateSpace(name: "scroll")
            .background(Color("Background"))
            .mask(RoundedRectangle(cornerRadius: viewState.width / 3))
            .shadow(color: Color("Shadow").opacity(0.5), radius: 30, x: 0, y: 10)
            .scaleEffect(-viewState.width/500 + 1)
            .gesture(drag)
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring()) {
                  
                        showText = true
                    }
                }
            }
            .ignoresSafeArea()
            
            Button {
                
                withAnimation(.spring()) {
                    showProfile = false
                    showText = false
                }
                
            } label: {
                CloseButton()
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(30)
            .ignoresSafeArea()
            
            
            
        }
        
        .zIndex(1)
        
        
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
                Image(matchcard.background)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                    .blur(radius: scrollY > 0 ? scrollY / 10 : 0)
                    .accessibility(hidden: true)
            )
            
            .overlay(
                Image(horizontalSizeClass == .compact ? "Waves 1" : "Waves 2")
                    .foregroundColor(Color("background"))
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 500 + 1 : 1)
                    .accessibility(hidden: true)
                    .blur(radius: 10)
            )
            .overlay(
                ProfileInfoCard(showProfile: .constant(false), section: matchcard, namespace: namespace, dislike: $dislike)
                    .offset(y: scrollY > 0 ? -scrollY * 1.5 : 0)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .matchedGeometryEffect(id: "Infocard", in: namespace)
                    .offset(y: 10)
                    .padding(20)
            )
        }
        .frame(height: 500)
    }
    
    var content: some View {
        
        VStack {
            
            
       
                        
                        VStack(alignment: .leading, spacing: 30.0) {
                            
                           
                            
                            VStack(alignment: .leading, spacing: 13.0) {
                               
                                
                                HStack {
                                    Text("About Me")
                                        .font(.title).bold()
                                    
                                    Text("23")
                                        .font(.title3).bold()
                                        .padding(5)
                                        .background(Color.orange)
                                        .cornerRadius(60)
                                }
                                
                                Text("Fun loving and looking to settle up with this stuff and do me. its really not like that said no one ever.")
                                    .font(.footnote)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.black)
                                Spacer(minLength: 0.1)
                                
                                
                                HStack(spacing: 3.9){
                                    Image(systemName: "graduationcap")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(.black)
                                    
                                    Text("Minnesota University")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        .lineLimit(2)
                                        .foregroundColor(.black)
                                }
                                
                                HStack {
                                    Image(systemName: "building")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(.black)
                                    
                                    Text("Works in Rochester")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        .lineLimit(2)
                                        .foregroundColor(.black)
                                }
                                
                                HStack {
                                    Image(systemName: "location")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(.black)
                                    
                                    Text("12 miles away")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        .lineLimit(2)
                                        .foregroundColor(.black)
                                }
                            }
                            .padding(20)
                          
                            
                            VStack {
                                Image("image_04")
                                    .resizable()
                                
                                    .frame(maxWidth: .infinity , maxHeight:  400)
                                
                            }.padding(-20)
                                .padding(.bottom,20)
                            
                           
                            
                            VStack(alignment: .leading, spacing: 25.0) {
                                
                                VStack(alignment: .leading, spacing: 15.0){
                                    HStack {
                                        
                                        
                                        Image(systemName: "hand.thumbsup")
                                            .font(.title).bold()
                                            .foregroundColor(.black)
                                        
                                        Text("Likes")
                                            .font(.title).bold()
                                    }
                                    Text("Fun loving and looking to settle up with this stuff and do me. its really not like that said no one ever.")
                                        .font(.footnote)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(3)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .foregroundColor(.black)
                                    
                                    
                                    HStack {
                                        Text("Singing")
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                            .background(Color(hue: 0.386, saturation: 0.68, brightness: 0.935))
                                            .cornerRadius(15)
                                        
                                        Text("Dancing")
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                            .background(Color(hue: 0.76, saturation: 0.507, brightness: 0.92))
                                            .cornerRadius(15)
                                        
                                        Text("Traveling")
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                            .background(Color.purple)
                                            .cornerRadius(15)
                                    }
                                }
                                

                                
                                
                            }
                            
                            .padding(20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                           
                            
                            
                            VStack {
                                Image("image_06")
                                    .resizable()
                                
                                    .frame(maxWidth: .infinity , maxHeight:  400)
                                
                            }.padding(-20)
                                
                            
                            
                            VStack(alignment: .leading, spacing: 15.0){
                                HStack {
                                    
                                    
                                    Image(systemName: "teddybear")
                                        .font(.title).bold()
                                        .foregroundColor(.black)
                                    
                                    Text("Lifestyle")
                                        .font(.title).bold()
                                }
                                
                                Text("Fun loving and looking to settle up with this stuff and do me. ")
                                    .font(.footnote)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.black)
                                
                                
                                
                                HStack {
                                    Text("Dog")
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(Color.purple)
                                        .cornerRadius(15)
                                    
                                    
                                }
                            }.padding(20)

                            
                        }
                        
                        .padding(.top,-10)
                       .padding(10)
                    
                    
                    
                    
                
               
        }.padding(.bottom,20)
            
            .background(Color("Background"))
            
        
        
        
        
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
                
                if viewState.width > 100 {
                    showProfile = false
                }
            }
            .onEnded { value in
                if viewState.width > 50 {
                    showProfile = false
                } else {
                    withAnimation(.openCard) {
                        viewState = .zero
                    }
                }
            }
    }
    
    
    
   
}

struct FullMatchProfileView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
       // FullProfileView(namespace: namespace, matchcard: .constant(matchCardData[0]), showProfile: .constant(false))
        ViewController()
        
    }
}
