//
//  AddEventPresenter.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 17.08.2022.
//

import Foundation

/// Протокол передачи UI-эвентов слою презентации
protocol AddEventPresentation {
    
    /// Переход по target
    func route(to: AddEventTarget)
    
    /// Cохранение события
    func save(event: AddEventModel)
}

protocol AddEventPresentationManagement: AnyObject {
    
}

/// Слой презентации модуля AddEvent
final class AddEventPresenter {
    private weak var viewController: AddEventViewable?
    private let interactor: AddEventBusinessLogic
    private let router: AddEventRouting
    
    init(viewController: AddEventViewable, interactor: AddEventBusinessLogic, router: AddEventRouting) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - AddEventPresentation
extension AddEventPresenter: AddEventPresentation {
}


// MARK: - AddEventPresentationManagement
extension AddEventPresenter: AddEventPresentationManagement {
    
    func route(to: AddEventTarget) {
        router.route(to: to)
    }
    
    func save(event: AddEventModel) {
        interactor.save(event: event)
    }
}
