//
//  LifeEventListRouter.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 19.07.2022.
//

import UIKit

/// Варианты навигации
enum Target {
    /// Переход на экран добавления нового события
    case addLifeEvent
    
    /// Переход на экран детальной информации и редактирования события
    case detailInfo
    
    /// Переход к экрану настроек приложения
    case settings
}

/// Протокол управления слоем навигации модуля LifeEventList
protocol LifeEventListRoutable {
    
    /// Переход на другой VC
    ///  - Parameter to: кейс навигации
    func route(to: Target)
}

/// Слой навигации модуля LifeEventList
final class LifeEventListRouter {
    var navigationController: UINavigationController?
}
    
extension LifeEventListRouter: LifeEventListRoutable {

    func route(to: Target) {
        switch to {
        case .addLifeEvent:
            print("Добавляем элемент")
            
        case .detailInfo:
            print("Окно детальной информации")
            guard let nc = navigationController else { return }
            let vc = EventDetailsViewController()
            EventDetailsAssembly(navigationController: nc).assembly(viewController: vc)
            
            nc.pushViewController(vc, animated: true)
            
        case .settings:
            print("Настройки")
        }
    }
}
