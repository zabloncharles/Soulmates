//
//  HandbookItem.swift
//  HandbookItem
//
//  Created by Meng To on 2021-08-05.
//

import SwiftUI

//struct HandbookItem: View {
//    var handbook: Handbook
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            RoundedRectangle(cornerRadius: 20)
//                .fill(.black.opacity(0.2))
//                .blendMode(.overlay)
//                .frame(height: 90)
//                .overlay(
//                    Image(handbook.image)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 150, height: 100)
//                )
//            Text(handbook.title)
//                .fontWeight(.semibold)
//                .padding(.top, 8)
//                .layoutPriority(1)
//            Text(handbook.subtitle)
//                .font(.caption.weight(.medium))
//                .foregroundStyle(.secondary)
//            Text(handbook.text)
//                .font(.caption.weight(.medium))
//                .foregroundStyle(.secondary)
//                .lineLimit(3)
//            Spacer()
//        }
//        .padding(16)
//        .frame(maxWidth: 200)
//        .frame(height: 260)
//        .background(.ultraThinMaterial)
//        .backgroundStyle(cornerRadius: 30)
//        .background(
//            RoundedRectangle(cornerRadius: 30)
//                .fill(LinearGradient(colors: [handbook.color1, handbook.color2], startPoint: .top, endPoint: .bottomTrailing))
//                .rotation3DEffect(.degrees(10), axis: (x: 0, y: 1, z: 0), anchor: .bottomTrailing)
//                .rotationEffect(.degrees(180))
//                .padding(.trailing, 40)
//        )
//        .shadow(color: .clear, radius: 0, x: 0, y: 0)
//    }
//}

struct HandbookItem: View {
    var handbook: Handbook
    @State var tappedImage = false
    @AppStorage("wallpaper") var wallpaper = "ob1"
    @Binding var showWallpaperPicker : Bool
    
    var body: some View {
        
        VStack {
            HStack{
              
                
                VStack{
                    
                    HStack {
                        Spacer()
                        
                        Text(handbook.wallpapername)
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .padding(.leading, 15)
                            .padding(.trailing, 49)
                            .background(.black)
                            .cornerRadius(20)
                            .offset(x:39)
                    }
                }
            }
            .frame(height: 170)
            .background(Image(handbook.wallpaperfilename)
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill))
                .cornerRadius(15)
                .onTapGesture{
                    withAnimation(.spring()){
                        tappedImage = true
                        wallpaperselected()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                            withAnimation(.spring()){
                                tappedImage = false
                            }
                        }
                    }
                    
                }

                .scaleEffect(tappedImage ? 0.96 : 1)
                .padding(.horizontal,20)
                .padding(.vertical, 5)
        }
    }
    func wallpaperselected(){
        
        
        wallpaper = handbook.wallpaperfilename
       
        
        let impactMed = UIImpactFeedbackGenerator(style: .light)
        impactMed.impactOccurred()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation(.spring()){
                showWallpaperPicker = false
            }
        }
        
    }
}



struct HandbookItem_Previews: PreviewProvider {
    static var previews: some View {
//        HandbookItem(handbook: handbooks[0], showWallpaperPicker: .constant(false))
        SettingsView()
    }
}
