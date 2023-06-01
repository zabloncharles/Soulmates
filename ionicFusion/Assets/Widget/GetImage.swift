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

struct GetImageAlert: View {
    @State private var image: Image?
    @State var url = ""
    @Binding var loaded : Bool
    
    
    var body: some View {
        VStack {
            if url == "loading" {
                LottieView(filename: "paperplaneloading" ,loop: true)
                    .frame(width: 400)
            } else {
                if let image = image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .animation(.easeIn, value: loaded)
                        .onAppear{
                            
                            loaded = true
                            
                        }
                    
                    
                } else {
                    
                    LottieView(filename: "paperplaneloading" ,loop: true)
                        .frame(width: 400)
                    
                    
                    
                    
                }
            }
          
        }
        .onAppear {
            loadImageFromAPI()
        }
    }
    
    func loadImageFromAPI() {
       
        guard let url = URL(string:  url.isEmpty ? "https://source.unsplash.com/random/?female,beautiful" :  url) else {
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

struct GetImage: View {
    @State private var image: Image?
    
    
    var body: some View {
        VStack {
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                
            } else {
             
                    LottieView(filename: "paperplaneloading" ,loop: true)
                        .frame(width: 400)
                    
                
                  
               
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

struct ImageViewer: View {
    @State private var image: Image?
    var url : String
    @State var spin = false
    var body: some View {
        VStack {
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: spin ? 10 : 0)
                    .onAppear{
                        withAnimation(.spring()) {
                            spin = false
                        }
                    }
            } else {
                Image("image_02")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: spin ? 20 : 0)
                    .onAppear{
                        withAnimation(.spring()) {
                            spin = true
                        }
                    }
            }
        }
        .onAppear {
            loadImageFromAPI()
        }
    }
    
    func loadImageFromAPI() {
        guard let url = URL(string: url.count > 1 ? url : "https://source.unsplash.com/random/?female,beautiful") else {
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
