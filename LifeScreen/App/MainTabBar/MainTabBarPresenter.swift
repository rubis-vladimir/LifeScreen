//
//  MainTabBarPresenter.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 17.08.2022.
//

import UIKit

/// Протокол передачи UI-эвентов слою презентации
protocol MainTabBarPresentation {
    
    /// Отправка запроса навигации
    func readyForRoute()
}

/// Слой презентации модуля MainTabBar
final class MainTabBarPresenter {
    
    private weak var viewController: MainTabBarViewable?
    private let router: MainTabBarRouter
    
    init(viewController: MainTabBarViewable, router: MainTabBarRouter) {
        self.viewController = viewController
        self.router = router
    }
}

// MARK: - MainTabBarPresentation
extension MainTabBarPresenter: MainTabBarPresentation {
    func readyForRoute() {
        router.route()
    }
}
