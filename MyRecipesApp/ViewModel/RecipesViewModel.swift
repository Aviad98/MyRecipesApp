//
//  RecipesViewModel.swift
//  MyRecipesApp
//
//  Created by Aviad Sabag on 28/11/2024.
//

import Foundation
import UIKit

final class RecipesViewModel {
    var onRecipesUpdated: (()->Void)?
    private var isInSearchMode : Bool = false
    
    private(set) var filteredRecipes: [Recipe] = []
    private(set) var favoriteRecipes: [Recipe] = []
    private(set) var recipes: [Recipe] = [] {
        didSet{
            self.onRecipesUpdated?()
        }
    }
    
    
    
    func getViewModel(for Index: Int) -> RecipesDetailsViewModel? {
        return RecipesDetailsViewModel(recipe: isInSearchMode ? self.filteredRecipes[Index] : recipes[Index])
    }
    
    func getFavoriteRecipeViewModel() -> FavouritesRecipesViewModel? {
        return FavouritesRecipesViewModel(favRecipes: self.getFavoriteRecipes())
    }
    
    
    func updateIsInSearchMode(_ isInSearchMode: Bool) {
        self.isInSearchMode = isInSearchMode
    }
    
    func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        NetworkManager.shared.get(from: Constants.NetworkConstants.recipesUrl) { [weak self] (result: Result<[Recipe], Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let recipes):
                var updatedRecipes = [Recipe]()
                let group = DispatchGroup()
                
                for recipe in recipes {
                    group.enter()
                    var recipe = recipe
                    NetworkManager.shared.getRecipeImage(recipe: recipe) { result in
                        defer { group.leave() }
                        
                        switch result {
                        case .success(let responseData):
                            recipe.imageData = responseData
                            updatedRecipes.append(recipe)
                        case .failure:
                            recipe.imageData = UIImage(named: "placeholder")?.pngData()
                            updatedRecipes.append(recipe)
                        }
                    }
                }
                
                group.notify(queue: .main) {
                    self.recipes = updatedRecipes
                    completion(.success(self.recipes))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


extension RecipesViewModel {
    
    public func inSearchMode( searchText: String ) -> Bool {
        let searchText = searchText
        
        return isInSearchMode && !searchText.isEmpty
    }
    
    
    public func updateSearchController(searchBarText: String?) {
        
        self.filteredRecipes = self.recipes
        
        
        if let searchBarText = searchBarText?.lowercased() {
            guard !searchBarText.isEmpty else { self.onRecipesUpdated?(); return }
            
            self.filteredRecipes = self.recipes.filter({$0.name.lowercased().contains(searchBarText)})
        }
        
        self.onRecipesUpdated?()
        
    }
}

// MARK: - Favorite Recipes Section:
extension RecipesViewModel {
    func configureFavourites(recipe: Recipe) {
        if !favoriteRecipes.contains(where: { $0.id == recipe.id }) {
            favoriteRecipes.append(recipe)
        } else {
            //we remove because it exists:
            if let index = favoriteRecipes.firstIndex(where: {$0.id == recipe.id}) {
                favoriteRecipes.remove(at: index)
            }
            
            
        }
    }
    
    func getFavoriteRecipes() -> [Recipe] {
        return self.favoriteRecipes
    }
}
