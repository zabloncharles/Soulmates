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
    var width : CGFloat = 0
    var height : CGFloat = 0
    @Binding var loaded : Bool
    @Binding var imageUrl : String
    
    
    var body: some View {
       VStack {
            
              
                    if image != nil {
                        
                       
                            image!
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: height != 0 ? width : nil, height: height != 0 ? height : nil)
                                .contentShape(Rectangle())
                                .clipped()
                                
                                .onAppear{
                                    loaded = true
                                }
                               
                      
                        
                        
                    } else {
                        
                        LottieView(filename: "paperplaneloading" ,loop: true)
                            .frame(width: 400)
                    }
                
               
            
        }
            .frame(width: height != 0 ? width : nil, height: height != 0 ? height : nil)
          
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


