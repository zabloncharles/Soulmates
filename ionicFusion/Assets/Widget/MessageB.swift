
import SwiftUI

struct MessageBubble1: View {
    
    
    var section: Message
    @State var messageTapped = false
    var message = "You still tryna go"
    var messageTime = "2:30 PM"
    @Binding var blurPage : Bool
    @Binding var messageDeleted : Bool
    var bTapped = 0
    var body: some View {
        
        if section.sender {
            
            HStack {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 100, height: 20)
                Spacer()
                VStack(alignment: .trailing, spacing: 2.0) {
                    ZStack {
                     
                            VStack {
                                if blurPage && bTapped == Int(section.documentID) {
                                    HStack {
                                        HStack {
                                            Image(systemName: "hand.thumbsup")
                                            Text("Like")
                                                .foregroundColor(.green)
                                        }.padding(5).offwhitebutton(isTapped: !blurPage, isToggle: true, cornerRadius: 5, action: $blurPage)
                                        Rectangle()
                                            .fill(Color.black)
                                            .frame(width: 0.4, height: .infinity)
                                        HStack {
                                            Image(systemName: "trash")
                                            Text("Delete")
                                                .foregroundColor(.red)
                                        }.padding(5).offwhitebutton(isTapped: !blurPage, isToggle: true, cornerRadius: 5, action: $messageDeleted)
                                    }.font(.footnote)
                                        .padding(10)
                                        .background(.ultraThinMaterial)
                                        .cornerRadius(10)
                                        .offset(y: -60)
                                }
                            }
                        Text(section.text)
                            .font(.subheadline)
                            .padding(.horizontal, 11.0)
                            .padding(.vertical, 9.0)
                            .background(Color.gray.opacity(0.2))
                            .offwhitebutton(isTapped: blurPage, isToggle: false, cornerRadius: 19, action: .constant(false))
                        .padding(.bottom,9)
                    }
                   
                    
                    
                    Text("\(formatDate(time:section.timestamp))")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 3.0)
                    
                }
                .padding(.horizontal)
                .multilineTextAlignment(.leading)
                .animation(.spring(), value: blurPage)
            }
        } else {
            
            HStack {
                
                VStack(alignment: .leading, spacing: 2.0) {
                    ZStack {
                        
                            
                                if blurPage && bTapped == Int(section.documentID) {
                                    HStack {
                                        HStack {
                                            Image(systemName: "hand.thumbsup")
                                            Text("Like")
                                                .foregroundColor(.green)
                                        }.padding(5).offwhitebutton(isTapped: !blurPage, isToggle: true, cornerRadius: 5, action: $blurPage)
                                        Rectangle()
                                            .fill(Color.black)
                                            .frame(width: 0.4, height: .infinity)
                                        HStack {
                                            Image(systemName: "trash")
                                            Text("Delete")
                                                .foregroundColor(.red)
                                        }.padding(5).offwhitebutton(isTapped: !blurPage, isToggle: true, cornerRadius: 5, action: $messageDeleted)
                                    }.font(.footnote)
                                        .padding(10)
                                       // .background(Color("black"))
                                        .background(.ultraThinMaterial)
                                        .cornerRadius(10)
                                        .offset(y: -60)
                                }
                            
                        VStack {
                            Text(section.text)
                                .foregroundColor(.white)
                                .font(.subheadline)
                                .padding(.horizontal, 11.0)
                                .padding(.vertical, 9.0)
                                .background(Color.blue)
                                .offwhitebutton(isTapped: blurPage, isToggle: false, cornerRadius: 9, action: .constant(false))
                            .padding(.bottom,9)
                        }
                          
                    }
                       
                    
                    
                    Text("\(formatDate(time:section.timestamp))")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 3.0)
                }
                .padding(.horizontal)
                .multilineTextAlignment(.leading)
                
                
                Spacer()
                
                Rectangle()
                    .fill(.clear)
                    .frame(width: 100, height: 20)
            }.animation(.spring(), value: blurPage)        }
    }
    func formatDate(time:String) -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timedate = dateFormatter.date(from: time) ?? Date()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: timedate)
        
    }
}

struct MessageBubblle_Previews: PreviewProvider {
 
    static var previews: some View {
        //VStack {
         //   ForEach(fakeMessages) { item in
             //   MessageBubble1(section: item, blurPage: .constant(false))
           // }
       // }
        ViewController()
    }
}


var fakeMessages = [
    Message(documentID: "0", name: "John", text: "?", sender: true, timestamp: "10:30 AM"),
    Message(documentID: "1", name: "John", text: "Hello", sender: true, timestamp: "10:30 AM"),
    Message(documentID: "2", name: "Alice", text: "Hi there", sender: false, timestamp: "10:35 AM"),
    Message(documentID: "3", name: "John", text: "How are you?", sender: true, timestamp: "10:40 AM"),
    Message(documentID: "4", name: "Alice", text: "I'm doing great!", sender: false, timestamp: "10:45 AM"),
    Message(documentID: "5", name: "John", text: "What have you been up to?", sender: true, timestamp: "11:00 AM"),
    Message(documentID: "6", name: "Alice", text: "Just working on some projects", sender: false, timestamp: "11:15 AM"),
    Message(documentID: "7", name: "John", text: "That's great!", sender: true, timestamp: "11:30 AM"),
    Message(documentID: "8", name: "Alice", text: "I'm learning new technologies too", sender: false, timestamp: "11:45 AM"),
    Message(documentID: "9", name: "John", text: "We should catch up sometime", sender: true, timestamp: "12:00 PM"),
    Message(documentID: "10", name: "Alice", text: "Definitely! Let's plan something", sender: false, timestamp: "12:15 PM"),
    Message(documentID: "11", name: "John", text: "Sure, how about next week?", sender: true, timestamp: "12:30 PM"),
    Message(documentID: "12", name: "Alice", text: "Sounds good to me!", sender: false, timestamp: "12:45 PM"),
    Message(documentID: "13", name: "John", text: "Great! I'll send you the details", sender: true, timestamp: "1:00 PM"),
    Message(documentID: "14", name: "Alice", text: "Looking forward to it!", sender: false, timestamp: "1:15 PM"),
    Message(documentID: "15", name: "John", text: "See you soon!", sender: true, timestamp: "1:30 PM"),
// Add more fake messages as needed
]
