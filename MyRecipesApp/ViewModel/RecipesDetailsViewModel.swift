//
//  RecipesDetailsViewModel.swift
//  MyRecipesApp
//
//  Created by Aviad Sabag on 29/11/2024.
//

import Foundation

final class RecipesDetailsViewModel {
    
    private(set) var recipe: Recipe

    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    var getRecipeTitle: String {
        recipe.name
    }
    
    var getProteins: String {
        recipe.proteins
    }
    
    var getDifficulty: Int {
        recipe.difficulty
    }
    
    var getTime: String {
        recipe.time
    }
    
    var getDescription: String {
        recipe.description
    }
    
    var getImagedata: Data? {
        recipe.imageData
    }
}
