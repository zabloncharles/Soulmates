//
//  ViewController.swift
//  FusionAppiOS15
//
//  Created by Zablon Charles on 12/30/21.
//

import SwiftUI

struct ViewController: View {
    @AppStorage("signedIn") var signedIn = false
    @AppStorage("doneIntro") var doneIntro = false
   
    
    var body: some View {
        if doneIntro && signedIn {
            MainTab()
        } else if doneIntro {
            SigninView(signIn: $signedIn)
        } else {
            OnboardingView(doneIntro: $doneIntro)
        }

            }

}
        
        struct ViewController_Previews: PreviewProvider {
            static var previews: some View {
                ViewController()
                    .preferredColorScheme(.dark)
                    
            }
        }
        
