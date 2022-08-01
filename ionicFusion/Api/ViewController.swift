//
//  ViewController.swift
//  FusionAppiOS15
//
//  Created by Zablon Charles on 12/30/21.
//

import SwiftUI

struct ViewController: View {
    @AppStorage("signIn") var signIn = false
    @AppStorage("doneIntro") var doneIntro = false
    @AppStorage("firstday") var firstday = false
    var body: some View {
        ZStack {
            //Stay signed in
           if signIn && doneIntro {
                MainTab()
               
               
               if firstday {
               SetView()
                   
               }
                
            } else {
                
                if doneIntro {
                   SigninView(signIn: $signIn, doneIntro: $doneIntro)
               } else {
                    
                OnboardingView(doneIntro: $doneIntro, signIn: $signIn)
                    
               }
            
                 }
                }
            }
        }
        
        struct ViewController_Previews: PreviewProvider {
            static var previews: some View {
                ViewController()
                    .preferredColorScheme(.dark)
            }
        }
        
