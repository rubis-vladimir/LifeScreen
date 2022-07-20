//
//  EventDetailsPresenter.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.07.2022.
//

import Foundation

/// Протокол передачи UI-эвентов слою презентации
protocol EventDetailsPresentation: AnyObject {
    
}
/// Протокол передачи Data-моделей слою презентации
protocol EventDetailsPresentationManagement: AnyObject {
    
}

/// Слой презентации модуля LifeScreen
final class EventDetailsPresenter {
    
    weak var viewController: EventDetailsViewable?
    private let interactor: EventDetailsBusinessLogic
    private let router: EventDetailsRoutable
    
    init(viewController: EventDetailsViewable,
         interactor: EventDetailsBusinessLogic,
         router: EventDetailsRoutable) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - LifeScreenPresentation
extension EventDetailsPresenter: EventDetailsPresentation {
    
}

// MARK: - LifeScreenPresentationManagement
extension EventDetailsPresenter: EventDetailsPresentationManagement {
    
}
