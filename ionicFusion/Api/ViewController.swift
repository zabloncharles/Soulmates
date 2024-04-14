//
//  ViewController.swift
//  FusionAppiOS15
//
//  Created by Zablon Charles on 12/30/21.
//

import SwiftUI

struct ViewController: View {
    @AppStorage("signedIn") var signedIn = true
   
   
    
    var body: some View {
        if  signedIn {
            MainTab()
        } else {
            SigninView(signIn: $signedIn)
        }

            }

}
        
        struct ViewController_Previews: PreviewProvider {
            static var previews: some View {
                ViewController()
//                    .preferredColorScheme(.dark)
                    
            }
        }
        
