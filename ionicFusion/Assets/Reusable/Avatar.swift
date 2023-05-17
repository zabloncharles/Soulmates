//
//  Avatar.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 3/7/22.
//
import SwiftUI

struct Avatar: View {
    @ObservedObject var viewModel = UserViewModel()
   
    var body: some View {
        
        VStack {
            ForEach(viewModel.userinfo) { user in
                AsyncImage(url: URL(string: "\(user.avatar)")) { phase in
                    switch phase {
                        case .empty:
                          //  ProgressView()
                            Image(systemName: "person.crop.circle")
                                .font(.largeTitle)
                        case .success(let image):
                            image.resizable()
                        case .failure(_):
                            
                            Image(systemName: "person.crop.circle")
                                .font(.largeTitle)
                        @unknown default:
                          //  Color.gray
                            Image(systemName: "person.crop.circle")
                                .font(.largeTitle)
                    }
                }
            }
        }
        
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
       // Avatar()
        ViewController()
    }
}
