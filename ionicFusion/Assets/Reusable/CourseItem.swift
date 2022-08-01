//
//  CourseItem.swift
//  iOS15
//
//  Created by Meng To on 2021-06-18.
//

import SwiftUI

struct CourseItem: View {
    var namespace: Namespace.ID
    var course: Course
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        VStack {
            HStack{
            LogoView(image: course.logo)
                    
            Spacer()
                HStack{
                Image(systemName: "eye")
                    .frame(width: 29.0, height: 25.0)
                    Text ("2,567K")
                        .font(.footnote)
                        
                }
                .foregroundColor(.white)
                .foregroundColor(.secondary.opacity(0.7))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(20)
            .matchedGeometryEffect(id: "logo\(course.index)", in: namespace)
            Spacer()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(course.title)
                    .font(.custom("WorkSans-Medium", size: 20))
                    .font(.title).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .matchedGeometryEffect(id: "title\(course.index)", in: namespace)
                    .foregroundColor(.white)
                
                Text(course.subtitle.uppercased())
                    .font(.caption)

                .frame(maxWidth: .infinity, alignment: .leading)
                .matchedGeometryEffect(id: "subtitle\(course.index)", in: namespace)
                .foregroundColor(.white.opacity(0.7))
                Text(course.text)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white.opacity(0.7))
                    .matchedGeometryEffect(id: "description\(course.index)", in: namespace)
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .cornerRadius(30)
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur\(course.index)", in: namespace)
            )
        }
        // the blob in the middle
        .background(
            Image(course.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(20)
                .matchedGeometryEffect(id: "image\(course.index)", in: namespace)
                .offset(y: -30)
        
        )
        .background(
            Image(course.background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .disabled(true)
                .matchedGeometryEffect(id: "background\(course.index)", in: namespace)
        )
        .mask(
            RoundedRectangle(cornerRadius: 30)
                .matchedGeometryEffect(id: "mask\(course.index)", in: namespace)
        )
        .overlay(
            Image(horizontalSizeClass == .compact ? "Waves 1" : "Waves 2")
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(y: 0)
                .opacity(0)
                .matchedGeometryEffect(id: "waves\(course.index)", in: namespace)
        )
        .onTapGesture {
            withAnimation(.openCard) {
              
            }
        }
    }
}

struct CardItem_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        CourseItem(namespace: namespace, course: courses[0])
           
        
    }
}
