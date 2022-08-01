//
//  SectionView.swift
//  SectionView
//
//  Created by Zablon Charles on 2021-08-11.
//

import SwiftUI

struct CommentsView: View {
    @AppStorage("hidemainTab") var hidemainTab = false
    @AppStorage("wallpaper") var wallpaper = "ob1"
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State var likes = 0
    @State var liked = false
    @State var disliked = false
    @State var contentHasScrolled = false
    @FocusState var textField
    @State var commentText = ""
    @Binding var section: PostModel
    
    
    var body: some View {
        ZStack {
            BackgroundView()
            ScrollView {
                scrollDetection
                cover
                    
               
            }
           .coordinateSpace(name: "scroll")
            
           .ignoresSafeArea()
            
          
                     //  .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
           
              
                       
                       
           
            commentTextField
            BackButton(contentHasScrolled: contentHasScrolled)
                .offset(y: contentHasScrolled ? -45 : -90)
        }.blueNavigation
        .zIndex(1)
      
        .onAppear{
            hidemainTab = true
        }
        .onDisappear {
            hidemainTab = false
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
                    RoundedRectangle(cornerRadius:  0)
                    
                        .offset(y: scrollY > 0 ? -scrollY : 0)
                )
                
             
            }
            .frame(height: 50)
            VStack(alignment: .leading, spacing: 8) {
                
                VStack {
                    HStack{
                        Image(section.avatar)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                            .frame(width: 40, height: 40)
                            .cornerRadius(30)
                        VStack(alignment: .leading) {
                            Text(section.username)
                            HStack {
                                Text(section.topic)
                                    .font(.caption)
                                Text("-")
                                    .font(.caption)
                                Text(section.views)
                                    .font(.caption)
                            }
                        }
                        Spacer()
                        VStack {
                            
                            
                            
                        }
                    }
                    VStack(alignment: .leading){
                        
                     
                        HStack {
                            Text(section.post)
                                .font(.headline)
                            .multilineTextAlignment(.leading)
                            Spacer()
                        }
                     
                           
                        
                    }.padding(.vertical, 10)
                    
                    
                    HStack{
                        Image(systemName: "arrow.up.heart.fill")
                            .foregroundColor(liked ? .blue : .gray)
                            .scaleEffect(liked ? 0.97 : 1)
                            .animation(.spring(), value: liked)
                            .onTapGesture {
                                likes += 1
                                liked = true
                                disliked = false
                            }
                        Text(Int(section.votes) == 0 ? "Vote" : "\(section.votes)")
                            .font(.caption)
                        Image(systemName: "arrow.down.heart.fill")
                            .foregroundColor(disliked ? .red : .gray)
                            .scaleEffect(disliked ? 0.97 : 1)
                            .animation(.spring(), value: disliked)
                            
                            .onTapGesture {
                                likes -= 1
                                disliked = true
                                liked = false
                            }
                        
                        HStack(spacing: 3.0){
                            Image(systemName: "arrow.uturn.up")
                                .foregroundColor(.gray)
                            Text("Comment")
                        } .font(.caption)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(textField ? .red : .clear)
                            .cornerRadius(15)
                            .onTapGesture {
                                textField = true
                            }
                        
                        Spacer()
                        
                    }
                }.padding()
                    .newoffwhite(offwhiteisTapped: false, cornerradius: 17)
                
                commentsection
            }
            .padding(20)
            .padding(.bottom, 120)
        }

      
    }
    var commentsection: some View {
        VStack(spacing:11) {
            commentComponent(comment: "Are u crazy ?")
            commentComponent(comment: "I think its possible that this guy is crazy ?")
            commentComponent(comment: "Are u crazy ?")
        }
    }
    var commentTextField: some View {
        VStack{
            Spacer()
            
           
               
                    
                HStack {
                    TextField("Comment" , text: $commentText)
                        .focused($textField)
                        .padding(.vertical,13)
                        .padding(.leading, 19)
                        .newoffwhite(offwhiteisTapped: false, cornerradius: 20)
                       
                       
                        
                    
                    Button(action: commentFunc) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                            .neumorphiccircle(padding: -4, opacity: 1)
                    }
                    
                }.padding(.horizontal, 20)
                    .padding(.vertical, 10)
                .animation(.spring(), value: textField)
                .background(
                    GeometryReader { geometry in
                        
                        Color("offwhite")
                            .frame(height: 100)
                            .cornerRadius(30)
                            .edgesIgnoringSafeArea(.bottom)
                        
                        
                        
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
           
               
                    if offset < -20 {
                        withAnimation(.easeInOut) {
                        contentHasScrolled = true
                        }
                        //  commentText = "\(offset)"
                    }
                  
                    else {
                        withAnimation(.easeInOut) {
                           
                            contentHasScrolled = false
                            //  commentText = "\(offset)"
                        }
                        
                        
                    }
                    
                
            
        }
    }

    
    func commentFunc(){
        
    }
    
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(section: .constant(postData[0]))
       // ViewController()
            .preferredColorScheme(.dark)
    }
}


struct commentComponent: View{
    @State var likes = 0
    @State var liked = false
    @State var disliked = false
    @State var show = false
    var comment = ""
    
    var body: some View{
        VStack(alignment: .leading, spacing: 8) {
            
            VStack {
                HStack{
                    Image("ob1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                        .frame(width: 40, height: 40)
                        .cornerRadius(30)
                    VStack(alignment: .leading) {
                        Text("section")
                        HStack {
                 
                            Text("post.timeposted")
                                .font(.caption)
                        }
                    }
                    Spacer()
                  
        }
                if likes >= 0 || show{
        VStack(alignment: .leading){
            
            HStack {
                Text(comment)
                    .lineLimit(2)
                .font(.footnote)
                Spacer()
            }
            
        }.padding(.vertical, 10)
        
        
        HStack{
            Image(systemName: "arrow.up.heart.fill")
                .foregroundColor(liked ? .blue : .gray)
                .onTapGesture {
                    likes += 1
                    liked = true
                    disliked = false
                }
            Text(likes == 0 ? "Vote" : "\(likes)")
                .font(.caption)
            Image(systemName: "arrow.down.heart.fill")
                .foregroundColor(disliked ? .red : .gray)
                .onTapGesture {
                    likes -= 1
                    disliked = true
                    liked = false
                }
            
            Spacer()
            
        }
        }
            }.padding()
              //  .cornerRadius(17)
             
             .newoffwhite(offwhiteisTapped: true, cornerradius: 17)
            
            
        }.onTapGesture {
            show.toggle()
        }
       // Divider()
       
    }
}
