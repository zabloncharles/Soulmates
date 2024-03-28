//
//  UserImageView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 3/27/24.
//

import SwiftUI
import URLImage


struct UserImageView: View {
    let imageURL: URL
    
    var body: some View {
        URLImage(imageURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
            Text(imageURL.absoluteString)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 500, height: 500) // Adjust the frame size as needed
    }
}

struct ContentViewfe: View {
    var body: some View {
        UserImageView(imageURL: URL(string: "https://source.unsplash.com/random/?female,beautiful")!)
    }
}

struct UserImageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewfe()
    }
}
