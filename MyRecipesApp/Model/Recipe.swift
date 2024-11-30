//
//  Recipe.swift
//  MyRecipesApp
//
//  Created by Aviad Sabag on 28/11/2024.
//

import Foundation

struct Recipe: Codable {
    let calories, carbos, description: String
    let difficulty: Int
    let fats, headline, id: String
    let image: String
    let name, proteins: String
    let thumb: String?
    let time: String
    let country: String?
    
    var imageData: Data?
}

