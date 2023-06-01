//
//  ProfileEditView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/31/23.
//
import SwiftUI

struct ProfileEditView: View {
    @State var profile: UserStruct = fakeUser
        @AppStorage("hidemainTab") var hidemainTab = false
        var isAnimated = true
        @State var viewState: CGSize = .zero
        @State var text = ""
        @State var erro = ""
        @State var typeText = ""
        @State var animateapper = false
        @State var showMore = false
        @State var isEditing = false
        @State var age = ""
        @State var isPickerVisible = false
        @State var scrolledItem = 0
    @State var editItem = 0
    @State var blurBackground = false
    @State var showWorkPicker = false
      
    let options = ["HealthCare", "Tech", "Care", "Insurance", "Education"]
        @State var selectedOption: String?
        
        var body: some View {
            
            
            ZStack {
                
                BackgroundView()
                
                ZStack {
                    
                    
                    ScrollView {
                        
                        cover
                            .background(scrollDetection)
                        
                        
                        content
                            .background(
                                LinearGradient(colors: [Color("offwhite"),Color.clear], startPoint: .bottom, endPoint: .top)
                               // Color("offwhite")
                                    .offset(y:254))
                        
                        
                        
                    }
                    .coordinateSpace(name: "scroll")
                    .mask(RoundedRectangle(cornerRadius: viewState.width / 3))
                    .scaleEffect(-viewState.width/500 + 1)
                    .gesture(drag)
                    
                    .ignoresSafeArea()
                    .blur(radius: blurBackground ? 40 : 0)
                    
                    
                    
                
                   
                    
                    //MARK: Get work sector
                    if editItem == 1 {
                        NameChangePicker(done: $editItem)
                            .onDisappear{
                                withAnimation(.spring()) {
                                    blurBackground = false
                                }
                            }
                            .onAppear{
                                withAnimation(.spring()) {
                                    blurBackground = true
                                }
                            }
                      
                           
                    }
                    if editItem == 2 {
                        
                        AboutMePicker(done: $editItem)
                            .onDisappear{
                                withAnimation(.spring()) {
                                    blurBackground = false
                                }
                            }
                        
                    }
                     if editItem == 3 {
                       
                        UniversityView(done: $editItem)
                            .onDisappear{
                                withAnimation(.spring()) {
                                    blurBackground = false
                                }
                            }
                        
                    }
                    if editItem == 4 {
                      
                        
                        WorkPicker(done: $editItem)
                            .onDisappear{
                                withAnimation(.spring()) {
                                    blurBackground = false
                                }
                            }
                            .onAppear{
                                withAnimation(.spring()) {
                                    blurBackground = true
                                }
                            }
                    }
                    
                 

                }
                    .offset(y: !animateapper ? UIScreen.main.bounds.height * 1.02 : 0)
                    .onAppear{
                        hidemainTab = false
                        withAnimation(.spring()) {
                            animateapper = true
                        }
                    }
                    .onDisappear{
                        hidemainTab = false
                        withAnimation(.spring()) {
                            animateapper = false
                        }
                    }
                
                
                
                
         //MARK: name and heart icon
                    nameandheart
                
            }
            
            
            
            
            
            
            
            
            
        }
        var nameandheart: some View{
            VStack {
                HStack {
                    HStack {
                        TextWriterAppear(typeText: profile.firstname, speed: 0.03)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        
                    } .padding(10)
                        .background(.ultraThinMaterial.opacity(0.97))
                        .cornerRadius(15)
                        .onTapGesture {
                            editItem = 1
                        }
                    
                    Spacer()
                
                }.padding(.horizontal,25)
              
                
                Spacer()
            }//.blur(radius: liked ? 50 : 0)
            .overlay(  VStack {
                HStack {
                    Spacer()
                    VStack(spacing: 18.0) {
                        Image(systemName: "gear")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                            .rotationEffect(.degrees(0))
                            .animation(.linear.speed(0.03), value: isEditing)
                            .padding(2)
                            .neoButtonOff(isToggle: false, cornerRadius: 5) {
                                //
                            }
                       Rectangle()
                            .frame(width:16.4, height: 1.3)
                        Image(systemName: "pencil.slash")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .rotationEffect(.degrees(isEditing ? 180 : 0))
                            .animation(.linear.speed(0.03), value: isEditing)
                            .padding(2)
                            .neoButtonOff(isToggle: true, cornerRadius: 5) {
                                //
                                withAnimation(.spring()) {
                                    isEditing.toggle()
                                    blurBackground = false
                                    editItem = 0
                                }
                            }
                    }.padding(.vertical,15)
                        .padding(.horizontal,8)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                }.padding(.horizontal,15)
                Spacer()
            })
        }
        var cover: some View {
            GeometryReader { proxy in
                let scrollY = proxy.frame(in: .named("scroll")).minY
                
                VStack {
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height: scrollY > 0 ? 500 + scrollY : 500)
                
                .overlay(
                     // Image("image_09")
                      //    .resizable()
                    //  .aspectRatio(contentMode: .fill)
                    VStack{
                        if isEditing {
                            GetImageAlert(url: "loading",loaded: .constant(false))
                                .offset(y: scrollY > 0 ? -scrollY : 0)
                                .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                                .blur(radius: scrollY > 0 ? scrollY / 10 : 0)
                                .accessibility(hidden: true)
                                .overlay(
                                    VStack {
                                        
                                        HStack {
                                            Image(systemName: "pencil.slash")
                                                .font(.body).bold()
                                            Text("Click anything you want to edit")
                                               
                                        } .padding(10)
                                            .background(.ultraThinMaterial)
                                            .cornerRadius(10)
                                            .padding(.top,260)
                                    }
                                )
                        } else {
                            GetImageAlert(url: "",loaded: .constant(false))
                                .offset(y: scrollY > 0 ? -scrollY : 0)
                                .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                                .blur(radius: scrollY > 0 ? scrollY / 10 : 0)
                                .accessibility(hidden: true)
                        }
                        
                        
                        
                    })
              //  .cornerRadius(8)
                
            }
            .frame(height: 400)
        }
        
