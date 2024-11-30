//
//  RecipeCollectionViewCell.swift
//  MyRecipesApp
//
//  Created by Aviad Sabag on 28/11/2024.
//

import UIKit

protocol RecipeListCellDelegate: AnyObject {
    func favoriteButtonTapped(for recipe: Recipe)
}

class RecipeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeCarbos: UILabel!
    @IBOutlet weak var recipeFats: UILabel!
    @IBOutlet weak var recipeCalories: UILabel!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    
    weak var delegate: RecipeListCellDelegate?
    
    var recipe: Recipe?
    var isFavorited: Bool = false

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Add Border + Radius
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
        // Add shadow
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 4.0
        
        
    }
    
    
    
    func configureRecipeCell(with recipe: Recipe) {
        self.recipe = recipe

        DispatchQueue.main.async {
            self.recipeTitle.text = recipe.name
            self.recipeFats.text = recipe.fats.isEmpty ? "No Fats" : "Fats: \(recipe.fats)"
            self.recipeCalories.text = recipe.calories.isEmpty ? "No Calories" : "Calories: \(recipe.calories)"
            self.recipeCarbos.text = recipe.carbos.isEmpty ? "No Carbos" : "Carbos: \(recipe.carbos)"
            if let imageData = recipe.imageData {
                self.recipeImage.image = UIImage.init(data: imageData)
            }
            
            
        }
    }
    
    
    @IBAction func didPressedFavoriteBtn(_ sender: UIButton) {
        guard let recipe else { return }
        let filledStarImage = UIImage(systemName: "star.fill")
        let unfilledStarImage = UIImage(systemName: "star")
        
        isFavorited.toggle()
        
        favBtn.setImage(isFavorited ? filledStarImage : unfilledStarImage, for: .normal)
        delegate?.favoriteButtonTapped(for: recipe)
    }
    
}
