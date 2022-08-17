//
//  MainTabBarRouter.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 17.08.2022.
//

import UIKit

/// Протокол управления слоя навигации модуля MainTabBar
protocol MainTabBarRoutable {
    
    
    func route()
}

/// Слой навигации модуля MainTabBar
final class MainTabBarRouter {
    var navigationController: UINavigationController?
}

// MARK: - MainTabBarRoutable
extension MainTabBarRouter: MainTabBarRoutable {
    
    func route() {
//        let vc = AddEventViewController()
        print("Переход на экран добавления События")
    }
}
