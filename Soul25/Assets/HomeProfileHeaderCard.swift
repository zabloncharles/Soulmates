//
//  HomeProfileHeaderCard.swift
//  Soul25
//
//  Created by Zablon Charles on 4/21/24.
//

import SwiftUI

struct HomeProfileHeaderCard: View {
    @State var profiles: [UserStruct] = []
    @State private var filteredProfiles: [UserStruct] = []
    @State var currentUser: UserStruct? = fakeUser
    @State var profile = fakeUsers[0]
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 5) {
                    HStack(spacing: 5) {
                        Text(currentUser?.firstName ?? "umm")
                            .bold()
                            .font(.title)
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                            .opacity(0.67)
                    }
                    
                    VStack {
                        VStack {
                            HStack(spacing: 2.0) {
                                Image(systemName: "fleuron")
                                    .foregroundColor(.blue)
                                    .opacity(0.67)
                                Text("You have compatible profiles")
                                    .opacity(0.67)
                                    .lineLimit(1)
                            }
                        }
                    }
                    .font(.subheadline)
                }
                Spacer()
                GetImageAndUrl(url: currentUser?.avatar ?? "", loaded: .constant(true), imageUrl: .constant(""))
                    .clipShape(Circle())
                    .frame(width: 70, height: 70)
                    .background(
                        Circle()
                            .fill(Color("offWhite"))
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(Circle().fill(LinearGradient(Color("black"), Color.clear)))
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color("offWhite"), lineWidth: 8)
                                    .blur(radius: 4)
                                    .offset(x: -2, y: -2)
                                    .mask(Circle().fill(LinearGradient(Color.clear, Color("black"))))
                            )
                            .padding(-1.3)
                    )
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    .background(Color("offwhiteneo").opacity(0.40))
            )
//            .overlay(
//                RoundedRectangle(cornerRadius: 14)
//                    .stroke(Color("black").opacity(0.40), lineWidth: 1)
//            )
            .neoButton(isToggle: false, perform: {})
            
            .padding(.horizontal, 10)
            .padding(.bottom, 5)
            .padding(.top,-20)
         
     
        }
    }
}

struct HomeProfileHeaderCard_Previews: PreviewProvider {
    static var previews: some View {
        HomeProfileHeaderCard()
    }
}
