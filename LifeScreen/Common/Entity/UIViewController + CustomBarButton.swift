//
//  UIViewController + CustomBarButton.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 27.08.2022.
//

import UIKit

extension UIViewController {
    
    func createTitleButton(selector: Selector) -> UIButton {
        let button = UIButton()
        
        button.frame = CGRect(x: 0, y: 0, width: 180, height: 25)
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.systemGray4.cgColor
        
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        button.setTitleColor(.black.withAlphaComponent(0.7), for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    func createCustomBarButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate),
            for: .normal
        )
        button.tintColor = .black.withAlphaComponent(0.7)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
}
