//
//  LifeScreenPresenter.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.07.2022.
//

import Foundation

/// Протокол передачи UI-эвентов слою презентации
protocol LifeScreenPresentation: AnyObject {
    
}
/// Протокол передачи Data-моделей слою презентации
protocol LifeScreenPresentationManagement: AnyObject {
    
}

/// Слой презентации модуля LifeScreen
final class LifeScreenPresenter {
    
    weak var viewController: LifeScreenViewable?
    private let interactor: LifeScreenBusinessLogic
    private let router: LifeScreenRoutable
    
    init(viewController: LifeScreenViewable,
         interactor: LifeScreenBusinessLogic,
         router: LifeScreenRoutable) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - LifeScreenPresentation
extension LifeScreenPresenter: LifeScreenPresentation {
    
}

// MARK: - LifeScreenPresentationManagement
extension LifeScreenPresenter: LifeScreenPresentationManagement {
    
}
