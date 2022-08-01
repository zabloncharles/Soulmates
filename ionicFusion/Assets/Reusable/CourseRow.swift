//
//  CourseRow.swift
//  DesignCodeCourse
//
//  Created by Meng To on 2020-07-15.
//

import SwiftUI

struct CourseRow: View {
   // var item: CourseSection = courseSections[0]
    
    var body: some View {
        HStack(alignment: .top) {
            Image("item.logo")
                .renderingMode(.original)
                .frame(width: 48.0, height: 48.0)
                .imageScale(.medium)
                .background(.blue)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 4.0) {
                Text("item.title")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.primary)
                Text("item.subtitle")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}

struct CourseRow_Previews: PreviewProvider {
    static var previews: some View {
        CourseRow()
    }
}
