//
//  MainTabBarRouter.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 17.08.2022.
//

import UIKit

/// Протокол управления слоя навигации модуля MainTabBar
protocol MainTabBarRoutable {
    
    /// Переход к AddEventVC
    func route()
}

/// Слой навигации модуля MainTabBar
final class MainTabBarRouter {
    var navigationController: UINavigationController?
}

// MARK: - MainTabBarRoutable
extension MainTabBarRouter: MainTabBarRoutable {
    
    func route() {
        print("Переход на экран добавления События")
        guard let nc = navigationController else { return }
        
        let vc = AddEventViewController()
//        let nc = UINavigationController(rootViewController: vc)
        
        AddEventAssembly(navigationController: nc).assembly(viewController: vc)
        
//        nc.modalPresentationStyle = .fullScreen
//        nc.present(vc, animated: true)
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        
        nc.view.layer.add(transition, forKey: nil)
        
//        nc.modalPresentationStyle = .fullScreen
        nc.pushViewController(vc, animated: false)
    }
}
