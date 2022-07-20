//
//  EventDetailsInteractor.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.07.2022.
//

import Foundation

/// Протокол управления бизнес-логикой в модуле LifeScreen
protocol EventDetailsBusinessLogic {
    
}

/// Слой бизнес-логики модуля LifeScreen
final class EventDetailsInteractor {
    
    weak var presenter: EventDetailsPresentationManagement?
}

// MARK: - LifeScreenBusinessLogic
extension EventDetailsInteractor: EventDetailsBusinessLogic {
    
}
