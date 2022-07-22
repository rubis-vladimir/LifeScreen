//
//  LifeScreenRouter.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.07.2022.
//

import UIKit

/// Протокол навигации модуля LifeScreen
protocol LifeScreenRoutable {
    func route()
}

/// Слой навигации модуля LifeScreen
final class LifeScreenRouter {
    
    var navigateionController: UINavigationController?
    
}

// MARK: - LifeScreenRoutable
extension LifeScreenRouter: LifeScreenRoutable {
    
    func route() {
        print("Переход на экран детальной информации")
    }
}
