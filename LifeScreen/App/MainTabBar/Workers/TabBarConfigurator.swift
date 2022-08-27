//
//  TabBarConfigurator.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 27.08.2022.
//

import UIKit

protocol TabBarConfiguration {
    func generate(tabBar: UITabBarController)
}


final class TabBarConfigurator {
    
    /// Настройка TabBar
    /// - Parameter tb: TabBar-VC
    
    
    /// Настройка VC и tabBarItem
    /// - Parameter viewController: Child-VC
    private func setupChildVC(_ viewController: UIViewController,
                              image: UIImage? = nil,
                              selectedImage: UIImage? = nil) -> UIViewController {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.selectedImage = selectedImage
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        /// Конфигурируем VIPER-модуль для Child-VC
        switch viewController {
        case viewController as? LifeScreenViewController:
            LifeScreenAssembly(navigationController: navigationController).assembly(viewController: viewController)
        case viewController as? LifeEventListViewController:
            LifeEventListAssembly(navigationController: navigationController).assembly(viewController: viewController)
        default: break
        }
        
        return viewController
    }
}

extension TabBarConfigurator: TabBarConfiguration {
    
    func generate(tabBar: UITabBarController) {
        
        let c = UIImage.SymbolConfiguration(pointSize: 19, weight: .light)
        
        tabBar.viewControllers = [
            setupChildVC(LifeEventListViewController(),
                         image: UIImage(systemName: "person")?.withConfiguration(c),
                         selectedImage: UIImage(systemName: "person.fill")?.withConfiguration(c)),
            
            UIViewController(),
            
            setupChildVC(LifeScreenViewController(),
                         image: UIImage(systemName: "square.split.2x2")?.withConfiguration(c),
                         selectedImage: UIImage(systemName: "square.split.2x2.fill")?.withConfiguration(c))
        ]
        
        tabBar.setViewControllers(tabBar.viewControllers, animated: false)
        
    }
}
