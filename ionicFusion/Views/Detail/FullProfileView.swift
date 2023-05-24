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
    @State var liked = false
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
           BackgroundView()
            ScrollView {
                cover
                    .matchedGeometryEffect(id: "som\(matchcard.usernumber)", in: namespace)
                    
                content
                    .offset(y: showText ? 0 : 650)
                    
                   
            }
            .coordinateSpace(name: "scroll")
            .mask(RoundedRectangle(cornerRadius: viewState.width / 3))
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
            
           
      
            
            
            VStack {
                HStack {
                    Text(matchcard.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .cornerRadius(15)
                    Spacer()
                    Button {
                        
                        withAnimation(.spring()) {
                            showProfile = false
                            showText = false
                        }
                        
                    } label: {
                        Image(systemName: "heart.slash")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                    }
                }.padding(.horizontal,25)
                Spacer()
            }
        }
        .matchedGeometryEffect(id: "wholecard\(matchcard.usernumber)", in: namespace)
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
              //  Image(matchcard.background)
              //      .resizable()
                  //  .aspectRatio(contentMode: .fill)
                    GetImage()
                       
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                    .blur(radius: scrollY > 0 ? scrollY / 10 : 0)
                    .accessibility(hidden: true)
                    
            )
            
            .cornerRadius(8)

        }
        .frame(height: 400)
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
                                    .foregroundColor(Color("black"))
                                Spacer(minLength: 0.1)
                                
                                
                                HStack(spacing: 3.9){
                                    Image(systemName: "graduationcap")
                                        .font(.system(size: 18, weight: .medium))
                                       
                                    
                                    Text("Minnesota University")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        .lineLimit(2)
                                        
                                }.foregroundColor(Color("black"))
                                
                                HStack {
                                    Image(systemName: "building")
                                        .font(.system(size: 18, weight: .medium))
                                     
                                    
                                    Text("Works in Rochester")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        .lineLimit(2)
                                        }.foregroundColor(Color("black"))
                                
                                HStack {
                                    Image(systemName: "location")
                                        .font(.system(size: 18, weight: .medium))
                                       
                                    
                                    Text("12 miles away")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        .lineLimit(2)
                                       
                                }.foregroundColor(Color("black"))
                            }
                            .padding(20)
                            .background(Color("offwhite"))
                            .cornerRadius(19)
                          
                            
                            
                            VStack(alignment: .leading, spacing: 15.0){
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(height: 0.1)
                                HStack {
                                    
                                    
                                    Image(systemName: "hand.thumbsup")
                                        .font(.title).bold()
                                        .foregroundColor(Color("black"))
                                    
                                    Text("First Date Idea?")
                                        .font(.title2).bold()
                                }
                                Text("What would you like to do with \(matchcard.name) on a first date? :)")
                                    .font(.footnote)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(3)
                                    .foregroundColor(Color("black"))
                                
                                
                                VStack(spacing: 26.0) {
                                    HStack {
                                        HStack(spacing: 4.0) {
                                            Text("Bar")
                                            Spacer()

                                            Image(systemName: "wineglass")
                                            
                                                .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                        }
                                           
                                    }.padding(12)
                                        .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 14, action: $liked)
                                    
                                    HStack {
                                        HStack(spacing: 4.0) {
                                            
                                            Text("Dinner")
                                            Spacer()
                                            Image(systemName: "fork.knife")
                                            
                                                .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                        }
                                        
                                    }.padding(12)
                                        .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 14, action: $liked)
                                    
                                    HStack {
                                        HStack(spacing: 4.0) {
                                            
                                            Text("Other")
                                            Spacer()
                                            Image(systemName: "eyes.inverse")
                                           
                                                .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                        }
                                        
                                    }.padding(12)
                                        .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 14, action: $liked)
                                }
                            }.padding()
                            
                            
                            
                            
                            
                            ZStack {
                                VStack {
                                    Image("image_04")
                                        .resizable()
                                    
                                        .frame(maxWidth: .infinity , maxHeight:  400)
                                    
                                }
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Image(systemName: "heart.circle.fill")
                                            
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                    }.padding()
                                        .padding(.horizontal, 20)
                                }
                            }.padding(-20)
                                .padding(.bottom,20)
                                .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 14, action: $liked)
                            
                            
                           
                            
                        
                                
                                VStack(alignment: .leading, spacing: 15.0){
                                    HStack {
                                        
                                        
                                        Image(systemName: "hand.thumbsup")
                                            .font(.title).bold()
                                           
                                        
                                        Text("Likes")
                                            .font(.title).bold()
                                        Spacer()
                                    }
                                    Text("Fun loving and looking to settle up with this stuff and do me. its really not like that said no one ever.")
                                        .font(.callout)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(3)
                                        
                                    
                                    
                                    HStack {
                                        Text("Singing")
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                            .background(Color(hue: 0.975, saturation: 0.635, brightness: 0.937))
                                            .cornerRadius(15)
                                        
                                        Text("Dancing")
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                            .background(Color(hue: 0.76, saturation: 0.163, brightness: 0.717))
                                            .cornerRadius(15)
                                        
                                        Text("Traveling")
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                            .background(Color(hue: 1.0, saturation: 0.348, brightness: 0.929))
                                            .cornerRadius(15)
                                    }
                                }.foregroundColor(Color("black"))
                                .padding()
                                .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 18, action: $liked)
                                .padding(.bottom,25)
                                    
                                    
                                    
                            ZStack {
                                VStack {
                                    Image("image_08")
                                        .resizable()
                                    
                                        .frame(maxWidth: .infinity , maxHeight:  400)
                                    
                                }
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Image(systemName: "heart.circle.fill")
                                        
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                    }.padding()
                                        .padding(.horizontal, 20)
                                }
                            }.padding(-20)
                                .padding(.bottom,20)
                                .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 14, action: $liked)
                                
                                
                            
                            
                            VStack(alignment: .leading, spacing: 15.0){
                                HStack {
                                    
                                    
                                    Image(systemName: "teddybear")
                                        .font(.title).bold()
                                    
                                    Text("Lifestyle")
                                        .font(.title).bold()
                                }
                                
                                Text("Fun loving and looking to settle up with this stuff and do me. ")
                                    .font(.callout)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                
                                
                                
                                HStack {
                                    Text("Dog")
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(Color(hue: 1.0, saturation: 0.348, brightness: 0.929))
                                        .cornerRadius(15)
                                    
                                    
                                }
                            }.foregroundColor(Color("black"))
                            .padding(20)
                                .offwhitebutton(isTapped: liked, isToggle: false, cornerRadius: 19, action: $liked)
                                .padding(.bottom,95)

                            
                        }
                        
                        .padding(.top,-10)
                       .padding(10)
                    
                    
                    
                    
                
               
        }.padding(.bottom,20)
            
            
            
        
        
        
        
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

