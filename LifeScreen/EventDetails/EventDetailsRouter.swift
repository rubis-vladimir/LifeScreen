//
//  EventDetailsRouter.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.07.2022.
//

import UIKit

/// Протокол навигации модуля LifeScreen
protocol EventDetailsRoutable {
    func route()
}

/// Слой навигации модуля LifeScreen
final class EventDetailsRouter {
    
    private let navigateionController: UINavigationController
    
    init(navigateionController: UINavigationController) {
        self.navigateionController = navigateionController
    }
}

// MARK: - LifeScreenRoutable
extension EventDetailsRouter: EventDetailsRoutable {
    
    func route() {
        print("Переход на экран фотоальбома")
    }
}
