//
//  Widgets.swift
//  Fusion
//
//  Created by Zablon Charles on 3/19/22.
//

import SwiftUI

struct Widgets: View {
//    @ObservedObject var viewModel = UserViewModel()
    var item: CourseSectionw = courseSectionsw[0]
    var body: some View {
        VStack {
           
                HStack(spacing:26){
                    
                    WidgetSmallClock(periodCount:  0)
                    WidgetSmallClock2(pregnancyCount: "Medium")
                    WidgetSmallClock3()
                    
                }.padding(10)
                    .scaleEffect(0.74)
            
        }
    }
}

struct Widgets_Previews: PreviewProvider {
    static var previews: some View {
       Widgets()
       
    }
}
