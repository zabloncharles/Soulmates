//
//  Handbook.swift
//  Handbook
//
//  Created by Meng To on 2021-08-05.
//

import SwiftUI
import Firebase



struct Handbook: Identifiable {
    let id = UUID()
    var wallpapername: String
    var wallpaperfilename: String
   
}

var handbooks = [
    Handbook(wallpapername: "Moscaid", wallpaperfilename: "ob1"),
    Handbook(wallpapername: "Villanova", wallpaperfilename: "image_06"),
    Handbook(wallpapername: "Sapien", wallpaperfilename: "image_03"),
    Handbook(wallpapername: "Thriller", wallpaperfilename: "image_04"),
    Handbook(wallpapername: "Matrix", wallpaperfilename: "image_01"),
    Handbook(wallpapername: "Affirmax", wallpaperfilename: "image_02"),
    Handbook(wallpapername: "Bullfast", wallpaperfilename: "image_08"),
    Handbook(wallpapername: "Campten", wallpaperfilename: "image_09"),
    Handbook(wallpapername: "Rester", wallpaperfilename: "image_10"),
    Handbook(wallpapername: "Bonieville", wallpaperfilename: "image_05")
]



