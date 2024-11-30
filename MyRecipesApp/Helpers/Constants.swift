//
//  Constants.swift
//  MyRecipesApp
//
//  Created by Aviad Sabag on 28/11/2024.
//



struct Constants {
    
    struct CellReuseIdentifiers {
        static let recipeCollectionViewIdentifier = "RecipeCollectionViewCell"
        static let favoriteTableViewCellIdentifier = "FavouriteTableViewCell"
        static let loadingCollectionViewCell = "LoadingCollectionViewCell"

    }
    struct NibIdentifiers {
        static let recipeCollectionViewCell = "RecipeCollectionViewCell"
        static let favoriteTableViewCell = "FavouriteTableViewCell"
    }
    
    struct NetworkConstants {
        static let recipesUrl = "https://hf-android-app.s3-eu-west-1.amazonaws.com/android-test/recipes.json"
    }
    
    struct ErrorMessages {
        static let failedFetching = "Failed to fetch recipes"
    }
}



