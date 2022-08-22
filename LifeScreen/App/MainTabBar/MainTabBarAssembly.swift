//
//  MainTabBarAssembly.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 17.08.2022.
//

import UIKit

/// Компоновщик VIPER-модуля MainTabBar
final class MainTabBarAssembly {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - Assemblying
extension MainTabBarAssembly: Assemblying {
    
    func assembly(viewController: UIViewController) {
        guard let vc = viewController as? MainTabBarController else { return }
        
        let router = MainTabBarRouter()
        let presenter = MainTabBarPresenter(viewController: vc,
                                            router: router)
        
        vc.presenter = presenter
        router.navigationController = navigationController
        
        generateTabBar(vc)
    }
    
    /// Настройка TabBar
    /// - Parameter tb: TabBar-VC
    private func generateTabBar(_ tb: UITabBarController) {
        
        let c = UIImage.SymbolConfiguration(pointSize: 19, weight: .light)
        
        tb.viewControllers = [
            setupChildVC(LifeEventListViewController(),
                    image: UIImage(systemName: "person")?.withConfiguration(c),
                    selectedImage: UIImage(systemName: "person.fill")?.withConfiguration(c)),
            
            UIViewController(),
            
            setupChildVC(LifeScreenViewController(),
                    image: UIImage(systemName: "square.split.2x2")?.withConfiguration(c),
                    selectedImage: UIImage(systemName: "square.split.2x2.fill")?.withConfiguration(c))
        ]
        
        tb.setViewControllers(tb.viewControllers, animated: false)
        
    }
    
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
