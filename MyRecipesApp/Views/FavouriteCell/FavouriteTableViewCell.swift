//
//  FavouriteTableViewCell.swift
//  MyRecipesApp
//
//  Created by Aviad Sabag on 30/11/2024.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var heartButton: UIButton!
    @IBOutlet private weak var recipeCalories: UILabel!
    @IBOutlet private weak var recipeTime: UILabel!
    @IBOutlet private weak var recipeName: UILabel!
    @IBOutlet private weak var recipeImage: UIImageView!
    
    @IBOutlet weak var circleBackGroundView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.heartButton.layer.cornerRadius = self.frame.size.width / 2
        self.heartButton.imageView?.contentMode = .scaleAspectFit
        
        self.circleBackGroundView.layer.masksToBounds = true
        self.circleBackGroundView.layer.cornerRadius = self.circleBackGroundView.frame.size.height/2

        
        
        self.recipeImage.layer.cornerRadius = 10
        self.recipeImage.layer.masksToBounds = true
        
        
        self.contentView.layer.cornerRadius = 12
        self.contentView.layer.masksToBounds = true
        
        // Add a shadow
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 0.2
        self.contentView.layer.shadowRadius = 4
        self.contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    func configureCell(with recipe: Recipe) {
        DispatchQueue.main.async {
            self.recipeName.text = recipe.name
            self.recipeTime.text = "⏰\(recipe.time) mins"
            self.recipeCalories.text = "🔥\(recipe.calories) cal"
            if let imageData = recipe.imageData {
                self.recipeImage.image = UIImage.init(data: imageData)
            }
        }
    }
}
