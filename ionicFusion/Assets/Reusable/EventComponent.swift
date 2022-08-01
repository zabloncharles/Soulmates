//
//  EventComponent.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 2/25/22.
//

import SwiftUI

struct EventComponent: View {
    var eventTapped = false
    var title = ""
    var description = ""
    var isToday = false
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image("image_10")
                .resizable()
                .frame(width: 46, height: 46)
                .mask(Circle())
                .padding(10)
                .background(Color(UIColor.systemBackground).opacity(0.9))
                .mask(Circle())
                .overlay(CircularView(value: 76))
            VStack(alignment: .leading, spacing: 8) {
                Text(isToday ? "Today" : "Alert")
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)
                Text(title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Text(description)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)
                //                                ProgressView(value: 100)
                //                                    .foregroundColor(.clear)
                //                                    .accentColor(.clear)
                //                                    .frame(maxWidth: 132)
            }
            Spacer()
        }.padding()
            .newoffwhite(offwhiteisTapped: eventTapped, cornerradius: 15)
           
           

    }
}

struct EventComponent_Previews: PreviewProvider {
    static var previews: some View {
        EventComponent()
    }
}
