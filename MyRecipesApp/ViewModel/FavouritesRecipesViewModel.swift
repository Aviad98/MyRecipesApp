//
//  FavouritesRecipesViewModel.swift
//  MyRecipesApp
//
//  Created by Aviad Sabag on 30/11/2024.
//



import Foundation


final class FavouritesRecipesViewModel {
    
    private(set) var favRecipes: [Recipe]?
    
    init(favRecipes: [Recipe]) {
        self.favRecipes = favRecipes
    }
    
    var getFavoriteRecipes: [Recipe] {
        favRecipes ?? []
    }
    
    
}
