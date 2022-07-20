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
final class LifeEventListRouter: LifeEventListRoutable {

    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    

    func route(to: Target) {
        switch to {
        case .addLifeEvent:
            print("Добавляем элемент")
            
        case .detailInfo:
            print("Окно детальной информации")
            
        case .settings:
            print("Настройки")
        }
    }
}
