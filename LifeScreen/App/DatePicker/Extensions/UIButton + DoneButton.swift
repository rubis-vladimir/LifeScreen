//
//  UIButton + DoneButton.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.09.2022.
//

import UIKit

extension UIButton {
    
    func createDoneButton(selector: Selector) -> UIButton {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.setTitle("Готово", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        button.titleLabel?.textColor = .black
        button.addTarget(self,
                         action: selector,
                         for: .touchUpInside)
        return button
    }
    
    func createButtonTest(action: UIAction) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.title = "Done"
        config.baseForegroundColor = .black
        config.cornerStyle = .medium
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: "Helvetica", size: 17)
            return outgoing
        }
        let button = UIButton(configuration: config, primaryAction: action)
        return button
    }
}
