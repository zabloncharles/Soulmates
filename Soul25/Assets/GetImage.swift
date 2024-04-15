//
//  GetImage.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/23/23.
//

import SwiftUI

struct GetImageAndUrl: View {
    @State private var image: Image?
    @State var url = ""
    @Binding var loaded : Bool
    @Binding var imageUrl : String
    
    
    var body: some View {
       ZStack {
            
              
                    if image != nil {
                        image!
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxHeight:500)
                            .onAppear{
                                    loaded = true
                            }
                            .clipped()
                        
                    } else {
                        
                        LottieView(filename: "paperplaneloading" ,loop: true)
                            .frame(width: 400)
                    }
                
               
            
        }.contentShape(Rectangle())
           
        .onAppear {
            loadImageFromAPI()
        }
    }
    
    func loadImageFromAPI() {
        guard let url = URL(string: url.isEmpty ? "https://source.unsplash.com/random/?bikini,hotgirl" : url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = Image(uiImage: uiImage)
                }
                
                // Get the actual URL from the response
                if let httpResponse = response as? HTTPURLResponse {
                    let actualURL = httpResponse.url
                    imageUrl = ("\(actualURL?.absoluteString ?? "Unknown")")
                }
            }
        }.resume()
    }
}


