
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct MessageBubble1: View {
    
    
    var section: Message
    @State var messageTapped = false
    var message = "You still tryna go"
    var messageTime = "2:30 PM"
    @Binding var blurPage : Bool
    @Binding var messageDeleted : Bool
    var bTapped = 0
    var body: some View {
        
        if getUserId() == section.sender {
            
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
                   
                    
                    
                    Text(section.stamp)
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
                       
                    
                    
                    Text(section.stamp)
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
        
        let timedate = dateFormatter.date(from: time) ?? Date()
       // dateFormatter.dateFormat = "MMM d, yyyy 'at' h:mm:ss a"
       dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: timedate)
        
    }
    
    func getUserId() -> String{
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        
        return user?.email ?? ""
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

