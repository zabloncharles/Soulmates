//
//  Api.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 2/25/22.
//

import SwiftUI
import Foundation

//MARK: MODEL
struct Post: Codable{
   
    var date: String
    var name: String
}


//MARK: VIEW MODEL
class Api {
    func getPosts (completion: @escaping ([Post]) -> ()) {
        
        guard let url = URL(string: "https://date.nager.at/api/v3/PublicHolidays/2022/AT") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let posts = try! JSONDecoder().decode([Post].self, from: data!)
            
            DispatchQueue.main.async {
                completion(posts)
            }
        }
        .resume()
    }
}

//MARK: VIEW
struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var posts: [Post] = []
    var pics = ["image_01", "image_02", "image_03", "image_04", "image_05", "image_06"]
    var columns: [GridItem] =
    [.init(.adaptive(minimum: 200, maximum: 200))]
    
    var body: some View {
        
        ZStack {
            Color.blue
            NavigationView {
                ScrollView {
                    
                    LazyVGrid(columns: columns) {
                        ForEach(posts, id: \.date) { post in
                            
                            
                            
                            VStack(alignment: .leading, spacing: 3) {
                                
                                
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.clear)
                                    .background(
                                        Image(pics.randomElement() ?? "ob1")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                         
                                        
                                    )
                                   
                                
                                    .shadow(color:  Color("black").opacity(0.6), radius: 10, x: 10, y: 10 )
                                    .shadow(color: Color("white").opacity(0.9),radius: 10, x: -5, y: -5)
                                    .cornerRadius(15)
                                    .background(
                                        Rectangle()
                                            .fill(Color("white"))
                                            .cornerRadius(15)
                                            .padding(-0.2)
                                            
                                        
                                    )
                                    .padding(-5)
                                
                                Spacer()
                                
                                Text(post.date)
                                    .font(.callout)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                                
                                Text(post.name)
                                    .font(.headline)
                                    .foregroundColor(Color("white"))
                            }
                            .padding()
                            .background(Color("black"))
                            .frame(width: 190, height: 300)
                            .cornerRadius(21)
                            .shadow(color: Color("black").opacity(colorScheme == .dark ? 0.0 : 0.3), radius: 10, x: 10, y: 10 )
                            .shadow(color: Color("white").opacity(0.9),radius: 10, x: -5, y: -5)
                            .padding()
                            
                            
                        }
                    }.padding(10)
                    
                }.navigationBarTitle("Holidays")
                
                .onAppear {
                    Api().getPosts { (posts) in
                        self.posts = posts
                    }
            }
            }
            
        }
    }
}

struct ContentViewProvider_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
