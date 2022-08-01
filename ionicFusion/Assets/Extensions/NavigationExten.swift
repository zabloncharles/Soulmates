//
//  NavigationExten.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 3/16/22.
//

import Foundation
import SwiftUI

struct NavigationBarModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    @State var something = UINavigationBarAppearance()
    
    init() {
       
        let notScrolledAppearance = UINavigationBarAppearance()
        notScrolledAppearance.configureWithTransparentBackground()
        notScrolledAppearance.backgroundColor = .clear
        notScrolledAppearance.titleTextAttributes = [.foregroundColor:colorScheme == .dark ? UIColor.white : UIColor.black]
        notScrolledAppearance.largeTitleTextAttributes = [.foregroundColor: colorScheme == .dark ? UIColor.white : UIColor.black]
        
        let ScrolledAppearance = UINavigationBarAppearance()
        ScrolledAppearance.configureWithTransparentBackground()
        ScrolledAppearance.backgroundColor = .clear
        ScrolledAppearance.titleTextAttributes = [.foregroundColor: colorScheme == .dark ? UIColor.white : UIColor.black]
        ScrolledAppearance.largeTitleTextAttributes = [.foregroundColor: colorScheme == .dark ? UIColor.white : UIColor.black]
        
        UINavigationBar.appearance().standardAppearance = notScrolledAppearance
        UINavigationBar.appearance().compactAppearance = notScrolledAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = ScrolledAppearance
        UINavigationBar.appearance().tintColor = .clear
    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(.clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    
                        
                    Spacer()
                }
            }
           
        }
    }
}
extension View {
    func navigationBarColor() -> some View {
        self.modifier(NavigationBarModifier())
    }
}
extension View {
    var blueNavigation: some View {
        self.navigationBarColor()
    }
}

extension View {
    var customNavbar: some View {
        self.navigationBarColor()
    }
}

struct NavigationBarModifierView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
      //  ResultsDetail(namespace: namespace, course: .constant(courses[0]))
           
        ViewController()
        
    }
}
