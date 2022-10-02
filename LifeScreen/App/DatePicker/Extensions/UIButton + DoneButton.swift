//
//  UIButton + DoneButton.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.09.2022.
//

import UIKit

extension UIButton {
    
    /// Создает кнопку с конфигурацией
    ///  - Parameter action: отработка действия при нажатии на кнопку
    ///  - Returns: кнопка
    func createButtonTest(action: UIAction) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.title = "Done"
        config.baseForegroundColor = .black.withAlphaComponent(0.7)
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: "Helvetica-Bold", size: 20)
            return outgoing
        }
        let button = UIButton(configuration: config,
                              primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
