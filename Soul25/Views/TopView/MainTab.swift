//Created by Zablon Charles.


import SwiftUI


struct MainTab: View {
    @State var currentUser: UserStruct? = fakeUser // Variable to hold the user data
    @AppStorage("currentPage") var selected = 0
    @AppStorage("hidemainTab") var hidemainTab = false
   
 

    var body: some View {
        
        ZStack {
            BackgroundView()
            NavigationView {
                VStack{
                    
                    if self.selected == 0{
                        MatchView( currentUser: $currentUser)
                    }
                   if self.selected == 1{
                       LikesView(currentUser: $currentUser)
                          
                      
                    }
                    if self.selected == 2{
                        
                        HomeView(currentUser: $currentUser)
                    }
                    if self.selected == 3{
                       ChatsView()
                        
                    }
                    if self.selected == 4{
                    
                        ProfileView(currentUser: $currentUser)
                    }
                }
            }
            
            
            FloatingTabbar(selected: self.$selected)
                .offset(y:  hidemainTab  ? UIScreen.main.bounds.height * 0.13 : 0)
                .animation(.spring(), value: hidemainTab)
               
            
            
            
            
            
                
        }.onAppear{
           // fetchCurrentUser()
            fetchFakeUser()
        }
        
    }
    
    func fetchFakeUser(){
        
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
           
               
                HStack( alignment: .center, spacing: 17.0){
               
                  
                TabIcon(selected: $selected, selectedicon: 0, icon: "rectangle.portrait.on.rectangle.portrait.angled", name:"Match" ,tappedicon: $tappedicon )
                Spacer()
                TabIcon(selected: $selected, selectedicon: 1, icon: "fleuron",name:"Likes" , tappedicon: $tappedicon )
                Spacer()
                TabIcon(selected: $selected, selectedicon: 2, icon: "person.2" , name:"Explore" ,tappedicon: $tappedicon )
                Spacer()
                TabIcon(selected: $selected, selectedicon: 3, icon: "bubble.left.and.bubble.right",name:"Chats" , tappedicon: $tappedicon )
                Spacer()
                TabIcon(selected: $selected, selectedicon: 4, icon: "person.2.badge.gearshape",name:"Profile" , tappedicon: $tappedicon )
                
         
           
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: hasHomeIndicator ? 64 : 64)
            .padding(.horizontal,20)
             .background(
                GeometryReader { geometry in
                    Rectangle()
                        .fill(Color("black").opacity(0.10))
                        .frame(height: 1)
                        .padding(.bottom, geometry.size.height) // Position the border at the bottom
                }
            )
             .background(Color("offwhiteneo"))
            .background(Image("cover2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            
                            .offset(x: self.selected == 0 ? -90 : self.selected == 1 ?  -20 : self.selected == 2 ? 40 :self.selected == 3 ? 90 : 0)
                            .animation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 1), value: selected)
                            
                           
            )
            
//            .offwhitebutton(isTapped: tappedicon, isToggle: false, cornerRadius: 36, )
         //   .background(.ultraThinMaterial)
           // .cornerRadius(36)
//            .scaleEffect(tappedicon ? 0.97 : 1)
            .animation(.spring(), value: tappedicon)
//            .padding(.horizontal, 61.0) //makes tabbar smaller
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
    var name = "Name"
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
            VStack(spacing:2){
                VStack {
                    Image(systemName: self.selected == selectedicon ? "\(icon)\(tapped)" : icon)
                        .foregroundColor(self.selected == selectedicon ? .red  : .gray).padding(.horizontal)
                        .background(Circle()
                                        .fill(self.selected == selectedicon ? .red : .clear)
                                        .animation(.spring(), value: tapped)
                                        
                                        .blur(radius: 19)
                                        .opacity(0.4)
                    )
                }.frame(width: 40, height: 30)
                if self.selected == selectedicon {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.4, blendDuration: 1)) {
                        Rectangle()
                            .fill(.red)
                            .frame(width: 8, height: 1)
                    }
                }
                Text(name)
                    .font(.footnote)
                    .foregroundColor(self.selected == selectedicon ? .red : .gray)
            }
             
        }
    }
    func vibrate() {
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
}
}