        var content: some View {
            
            VStack {
                
                
                
                
                VStack(alignment: .leading, spacing: 30.0) {
                    
                    
                    
                    VStack(alignment: .leading, spacing: 13.0) {
                        
                        
                        HStack {
                            Text("About Me")
                                .font(.title).bold()
                            
                            // MARK: Age
                            
                            Text(profile.age )
                                .font(.title3).bold()
                                .padding(5)
                                .background(Color.orange)
                                .cornerRadius(60)
                            
                        }
                        // MARK: About Me
                        
                        if isEditing {
                            TextField("About Me", text: $profile.aboutme)
                                .font(.footnote)
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(Color("black"))
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(10)
                                .neoButton(isToggle: false) {
                                    //
                                    
                                    if isEditing {
                                        withAnimation(.spring()) {
                                            editItem = 2
                                            blurBackground = true
                                            
                                        }
                                    }
                                }
                            
                        } else {
                            TextWriterAppear(typeText: profile.aboutme, speed: 0.02)
                                .font(.footnote)
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(Color("black"))
                        }
                        
                        Spacer(minLength: 0.1)
                        
                        
                        HStack(spacing: 3.9){
                            Image(systemName: "graduationcap")
                                .font(.system(size: 18, weight: .medium))
                            
                            // MARK: Education
                            TextWriterAppear(typeText: profile.education, speed: 0.02)
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .neoButton(isToggle: false) {
                                    //
                                    
                                    if isEditing {
                                        withAnimation(.spring()) {
                                            blurBackground = true
                                            editItem = 3
                                        }
                                    }
                                }
                            
                            
                        }.foregroundColor(Color("black"))
                        
                        HStack {
                            Image(systemName: "building")
                                .font(.system(size: 18, weight: .medium))
                            // MARK: WORK
                            TextWriterAppear(typeText: "Works in \(profile.work)", speed: 0.02)
                            
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .lineLimit(2)
                        }.foregroundColor(Color("black"))
                            .neoButton(isToggle: false) {
                                //
                                
                                if isEditing {
                                    withAnimation(.spring()) {
                                        blurBackground = true
                                        editItem = 4
                                    }
                                }
                            }
                        
                        HStack {
                            Image(systemName: "location")
                                .font(.system(size: 18, weight: .medium))
                            
                            
                            HStack {
                                // MARK: Location
                                TextWriterAppear(typeText: profile.location[0], speed: 0.02)
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .lineLimit(2)
                                
                            }
                            
                        }.foregroundColor(Color("black"))
                            .neoButton(isToggle: false) {
                                //
                                
                                if isEditing {
                                    withAnimation(.spring()) {
                                        blurBackground = true
                                        editItem = 5
                                    }
                                }
                            }
                    }
                    .padding(20)
                    .background(Color("offwhite"))
                    .cornerRadius(19)
                 
                    
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 0.1)
                    
                    VStack(alignment: .leading, spacing: 15.0){
                        
                        HStack {
                            
                            
                            Image(systemName: "hand.thumbsup")
                                .font(.title).bold()
                                .foregroundColor(Color("black"))
                            
                            Text("First Date Idea?")
                                .font(.title2).bold()
                        }
                        Text("What would you like to do with siri on a first date? :)")
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                            .foregroundColor(Color("black"))
                        
                        
                        // MARK: Date ideas
                        VStack(spacing: 26.0) {
                            
                            // MARK: First date idea
                            HStack {
                                HStack(spacing: 4.0) {
                                    Text("Bar")
                                    Spacer()
                                    
                                    Image(systemName: "wineglass")
                                    
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                }
                                
                            }.padding(12)
                                .neoButtonOff(isToggle: false, cornerRadius: 10) {
                                    //
                                }
                            
                            HStack {
                                HStack(spacing: 4.0) {
                                    
                                    Text("Dinner")
                                    Spacer()
                                    Image(systemName: "fork.knife")
                                    
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                }
                                
                            }.padding(12)
                                .neoButtonOff(isToggle: false, cornerRadius: 15) {
                                    //
                                }
                            
                            HStack {
                                HStack(spacing: 4.0) {
                                    
                                    Text("Other")
                                    Spacer()
                                    Image(systemName: "eyes.inverse")
                                    
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                }
                                
                            }.padding(12)
                                .neoButtonOff(isToggle: false, cornerRadius: 15) {
                                    //
                                }
                        }
                    }.padding()
                        .neoButtonOff(isToggle: false, cornerRadius: 15) {
                            //
                        }
                    
                    
                    
                    
                    
                    
                    // MARK: First Image
                    ZStack {
                        VStack {
                            ImageViewer(url: profile.images[0] )
                            
                                .frame(minHeight:  400)
                            
                        }
                        
                    }.padding(-20)
                        .padding(.bottom,20)
                    
                        .overlay(
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Image(systemName: "heart.circle.fill")
                                    
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                }.padding(10)
                                
                            }
                        )
                        .neoButtonOff(isToggle: false, cornerRadius: 15) {
                            //
                        }
                    
                    
                    
                    
                    
                    
                    
