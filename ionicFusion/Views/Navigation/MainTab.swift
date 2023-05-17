//Created by Zablon Charles.


import SwiftUI

struct MainTab: View {
    @AppStorage("currentPage") var selected = 0
    @AppStorage("showAccount") var showAccount = false
    @AppStorage("hidemainTab") var hidemainTab = false
    @AppStorage("notifications") var showNotifications = false
    @AppStorage("editcalendar") var showEditCalendar = false
    @Namespace var namespace
    @State var course = Course(index: 1, title: "hey", subtitle: "what", text: "they", image: "image_02", background: "image_01", logo: "image_04")
   // @State var matchcard = MatchCardData(name: "", location: "", quote: "", profilepic: "", background: "", work: "", matchscore: "")
    @State var matchcard = matchCardData[0]
    @State var selectedSection = messageSections[0]
 

    var body: some View {
        
        ZStack {
            NavigationView {
                VStack{
                    
                    if self.selected == 0{
                        HomeView(course: $course, matchcard: $matchcard)
                            
                    }
                   if self.selected == 1{
                      LikesView()
                          
                    }
                    if self.selected == 2{
                       
                        StandoutsView(course: $course, matchcard: $matchcard)
                    }
                    if self.selected == 3{
                        NotificationsDetail(namespace: namespace, notification: $selectedSection)
                        
                    }
                }
            }
            
            FloatingTabbar(selected: self.$selected)
               
                .offset(y:  hidemainTab && (selected != 0)  ? UIScreen.main.bounds.height * 0.19 : 0)
                .animation(.spring(), value: hidemainTab)
        }
        
    }
}


struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
       // MainTab( course: .constant(Course))
        ViewController()
           // .preferredColorScheme(.dark)
            
    }
}

struct FloatingTabbar : View {
    
    @Binding var selected : Int
    @Namespace var namespace
    @State var tappedicon = false
    let generator = UINotificationFeedbackGenerator()
    
    var body : some View{
        
        VStack(){
        
        GeometryReader { proxy in
            let hasHomeIndicator = proxy.safeAreaInsets.bottom > 0
           
            
            HStack( alignment: .center, spacing: 10.0){
                
                  
                TabIcon(selected: $selected, selectedicon: 0, icon: "house", tappedicon: $tappedicon )
                TabIcon(selected: $selected, selectedicon: 1, icon: "fleuron", tapped: "", tappedicon: $tappedicon )
                TabIcon(selected: $selected, selectedicon: 2, icon: "person.2" , tappedicon: $tappedicon )
                TabIcon(selected: $selected, selectedicon: 3, icon: "bubble.left.and.bubble.right" , tapped: "" , tappedicon: $tappedicon )
           
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: hasHomeIndicator ? 64 : 64)
          
            .background(Color("offwhite"))
           
            .background(Image("cover2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            
                            .offset(x: self.selected == 0 ? -90 : self.selected == 1 ?  -20 : self.selected == 2 ? 40 :self.selected == 3 ? 90 : 0)
                            
                            //.animation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 1), value: $tappedicon)
                            .animation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 1), value: selected)
                            
                           
            )
           // .cornerRadius( 30)
            .newoffwhite(offwhiteisTapped: false, cornerradius: 30)
            .scaleEffect(tappedicon ? 0.97 : 1)
            .animation(.spring(), value: tappedicon)
            .padding(.horizontal, 80.0) //makes tabbar smaller
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            
            
        }
       
        
        }
    }
    
 
}





struct TabIcon: View {
    @Binding var selected : Int
    var selectedicon : Int = 0
    var icon : String = "person"
    var tapped: String = ".fill"
    let generator = UINotificationFeedbackGenerator()
    @Binding var tappedicon : Bool
   
    var body: some View {
        Button(action: {
            self.selected = selectedicon
            
            vibrate()
            
            tappedicon = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                tappedicon = false
            }
        }) {
            VStack{
                Image(systemName: self.selected == selectedicon ? "\(icon)\(tapped)" : icon)
                    .foregroundColor(self.selected == selectedicon ? .red  : .gray).padding(.horizontal)
                   // .shadow(color:  Color.white.opacity(0.1), radius: 1.2, x:tappedicon ? -1 : 1, y:tappedicon ? -1 : 1 )
                   // .shadow(color: Color.black.opacity(0.5),radius: 1.2, x:tappedicon  ? 1 : -1, y:tappedicon  ? 1 : -1)
                    .background(Circle()
                                    .fill(self.selected == selectedicon ? .red : .clear)
                                    .animation(.spring(), value: tapped)
                                    .frame(width: 40, height: 30)
                                    .blur(radius: 19)
                                    .opacity(0.4)
                    )
                    
                                    
                if self.selected == selectedicon {
                    
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.4, blendDuration: 1)) {
                        Rectangle()
                            .fill(.red)
                            .frame(width: 8, height: 1)
                            
                    }
                   
                     
                     
                       
                        
                } else {
                    Rectangle()
                       .fill(.red)
                       .frame(width: 8, height: 1)
                       .opacity(0)
                    
                }
                
            }
             
        }
    }
    func vibrate() {
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
}
}
