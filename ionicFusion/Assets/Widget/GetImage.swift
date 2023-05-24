//
//  GetImage.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/23/23.
//

import SwiftUI



struct GetImage_Previews: PreviewProvider {
    static var previews: some View {
        GetImage()
    }
}


struct GetImage: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Text("Image loading...")
               
            }
        }
        .onAppear {
            loadImageFromAPI()
        }
    }
    
    func loadImageFromAPI() {
        guard let url = URL(string: "https://source.unsplash.com/random/?female,beautiful") else {
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
            }
        }.resume()
    }
}
