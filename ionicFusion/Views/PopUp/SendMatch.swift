//
//  SendMatch.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/28/23.
//

import SwiftUI


struct SendMatch: View {
    @State var erro = ""
    @State var text = ""
    
    
    
    
    var body: some View {
        ZStack{
            Color.black
            navbar
         
            likedcontent
        }
    }
    var matchimage: some View {
        VStack{
            
            
            VStack {
                GetImageAndUrl(url:"", loaded: .constant(true), imageUrl: .constant(""))
                
                    .frame(width: 400 , height: 430)
            }.offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 20, action:  .constant(false))
            
            
            
            
            
        }
        
    }
    var navbar: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    HStack {
                        Image(systemName: "person.2.fill")
                        Text(erro.isEmpty ? "You Liked :)" : erro)
                        
                    }.font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                    HStack {
                        Image(systemName: "fleuron")
                        Text("Boost")
                    }.padding(.horizontal,12)
                        .padding(.vertical,5)
                        .background(Color.blue.opacity(0.3))
                        .cornerRadius(20)
                    
                }
                HStack { Image(systemName: "quote.opening")
                    Text("As seen on my mom's fridge")
                    Image(systemName: "quote.closing")
                }
            }.padding(15).offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 15, action:  .constant(false))
            
            Spacer()
        } .padding(.horizontal, 20)
            .padding(.top, 20)
    }
    var likedcontent: some View {
        
        VStack {
            matchimage
            HStack {
                TextField("Send a message", text: $text)
                    .padding(.vertical,16)
                    .padding(.leading, 55)
                    .foregroundColor(Color("black"))
                    .background(Color("offwhite"))
                    .cornerRadius(25)
                    .overlay(  Image(systemName: "pencil.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .offset(x: -139)
                    )
                    .offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 25, action:  .constant(false))
                    .padding(.horizontal,0)
                
                
                HStack {
                    Image(systemName: "paperplane")
                        .font(.headline)
                        .foregroundColor(.white)
                        .onTapGesture {
                            sendMatchMessage(text: text)
                        }
                }.padding()
                    .background(Color.pink)
                
                .offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 30, action:  .constant(false))
                   
                    
                
            }.padding(.top,20)
            
            
            Text("Cancelt")
                .padding(.vertical,10)
                .padding(.horizontal,20)
                .background(Color.pink)
                .offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 30, action:  .constant(false))
                .padding(.top,20)
        }.padding(.horizontal, 20)
        
    }

    func sendMatchMessage(text: String) {
        
//        
//        let user = Auth.auth().currentUser
//        let db = Firestore.firestore()
//        
//        // Data for the new document
//        
//        
//        // Add a placeholder for the document ID
//        let docRef = db.collection("messages").document()
//        
//        
//        // Add the document with the modified data
//        docRef.setData(["docid": docRef.documentID,
//                        "matched": true,
//                        "time":  Date(),
//                        "email": [user?.email ?? "" , "zab.charles@gmail.com"]
//                        // Add other fields as needed
//                       ], merge: false) { error in
//            if let error = error {
//                // Handle error
//            } else {
//                // Data added successfully
//            }
//        }
        
    }

}

struct SendMatch_Previews: PreviewProvider {
    static var previews: some View {
        SendMatch()
    }
}
