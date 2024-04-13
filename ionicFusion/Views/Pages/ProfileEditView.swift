//
//  ProfileEditView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/31/23.
//
import SwiftUI

struct ProfileEditView: View {
    @State var profile: UserStruct = fakeUser
    @State var profilefake: UserStruct?
        @AppStorage("hidemainTab") var hidemainTab = false
        var isAnimated = true
        @State var viewState: CGSize = .zero
        @State var text = ""
        @State var erro = ""
        @State var typeText = ""
    @State var notifactionMessage = ["Click on what you want to edit", "Notification"]
        @State var animateapper = false
    @State var showNotification = false
    @State var aboutMeAppeared = false
        @State var showMore = false
    @State var showSettings = true
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
                

                Color("offwhiteneo")
                
                ZStack {
                   
                    
                    ScrollView {
                        if showSettings {
                            SettingsView( userInfo: profile)
                                
                                .transition(.asymmetric(
                                    insertion: .opacity,
                                    removal: .opacity))
                                .opacity(!showSettings ? 0 : 1)
                                .offset(y: !animateapper ? 10 : -25)
                                .onAppear{
                                    hidemainTab = false
                                }
                        }
                    }
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
                      
                        withAnimation(.spring()) {
                            animateapper = true
                        }
                    }
                    .onDisappear{
                     
                        withAnimation(.spring()) {
                            animateapper = false
                        }
                    }
                   
             
            }.onChange(of: blurBackground) { hidetabbar in
                if blurBackground {
                    withAnimation(.spring()) {
                        
                        
                    }
                }
            }
        }
  
}



struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView()
    }
}

