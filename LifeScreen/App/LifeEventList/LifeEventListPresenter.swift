//
//  LifeEventListPresenter.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 19.07.2022.
//

import Foundation

/// Протокол передачи UI- эвентов слою презентации
protocol LifeEventListPresentation: AnyObject {
    func readyForLoadAndRoute(to: Target)
}

/// Протокол передачи Data-моделей слою презентации
protocol LifeEventListPresentationManagement: AnyObject {
    
}

/// Слой Презентации для модуля LifeEventList
final class LifeEventListPresenter {
    
    private weak var view: LifeEventListViewable?
    private let interactor: LifeEventListBusinessLogic
    private let router: LifeEventListRoutable
    
    init(view: LifeEventListViewable, interactor: LifeEventListBusinessLogic, router: LifeEventListRoutable) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - LifeEventListPresentation
extension LifeEventListPresenter: LifeEventListPresentation {
    func readyForLoadAndRoute(to: Target) {
        router.route(to: to)
    }
}

// MARK: - LifeEventListPresentationManagement
extension LifeEventListPresenter: LifeEventListPresentationManagement {
    
}


