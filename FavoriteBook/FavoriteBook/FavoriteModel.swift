//
//  FavoriteModel.swift
//  FavoriteBook
//
//  Created by AnilyTugce on 5.10.2022.
//

import Foundation

struct FavoriteModel : Identifiable {
    var id = UUID()
    var title : String
    var elements : [FavoriteElements]
}

struct FavoriteElements : Identifiable {
    var id = UUID()
    var name : String
    var imageName : String
    var description : String
}

//BANDS

let metallica = FavoriteElements(name: "Metallica", imageName: "metallica", description: "No 1 Music Band")
let model = FavoriteElements(name: "Model", imageName: "model", description: "No 2 Music Band")
let morVeOtesi = FavoriteElements(name: "Mor ve Ötesi", imageName: "morveotesi", description: "No 3 Music")
let favoriteBands = FavoriteModel(title: "Favorite Bands", elements: [metallica, model, morVeOtesi])


//MOVIES

let avangers = FavoriteElements(name: "Avangers", imageName: "avangers", description: "No 1 Movie")
let warcraft = FavoriteElements(name: "Warcraft", imageName: "warcraft", description: "No 2 Movie")
let samaritan = FavoriteElements(name: "Samaritan", imageName: "samaritan", description: "No 3 Movie")
let favoriteMovies = FavoriteModel(title: "Favorite Movies", elements: [avangers, warcraft, samaritan])


let myFavorites = [favoriteBands, favoriteMovies]


