
import SwiftUI

struct MessageBubble1: View {
    
    
    var section: Message
    @State var messageTapped = false
    var message = "You still tryna go"
    var messageTime = "2:30 PM"
    var body: some View {
        
        if section.sender {
            
            HStack {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 100, height: 20)
                Spacer()
                VStack(alignment: .trailing, spacing: 2.0) {
                    Text(section.text)
                        .font(.subheadline)
                        .padding(.horizontal, 11.0)
                        .padding(.vertical, 9.0)
                        .background(Color.gray)
                        .cornerRadius(9)
                        .padding(.bottom,9)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                messageTapped.toggle()
                            }
                        }
                    
                    
                    Text("\(formatDate(time:section.timestamp))")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 3.0)
                }
                .padding(.horizontal)
                .multilineTextAlignment(.leading)
            }
        } else {
            
            HStack {
                
                VStack(alignment: .leading, spacing: 2.0) {
                    Text(section.text)
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding(.horizontal, 11.0)
                        .padding(.vertical, 9.0)
                        .background(.blue)
                        .cornerRadius(9)
                        .padding(.bottom,9)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                messageTapped.toggle()
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
            }
        }
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
        //  MessageBubble()
        ViewController()
    }
}


