//
//  OffwhiteButtonModifier.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 2/22/22.
//

import SwiftUI
struct Tapped: ViewModifier {
    @State var isTapped: Bool
    @State var isToggle: Bool
    @State var cornerRadius: CGFloat = 15
    @Binding var action : Bool 
    
    
    func body(content: Content) -> some View {
        content
            .background(Color("offwhite"))
            .cornerRadius(cornerRadius)
            .shadow(color:  .black.opacity(0.3), radius: 10, x:isTapped ? -5 : 10, y:isTapped ? -5 : 10 )
            .shadow(color: Color("white").opacity(0.9),radius: 10, x:isTapped  ? 10 : -5, y:isTapped  ? 10 : -5)
            .scaleEffect(isTapped ? 0.97 : 1)
        
            .onTapGesture {
                if isToggle {
                   
                    withAnimation(.spring())  {
                        action = true
                        isTapped.toggle()
                    }
                } else {
                   
                    withAnimation(.spring()) {
                        action = true
                        isTapped = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        withAnimation(.spring()) {
                            isTapped = false
                        }
                        
                    }
                }
            }
        
    }
}

extension View {
    func offwhitebutton(isTapped: Bool, isToggle: Bool, cornerRadius: CGFloat, action : Binding<Bool>) -> some View {
        self.modifier(Tapped(isTapped: isTapped, isToggle: isToggle, cornerRadius: cornerRadius, action: action))
    }
}

//:MARK this card has offwhite and can click to linked action using binding---------------------------------------------------------------------------

struct CardTapped: ViewModifier {
    @State var isToggle: Bool
    @State var cornerRadius: CGFloat = 15
    @Binding var action: Bool
    @State var animate = false

    @Binding var matchcard : MatchCardData
    var section : MatchCardData
  
    
    func body(content: Content) -> some View {
        content
            .background(Color("offwhite"))
            .cornerRadius(cornerRadius)
            .shadow(color:  .black.opacity(0.3), radius: 10, x:animate ? -5 : 10, y:animate ? -5 : 10 )
            .shadow(color: Color("white").opacity(0.9),radius: 10, x:animate  ? 10 : -5, y:animate  ? 10 : -5)
            .scaleEffect(animate && !isToggle ? 0.97 : 1)
        
            .onTapGesture {
                
                matchcard = section
                
                if isToggle {
                    
                    withAnimation(.spring())  {
                        animate.toggle()
                        action.toggle()
                    }
                } else {
                    //Quick animation of a click
                    withAnimation(.spring()) {
                        animate = true
                        
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.spring()) {
                            action.toggle()
                        }
                    }
                   DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        withAnimation(.spring()) {
                            
                            animate = false
                            
                        }
                        
                    }
                }
            }
        
    }
}

extension View {
    func offwhiteCard(isToggle: Bool, cornerRadius: CGFloat ,action : Binding<Bool>, matchcard : Binding<MatchCardData>, section : MatchCardData) -> some View {
        self.modifier(CardTapped(isToggle: isToggle, cornerRadius: cornerRadius, action: action, matchcard: matchcard, section: section))
    }
}



//------------------------------------------------------
//MARK: Neurmorphic Cutom Modifiers
struct offwhiteModifier: ViewModifier {
    var offwhitecolor: Color = Color("black")
    var offwhitecolorShadow: Color = Color("white")
    var offwhiteisTapped: Bool
    
    func body(content: Content) -> some View {
        
        
        content
          //  .background(Color("offwhite"))
           // .cornerRadius(19)
            .shadow(color:  offwhitecolor.opacity(0.2), radius: 10, x:offwhiteisTapped ? -5 : 10, y:offwhiteisTapped ? -5 : 10 )
            .shadow(color: offwhitecolorShadow.opacity(0.9),radius: 10, x:offwhiteisTapped  ? 10 : -5, y:offwhiteisTapped  ? 10 : -5)
        
        
        
        
        
    }
}

extension View {
    func offwhite(offwhitecolor : Color, offwhitecolorShadow : Color, offwhiteisTapped : Bool) -> some View {
        self.modifier(offwhiteModifier(offwhitecolor : offwhitecolor, offwhitecolorShadow: offwhitecolorShadow, offwhiteisTapped: offwhiteisTapped))
    }
}


