//
//  ResponseModel.swift
//  DrinkDownloader
//
//  Created by Nicky Taylor on 10/16/22.
//

import Foundation

//www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita

struct Drink: Decodable {
    
    let idDrink: String
    let strDrink: String
    
    let strDrinkThumb: String?
    
    let strGlass: String?
    
    let strInstructions: String?
    
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
}

struct ResponseModel: Decodable {
    let drinks: [Drink]
}

extension Drink: Identifiable {
    var id: String { idDrink }
}

extension Drink: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(idDrink)
    }
}
