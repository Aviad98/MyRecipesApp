//
//  LoadingCollectionViewCell.swift
//  MyRecipesApp
//
//  Created by Aviad Sabag on 30/11/2024.
//


import UIKit

class LoadingCollectionViewCell: UICollectionViewCell {
    static let identifier = "LoadingCollectionViewCell"
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .gray
        activityIndicator.style = .medium
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        activityIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
