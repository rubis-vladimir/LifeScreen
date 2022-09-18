//
//  UIButton + CustomSetup.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 17.09.2022.
//

import UIKit

extension UIButton {
    
    func createChangeSlideshowButton(imageName: String, selector: Selector) -> UIButton {
        let button = UIButton()
        let c = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .large)
        let image = UIImage(systemName: imageName)?.withConfiguration(c)
        
        button.setImage(image, for: .normal)
        button.backgroundColor = .systemGray.withAlphaComponent(0.3)
        button.tintColor = .white
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        return button
    }
    
    
}
