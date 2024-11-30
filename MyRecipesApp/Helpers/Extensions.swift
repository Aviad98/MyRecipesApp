//
//  Extensions.swift
//  MyRecipesApp
//
//  Created by Aviad Sabag on 29/11/2024.
//

import UIKit

extension UIViewController {
    
    
    func showErrorAlert(message: String) {
       let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
       let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
       alertController.addAction(okAction)
       present(alertController, animated: true, completion: nil)
   }
    
}



extension UIView {
    var parentViewController: UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            responder = responder?.next
            if let vc = responder as? UIViewController {
                return vc
            }
        }
        return nil
    }
    
    var parentCollectionView: UICollectionView? {
        var view = self.superview
        while view != nil {
            if let collectionView = view as? UICollectionView {
                return collectionView
            }
            view = view?.superview
        }
        return nil
    }
}