                    VStack(alignment: .leading, spacing: 15.0){
                        HStack {
                            
                            
                            Image(systemName: "hand.thumbsup")
                                .font(.title).bold()
                            
                            
                            Text("Likes")
                                .font(.title).bold()
                            Spacer()
                        }
                        Text("Fun loving and looking to settle up with this stuff and do me. its really not like that said no one ever.")
                            .font(.callout)
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                        
                        
                        
                        HStack {
                            ForEach(profile.likes, id: \.self) { like in
                                LikesPill(placeholder: like)
                            }
                            
                            
                        }
                    }.foregroundColor(Color("black"))
                        .padding()
                        .neoButtonOff(isToggle: false, cornerRadius: 15) {
                            //
                        }
                        .padding(.bottom,25)
                    
                    VStack {
                        // MARK: Second Image
                        ZStack {
                            
                            ImageViewer(url: profile.images[1] )
                            
                                .frame(maxWidth: 500 , minHeight:  400)
                            
                            
                        
                        
                    }.padding(-20)
                        .padding(.bottom,20)
                        .neoButtonOff(isToggle: false, cornerRadius: 15) {
                            //
                        }
                        .overlay(
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Image(systemName: "heart.circle.fill")
                                    
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                }.padding(10)
                                
                            }
                        )
                    
                    
                    
                    // MARK: LifeStyle
                    VStack {
                        VStack(alignment: .leading, spacing: 15.0){
                            HStack {
                                
                                
                                Image(systemName: "teddybear")
                                    .font(.title).bold()
                                
                                Text("Lifestyle")
                                    .font(.title).bold()
                                
                                Spacer()
                            }
                            
                            Text(profile.lifestyledesc )
                                .font(.callout)
                                .multilineTextAlignment(.leading)
                                .lineLimit(showMore ? 10 : 3)
                            
                            
                            
                            // MARK: Lifestyle Pills
                            HStack {
                                ForEach(profile.lifestyle, id: \.self) { like in
                                    LikesPill(placeholder: like)
                                }
                                
                                
                            }
                        }.foregroundColor(Color("black"))
                            .padding(20)
                        
                            .neoButtonOff(isToggle: false, cornerRadius: 15) {
                                //
                            }
                            .padding(.bottom,95)
                    }
                    }
                    
                }
              
                
                .padding(.top,-10)
                .padding(10)
                
                
                
                
                
                
            }.padding(.bottom,-70)
                .rotation3DEffect(Angle(degrees: isEditing ? 360 : 0), axis: (x: 0, y: 360, z: 0))
                .onTapGesture {
                    if editItem > 0 {
                        withAnimation(.spring()) {
                            blurBackground = false
                            editItem = 0
                        }
                    }
                }
              //  .rotationEffect(.degrees( -15))
            
            
            
            
            
            
            
        }
      
        var scrollDetection: some View {
            GeometryReader { proxy in
                let offset = proxy.frame(in: .named("scroll")).minY
                Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
            }
            .onPreferenceChange(ScrollPreferenceKey.self) { offset in
                withAnimation(.easeInOut) {
                    scrolledItem = Int(offset)
                    
                    
                    
                    
                    
                    if offset < -15 {
                        
                        withAnimation(.spring()) {
                            // hidemainTab = true
                            
                        }
                        
                    }
                    
                    else {
                        withAnimation(.spring()) {
                            //  hidemainTab = false
                        }
                        
                        
                    }
                    
                }
            }
        }
        
     
        var drag: some Gesture {
            DragGesture(minimumDistance: 30, coordinateSpace: .local)
                .onChanged { value in
                    guard value.translation.width > 0 else { return }
                    
                    if value.startLocation.x < 100 {
                        withAnimation {
                            viewState = value.translation
                        }
                    }
                    
                    if viewState.width > 100 {
                        
                    }
                }
                .onEnded { value in
                    if viewState.width > 50 {
                        
                    } else {
                        withAnimation(.openCard) {
                            viewState = .zero
                        }
                    }
                }
        }
      
    
    
    
    func saveChanges() {
        // Save user data here
        print("Saving changes...")
      
    }
}



struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView()
    }
}

