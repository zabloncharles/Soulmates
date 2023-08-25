//
//  UserViewModel.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 3/4/22.
//
import Firebase
import SwiftUI

class UserViewModel: ObservableObject {
    @AppStorage("saveinfo") var saveinfo = ""
    @Published var userinfo: [User] = []
    @Published var imageURL = ""
    
    
    
    init() {
      
        addInfo()
        
    }
    
//    func addInfo(){
//      
//        // Get a reference to the database
//        let db = Firestore.firestore()
//        let user = Auth.auth().currentUser
//        
//        db.collection("users").whereField("email", isEqualTo: user?.email ?? "")
//            .getDocuments() { (querySnapshot, error) in
//                if error != nil {
//                    //   print("Error getting documents: \(err)")
//                    
//                   // self.userinfo = falseData
//                } else {
//                    for document in querySnapshot!.documents {
//                        //  print("\(document.documentID) => \(document.data())")
//                        //  userName = document.documentID
//                        
//                        let docRef = db.collection("users").document("\(document.documentID)")
//                        
//                        docRef.getDocument { (document, error) in
//                            if let document = document, document.exists {
//                             
//                               
//                             
//                                let firstname = (document.get("firstName") ?? "error") as! String
//                                let lastname = (document.get("lastName") ?? "error") as! String
//                                let notifications = "9"
//                                let period = "9"
//                                let pregnancy = "High"
//                                let avatar = (document.get("avatar") ?? "error") as! String
//                                let cyclechange = (document.get("cycle") ?? "01/04/2022") as! String
//                                let birthday = (document.get("age") ?? "error") as! String
//                                let email = (document.get("email") ?? "error") as! String
//                                
//                                
//                                self.userinfo = [
//                                    User(fname: firstname,
//                                         lname: lastname,
//                                         notifications: notifications,
//                                         avatar: avatar,
//                                         cyclechange: cyclechange,
//                                         birthday: birthday,
//                                         email: email
//                                        )
//                                ]
//                                
//                                self.saveinfo = "\(firstname),\(lastname),\(notifications),\(period),\(pregnancy),\(cyclechange),\(birthday),\(email)"
//                                
//                            } else {
//                                // signedIn = false
//                              //  self.userinfo = falseData
//                            }
//                        }
//                        
//                        
//                    }
//                }
//            }
//        
//        
//    }
   
    func convertAge(lastperiod: Date) -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "M/dd/yyyy"
        
        let date = formatter.string(from: lastperiod)
        let tes = "\(date)"
        
        let birthday = formatter.date(from: ("\(tes)"))
        let timeInterval = birthday?.timeIntervalSinceNow
        let age = abs(Int(timeInterval! / 31556926.0))
        
        
       return String(age)
      
    }
  
    
    func compare(thisDate: String) -> String{
        let result = calculateDaysBetweenTwoDates(start: Date(), end: stringtodate(whatsthedateinstring: thisDate))
        
        return String(result)
    }
    
    func stringtodate(whatsthedateinstring: String) -> Date {
        
        let isoDate = whatsthedateinstring
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MM/dd/yyyy"
        guard let date = dateFormatter.date(from:isoDate) else { return Date() }
        
        
        
        return date
    }
    
    private func calculateDaysBetweenTwoDates(start: Date, end: Date) -> Int {
        
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: .day, in: .month, for: start) else {
            return 0
        }
        guard let end = currentCalendar.ordinality(of: .day, in: .month, for: end) else {
            return 0
        }
        return end - start
    }
    
    
}



struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        
        ViewController()
            .preferredColorScheme(.dark)
        
    }
}
