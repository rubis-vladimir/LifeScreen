//
//  LifeScreenInteractor.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.07.2022.
//

import Foundation

/// Протокол управления бизнес-логикой в модуле LifeScreen
protocol LifeScreenBusinessLogic {
    
}

/// Слой бизнес-логики модуля LifeScreen
final class LifeScreenInteractor {
    
    weak var presenter: LifeScreenPresentationManagement?
}

// MARK: - LifeScreenBusinessLogic
extension LifeScreenInteractor: LifeScreenBusinessLogic {
    
}
