//
//  FavouritesViewController.swift
//  MyRecipesApp
//
//  Created by Aviad Sabag on 30/11/2024.
//

import UIKit

class FavouritesViewController: UIViewController {

    
    @IBOutlet weak var noFavLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private var favouritesRecipesViewModel : FavouritesRecipesViewModel

    
    // MARK: - VC Life Cycle Methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewUI()

    }

    init(with viewModel: FavouritesRecipesViewModel) {
        self.favouritesRecipesViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Class Methods:
    private func setupTableViewUI() {
        self.tableView.dataSource = self
        self.navigationController?.navigationBar.isHidden = true
        
        if let favRecipes = self.favouritesRecipesViewModel.favRecipes {
            self.noFavLabel.isHidden = favRecipes.isEmpty ? false : true
        }
        
        
        self.tableView.register(UINib(nibName: Constants.NibIdentifiers.favoriteTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.CellReuseIdentifiers.favoriteTableViewCellIdentifier)
        
    }
    
    @IBAction func didPressedBackBtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
}


// MARK: - TableView Data Source:
extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favouritesRecipesViewModel.favRecipes?.count ?? 0 // incase we dont have fav recpies we return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellReuseIdentifiers.favoriteTableViewCellIdentifier, for: indexPath) as? FavouriteTableViewCell else {
            return UITableViewCell()
        }
            cell.configureCell(with: self.favouritesRecipesViewModel.getFavoriteRecipes[indexPath.row])
        return cell
    }
}

