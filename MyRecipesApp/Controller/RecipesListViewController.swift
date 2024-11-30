//
//  RecipesListViewController.swift
//  MyRecipesApp
//
//  Created by Aviad Sabag on 28/11/2024.
//

import UIKit
import Foundation
import LocalAuthentication
import Security


class RecipesListViewController: UIViewController {
    
    // MARK: - Vars/Lets:
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var loaderIndiactor: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!    
    @IBOutlet weak var noDataLabel: UILabel!
    
    private let recipesViewModel = RecipesViewModel()
    
    
    
    // MARK: - View Controller Life Cycle Methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.loadData()
        self.updateCollectionViewAfterFilter()
        
    }
    
    
    // MARK: - Class Methods:
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.loaderIndiactor.startAnimating()
        self.noDataLabel.isHidden = true
        self.collectionView.register(UINib(nibName: Constants.NibIdentifiers.recipeCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.CellReuseIdentifiers.recipeCollectionViewIdentifier)
        self.collectionView.register(LoadingCollectionViewCell.self, forCellWithReuseIdentifier: Constants.CellReuseIdentifiers.loadingCollectionViewCell)

    }
    
    private func loadData() {
        recipesViewModel.fetchRecipes { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                    self?.loaderIndiactor.stopAnimating()
                    self?.loaderIndiactor.hidesWhenStopped = true
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.loaderIndiactor.stopAnimating()
                    self?.loaderIndiactor.hidesWhenStopped = true
                    self?.noDataLabel.isHidden = false
                    self?.showErrorAlert(message: Constants.ErrorMessages.failedFetching)
                }
            }
        }
        
    }
    
    private func updateCollectionViewAfterFilter() {
        self.recipesViewModel.onRecipesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func showDetailsVC(for index: Int) {
        if let viewModel = self.recipesViewModel.getViewModel(for: index) {
            let viewControllerToPresent = RecipesDetailsViewController(with: viewModel)
            let navigationController = UINavigationController(rootViewController: viewControllerToPresent)
            
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    private func showFavouritesVC() {
        if let viewmodel = self.recipesViewModel.getFavoriteRecipeViewModel() {
            let vcToPresent = FavouritesViewController(with: viewmodel)
            let navigationController = UINavigationController(rootViewController: vcToPresent)
            
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func didPressedFavBtn(_ sender: UIBarButtonItem) {
        
        showFavouritesVC()
        
    }
    
    
}

// MARK: - CollectionView Data Source Methods:
extension RecipesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let inSearchMode = self.recipesViewModel.inSearchMode(searchText: self.searchBar.text ?? "")
        return inSearchMode ? self.recipesViewModel.filteredRecipes.count : self.recipesViewModel.recipes.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == self.recipesViewModel.recipes.count {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellReuseIdentifiers.loadingCollectionViewCell, for: indexPath) as? LoadingCollectionViewCell else {
                fatalError()
            }
            
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellReuseIdentifiers.recipeCollectionViewIdentifier, for: indexPath) as? RecipeCollectionViewCell else { return UICollectionViewCell() }
        
        let inSearchMode = self.recipesViewModel.inSearchMode( searchText: self.searchBar.text ?? "")
        let recipe = inSearchMode ? self.recipesViewModel.filteredRecipes[indexPath.row] : self.recipesViewModel.recipes[indexPath.row]
        
        cell.configureRecipeCell(with: recipe)
        cell.delegate = self
        return cell
    }
    
    
}

// MARK: - RecipeListCell Delegate Methods:
extension RecipesListViewController: RecipeListCellDelegate {
    func favoriteButtonTapped(for recipe: Recipe) {
        self.recipesViewModel.configureFavourites(recipe: recipe)
    }
    
}

// MARK: - CollectionView Delegate Methods:
extension RecipesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetailsVC(for: indexPath.row)
    }
    
}
// MARK: - UICollectionViewDelegateFlowLayout Delegate Methods:
extension RecipesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2
        return CGSize(width: width, height: width)
    }
}
// MARK: - UISearchBar Delegate Methods:
extension RecipesListViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.recipesViewModel.updateIsInSearchMode(true)
        self.searchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.recipesViewModel.updateIsInSearchMode(true)
        self.recipesViewModel.updateSearchController(searchBarText: searchText)
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.recipesViewModel.updateIsInSearchMode(false)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.recipesViewModel.updateIsInSearchMode(false)
        self.searchBar.endEditing(true)
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3) {
            searchBar.resignFirstResponder()
            searchBar.text = ""
            searchBar.showsCancelButton = false
            self.view.layoutIfNeeded()
        }
    }
}

