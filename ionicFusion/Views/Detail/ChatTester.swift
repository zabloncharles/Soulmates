//
//  ChatTester.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/20/23.
//

import SwiftUI

struct ChatTester: View {
    @State var chatMessages: [MessageTester] = []
    @State var sentMessage = "Nothing"
    var body: some View {
       
            VStack {
                // Display the chat messages here
                
                ForEach(chatMessages.indices, id: \.self) { index in
                    HStack {
                        Spacer()
                        VStack {
                            HStack {
                                Spacer()
                                
                            }
                           
                        }
                    }.padding(10)
                }
                
                TextField("Type your message", text: $sentMessage)
                    .padding(.vertical)
                    .padding(.leading, 55)
                
               // Button("Add Fake Message") {
                Button("Add Fake Message") {
                    // Generate and add a fake message to the chat
                    let fakeMessage = MessageTester(
                        text: sentMessage,
                        sender: "User",
                        timestamp: Date()
                    )
                    chatMessages.append(fakeMessage)
                }
            }
        }
    }


struct ChatTester_Previews: PreviewProvider {
    static var previews: some View {
        ChatTester()
    }
}


struct MessageTester: Identifiable {
    let id = UUID()
    let text: String
    let sender: String
    let timestamp: Date
}
