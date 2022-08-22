//
//  AddEventPresenter.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 17.08.2022.
//

import Foundation

/// Протокол передачи UI-эвентов слою презентации
protocol AddEventPresentation {
    
}

protocol AddEventPresentationManagement: AnyObject {
    
}

/// Слой презентации модуля AddEvent
final class AddEventPresenter {
    private weak var viewController: AddEventViewable?
    private let interactor: AddEventBusinessLogic
    
    init(viewController: AddEventViewable, interactor: AddEventBusinessLogic) {
        self.viewController = viewController
        self.interactor = interactor
    }
}

// MARK: - AddEventPresentation
extension AddEventPresenter: AddEventPresentation {
    
}


// MARK: - AddEventPresentationManagement
extension AddEventPresenter: AddEventPresentationManagement {
    
}
