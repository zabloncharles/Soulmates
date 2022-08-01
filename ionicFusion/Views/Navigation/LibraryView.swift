//
//  LibraryView.swift
//  LibraryView
//
//  Created by Meng To on 2021-08-06.
//

import SwiftUI

struct LibraryView: View {
    @AppStorage("hidemainTab") var hidemainTab = false
    @State var contentHasScrolled = false
    @State var currentDate: Date = Date()
    @State var offsetNumber : CGFloat = 0
    @State var message = ""
    @State var blurnav = false
    @State var hideScrollItems = false
    
    var body: some View {
        ZStack {
            BackgroundView()
                .edgesIgnoringSafeArea(.all)
            
            content
//                .background(
//                    Image("Blob 1")
//                        .offset(x: 150, y: -90)
//                        .blur(radius: 13)
//                )
            
            overlaynav
        }
    }
    
    var content: some View {
        VStack {
            
            
            ScrollView (showsIndicators: false){
                scrollDetection
                LibraryCalendar()
                               .padding(.top, 70)
                HStack {
                    Text("Next Up".uppercased())
                        Spacer()
                    Image(systemName: "bell")
                    
                }.sectionTitleModifier()
                    .padding(.top, 20)
                
                
                
                notification
                    .padding(.top, -20)
                
                
     
          
          HStack {
                    Text("Your Cycles".uppercased())
                    Spacer()
                    Image(systemName: "doc.text.image")
                    
                }.sectionTitleModifier()
                    .padding(.top, 10)
                HStack(spacing:60){
                               
                    TrackCircle(appear: true, background: "image_04", value: "2 days", name: "Period", percent: 0.39)
                       
                               
                               TrackCircle(appear: true, background: "image_05", value: "Scorpio", name: "Zodiac", percent: 0.49)
                               
                               TrackCircle(appear: true, background: "image_09", value: "Aretha", name: "Cycle", percent: 0.69)
                }
                .padding(.top, 20)
                    
                    
                
            }
            .coordinateSpace(name: "scroll")
       
        }
    }
    var overlaynav: some View{
       
          
            NavigationBar(title: "Library", contentHasScrolled: ($contentHasScrolled))
                
        
        
    }
    var notification : some View {
        VStack{
            Spacer()
            
            HStack{
                LottieView(filename: "notification" ,loop: true)
                    .frame(width: 40, height: 40)
                    
                    .scaleEffect(1.7)
                    .background(
                    Circle()
                        .fill(.black)
                        .padding(-7)
                    )
                    .offset(x: -4, y: 1)
                    
                VStack(alignment: .leading) {
                    Text("Message")
                        .foregroundColor(.primary)
                        
                    
                        Text("message to configure")
                            .font(.subheadline)
                        .foregroundColor(.primary)
                        
                    
                       
                }.padding(4)
                Spacer()
             
                    
                
                
            }.padding()
                .padding(.leading, 7)
                .newoffwhite(offwhiteisTapped: false, cornerradius: 19)
              
            
            
            
            
        }.padding()
    }
   // var cardsSection: some View {
    //    ScrollView(.horizontal, showsIndicators: false) {
      //      HStack(spacing: 16) {
         //       ForEach(courses) { item in
            //        WallpaperComponent(course: item)
            //    }
         //   }
         //   .padding(20)
        //    .padding(.bottom, 70)
       // }
  //  }
    
    
    var certificatesSection: some View {
        CertificateView()
            .frame(height: 220)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(.linearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .padding(.horizontal, 20)
                    .offset(y: -20)
            )
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(.linearGradient(colors: [.teal, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .padding(.horizontal, 40)
                    .offset(y: -40)
            )
            .padding(20)
       
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



struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
      
        ViewController()
            .preferredColorScheme(.light)
            
    }
}