//------------------------------------------------------
//MARK: Neurmorphic Cutom Modifiers that can tap above
struct offwhiteModifier2: ViewModifier {
    var offwhitecolor: Color = Color("black")
    var offwhitecolorShadow: Color = Color("white")
    var offwhiteisTapped: Bool
    @Binding var tapped: Bool
    
    func body(content: Content) -> some View {
        
        
        content
        //  .background(Color("offwhite"))
        // .cornerRadius(19)
            .shadow(color:  offwhitecolor.opacity(0.2), radius: 10, x:offwhiteisTapped ? -5 : 10, y:offwhiteisTapped ? -5 : 10 )
            .shadow(color: offwhitecolorShadow.opacity(0.9),radius: 10, x:offwhiteisTapped  ? 10 : -5, y:offwhiteisTapped  ? 10 : -5)
            .onTapGesture {
                
                tapped.toggle()
                
            }
        
        
        
        
    }
}

extension View {
    func offwhiteButton(offwhitecolor : Color, offwhitecolorShadow : Color, offwhiteisTapped : Bool, tapped : Binding<Bool>) -> some View {
        self.modifier(offwhiteModifier2(offwhitecolor : offwhitecolor, offwhitecolorShadow: offwhitecolorShadow, offwhiteisTapped: offwhiteisTapped, tapped: tapped))
    }
}

//------------------------------------------------------
//MARK: Dynamic Cutom Modifiers
struct newoffwhiteModifier: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme
    @State var offwhitecolor: Color = Color("white")
    @State var offwhitecolorShadow: Color = Color("black")
    @State var cornerradius = 19
    var offwhiteisTapped : Bool
    
    func body(content: Content) -> some View {
        
        if colorScheme == .dark {
            if cornerradius != 0 {
                content
                .background(Color("offwhite"))
                .cornerRadius(CGFloat(cornerradius))
                .shadow(color:  offwhitecolor.opacity(0.9), radius: 10, x:offwhiteisTapped ? -5 : 10, y:offwhiteisTapped ? -5 : 10 )
                .shadow(color: offwhitecolorShadow.opacity(0.02),radius: 10, x:offwhiteisTapped  ? 10 : -5, y:offwhiteisTapped  ? 10 : -5)
            .scaleEffect(offwhiteisTapped ? 0.97 : 1)
            } else {
                content
                    .shadow(color:  offwhitecolor.opacity(0.9), radius: 10, x:offwhiteisTapped ? -5 : 10, y:offwhiteisTapped ? -5 : 10 )
                    .shadow(color: offwhitecolorShadow.opacity(0.02),radius: 10, x:offwhiteisTapped  ? 10 : -5, y:offwhiteisTapped  ? 10 : -5)
                    .scaleEffect(offwhiteisTapped ? 0.97 : 1)
            }
        } else {
            if cornerradius != 0 {
                content
                    .background(Color("offwhite"))
                    .cornerRadius(CGFloat(cornerradius))
                    .shadow(color:  offwhitecolorShadow.opacity(0.2), radius: 10, x:offwhiteisTapped ? -5 : 10, y:offwhiteisTapped ? -5 : 10 )
                    .shadow(color: offwhitecolor.opacity(0.9),radius: 10, x:offwhiteisTapped  ? 10 : -5, y:offwhiteisTapped  ? 10 : -5)
                .scaleEffect(offwhiteisTapped ? 0.97 : 1)
            } else {
                content
                    .shadow(color:  offwhitecolorShadow.opacity(0.2), radius: 10, x:offwhiteisTapped ? -5 : 10, y:offwhiteisTapped ? -5 : 10 )
                    .shadow(color: offwhitecolor.opacity(0.9),radius: 10, x:offwhiteisTapped  ? 10 : -5, y:offwhiteisTapped  ? 10 : -5)
                    .scaleEffect(offwhiteisTapped ? 0.97 : 1)
            }
        }
        
        
        
        
    }
}

extension View {
    func newoffwhite(offwhiteisTapped: Bool, cornerradius: CGFloat) -> some View {
        self.modifier(newoffwhiteModifier(cornerradius: Int(cornerradius), offwhiteisTapped: offwhiteisTapped))
    }
}
