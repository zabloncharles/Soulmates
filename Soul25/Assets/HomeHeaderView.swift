//
//  HomeHeaderView.swift
//  Soul25
//
//  Created by Zablon Charles on 4/21/24.
//

import SwiftUI

struct HomeHeaderView: View {
    @Binding var contentHasScrolled: Bool
    @Binding var showProfile: Bool
    @Binding var profiletype: Int
    
    var body: some View {
        HStack {
            VStack {
                Text("Fumble")
                    .font(.custom("MrDafoe-Regular", size: contentHasScrolled ? 30 : 42))
                    .foregroundColor(.clear)
                    .background(
                        LinearGradient(colors: [Color.green, .blue, .red], startPoint: .leading, endPoint: .trailing)
                    )
                    .mask(
                        Text("Fumble")
                            .font(.custom("MrDafoe-Regular", size: contentHasScrolled ? 30 : 42))
                    )
            }
            Spacer()
            if !showProfile {
                VStack {
                    Image(systemName: profiletype == 0 ? "figure.2.arms.open" : profiletype == 1 ? "figure.cooldown" : profiletype == 2 ? "figure.stand.line.dotted.figure.stand" : profiletype == 3 ? "person.fill.badge.plus" : "person.fill.badge.plus")
                        .font(.system(size:  17, weight: .bold))
                        .frame(width: 36, height: 36)
                        .foregroundColor( .secondary)
                        .background( Color("offwhite"))
                        .cornerRadius(30)
                        .scaleEffect( 1)
                        .overlay(
                            VStack{
                                Text("0")
                                    .foregroundColor(.white)
                                    .font(.caption)
                                    .padding(2)
                                    .background(
                                        Circle()
                                            .fill(.red)
                                            .padding(-3)
                                    )
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                    .offset(x:6, y: -5)
                            }.opacity(profiletype == 0 ? 1:0)
                        )
                }
            }
        }
      
        .padding(.horizontal, 25)
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView(contentHasScrolled: .constant(false), showProfile: .constant(false), profiletype: .constant(0))
    }
}

