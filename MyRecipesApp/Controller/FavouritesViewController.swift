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
    weak var favouritesRecipesViewModel: FavouritesRecipesViewModel?
    
    
    // MARK: - VC Life Cycle Methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewUI()

    }

    deinit {
    }
    
    
    // MARK: - Class Methods:
    private func setupTableViewUI() {
        self.tableView.dataSource = self
        
        
        if let viewModel = self.favouritesRecipesViewModel, viewModel.favRecipes?.isEmpty ?? true  {
            self.noFavLabel.isHidden = false
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
        return self.favouritesRecipesViewModel?.favRecipes?.count ?? 0 // incase we dont have fav recpies we return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellReuseIdentifiers.favoriteTableViewCellIdentifier, for: indexPath) as? FavouriteTableViewCell else {
            return UITableViewCell()
        }
        if let vm = self.favouritesRecipesViewModel {
            cell.configureCell(with: vm.getFavoriteRecipes[indexPath.row])
        }
        return cell
    }
}

