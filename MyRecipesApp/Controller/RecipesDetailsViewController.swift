//
//  RecipesDetailsViewController.swift
//  MyRecipesApp
//
//  Created by Aviad Sabag on 29/11/2024.
//

import UIKit

class RecipesDetailsViewController: UIViewController {
    
    // MARK: - DetailsVC Vars/Lets:
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var protienLabel: UILabel!
    private var recipeDetailsViewModel : RecipesDetailsViewModel
    
    @IBOutlet weak var backButton: UIButton!
    
    
    // MARK: - View Controller Life Cycle Methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUIScreen()
        
    }
    
    
    init(with viewModel: RecipesDetailsViewModel) {
        self.recipeDetailsViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Class Methods:
    private func setupUIScreen() {
        // Round the corners
        backButton.layer.cornerRadius = backButton.frame.height / 2
        backButton.clipsToBounds = true // Ensures subviews are clipped to the rounded corners
        self.navigationController?.navigationBar.isHidden = true
        
        self.recipeTitle.text = recipeDetailsViewModel.getRecipeTitle
        self.protienLabel.text = "Proteins: \(recipeDetailsViewModel.getProteins)"
        self.difficultyLabel.text = "Difficulty: \(recipeDetailsViewModel.getDifficulty)"
        self.timeLabel.text = "\(recipeDetailsViewModel.getTime)"
        self.descTextView.text = recipeDetailsViewModel.getDescription
        
        if let imageData = recipeDetailsViewModel.getImagedata {
            self.recipeImage.image = UIImage.init(data: imageData)
        }
    }
    
    
    @IBAction func didPressedBackButton(_ sender: UIButton) {
        self.dismiss(animated: true , completion: nil)
    }
    
    
}
