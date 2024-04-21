//
//  NoProfilesView.swift
//  Soul25
//
//  Created by Zablon Charles on 4/20/24.
//

import SwiftUI

import SwiftUI

struct NoProfilesView: View {
    @Binding var pageAppeared: Bool
    @Binding var profiletype: Int
    @State  var loadingIcon = true
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 20.0) {
                LottieView(filename: "girllikingstuff", loop: true)
                    .frame(height: 120)
                    .opacity(pageAppeared ? 1 : 1)
                    .padding(.top, 50)
                
                Text("Opps! No profiles yet")
                    .font(.headline)
                
                Text("Nothing to see here. Matches are more intentional on Soulmate so don't worry, They'll come in very soon.")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 25)
                
                HStack {
                    Text(profiletype == 0 ? "Try adjusting preferences" : profiletype == 1 ? "Nobody is active atm :(" : profiletype == 2 ? "Try adjusting preferences" : "Boost profile to be first to see new people!")
                        .animation(.spring(), value: profiletype)
                        .font(.body)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
                .cornerRadius(30)
            }
            .padding(10)
          
        }
//        .transition(.offset(y: UIScreen.main.bounds.height * 1.02))
//        .animation(.spring(), value: profiletype)
        .onAppear {
            loadingIcon = false
        }
    }
}

struct NoProfilesView_Previews: PreviewProvider {
    static var previews: some View {
        NoProfilesView(pageAppeared: .constant(true), profiletype: .constant(0))
    }
}
