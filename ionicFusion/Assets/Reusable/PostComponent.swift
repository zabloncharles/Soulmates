//
//  Post.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 3/22/22.
//

import SwiftUI

struct PostComponent: View {
    var post: PostModel
    var tapped = false
    @State var likes = 0
    @State var liked = false
    @State var disliked = false
    
    var body: some View {
        VStack {
            HStack{
                Image(post.avatar)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                    .frame(width: 40, height: 40)
                    .cornerRadius(30)
                VStack(alignment: .leading) {
                    Text(post.username)
                        .foregroundColor(Color("black"))
                    HStack {
                        Text(post.topic)
                            .font(.caption)
                        Text("-")
                            .font(.caption)
                        Text(post.timeposted)
                            .font(.caption)
                    }.foregroundColor(Color("black"))
                }
                Spacer()
                VStack {
                    HStack(spacing:1) {
                        Image(systemName: "eye.circle")
                        Text(post.views)
                            .font(.caption)
                            .foregroundColor(Color("black"))
                    }
                    
                    
                }
            }
            VStack(alignment: .leading){
                HStack {
                    Text(post.post)
                        .foregroundColor(Color("black"))
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
                    .foregroundColor(Color("black"))
                Image(systemName: "arrow.down.heart.fill")
                    .foregroundColor(disliked ? .red : .gray)
                    .onTapGesture {
                       likes -= 1
                        disliked = true
                        liked = false
                    }
                
                Spacer()
                
            }
        }.padding()
            .newoffwhite(offwhiteisTapped: tapped, cornerradius: 17)
    }
}

struct PostComponent_Previews: PreviewProvider {
    static var previews: some View {
      //  PostComponent(post: postData[0])
        ViewController()
    }
}


