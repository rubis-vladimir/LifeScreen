//
//  UIViewController + Alert.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 03.10.2022.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, messege: String) {
        let alert = UIAlertController(title: title,
                                      message: messege,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}
