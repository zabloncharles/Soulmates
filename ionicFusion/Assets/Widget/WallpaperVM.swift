//
//  WallpaperVM.swift
//  Fusion
//
//  Created by Zablon Charles on 2/20/22.
//
//
//  HandbookItem.swift
//  HandbookItem
//
//  Created by Meng To on 2021-08-05.
//

import SwiftUI



struct WallpaperVM: View {
    var handbook: Handbook
    @State var tappedImage = false
    @AppStorage("wallpaper") var wallpaper = ""
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



struct WallpaperVM_Previews: PreviewProvider {
    static var previews: some View {
//        HandbookItem(handbook: handbooks[0], showWallpaperPicker: .constant(false))
        SettingsView()
    }
}


