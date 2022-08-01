//
//  CourseSection.swift
//  DesignCodeUniversal
//
//  Created by Meng To on 7/1/20.
//

import SwiftUI

struct CourseSectionw: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var logo: String
    var color: Color
}

var courseSectionsw = [
    CourseSectionw(
        title: "Period",
        logo: "Logo SwiftUI",
        color: Color(#colorLiteral(red: 0.1776223481, green: 0.003123702249, blue: 0.9679456353, alpha: 1))
    )
]



