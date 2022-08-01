//
//  FeaturedItem.swift
//  FeaturedItem
//
//  Created by Meng To on 2021-07-21.
//

import SwiftUI

struct FeaturedItem: View {
    var course: Course
    @Environment(\.sizeCategory) var sizeCategory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
           // Spacer()
            Image(course.logo)
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(80)
                .padding(0) //was 8
                .modifier(OutlineOverlay(cornerRadius: 80))
            Spacer()
            VStack(alignment: .leading, spacing: 7) {
            Text(course.title)
                .font(.custom("WorkSans-Medium", size: 25))
                .font(.title).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(course.subtitle.uppercased())
                    .font(.caption)
                    .fontWeight(.semibold)
                .foregroundStyle(.secondary)
            Text(course.text)
                    .font(.caption)
                .fontWeight(.regular)
                .foregroundStyle(.secondary)
                .lineLimit(sizeCategory > .large ? 1 : 2)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 30)
        .frame(maxWidth: .infinity)
        .frame(height: 350)
        .background(.ultraThinMaterial)
        .backgroundColor(opacity: 0.5)
    }
}

struct FeaturedItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FeaturedItem(course: courses[0])
            FeaturedItem(course: courses[0])
                .environment(\.sizeCategory, .accessibilityLarge)
        }
    }
}
