//
//  LifeEventListInteractor.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 19.07.2022.
//

import Foundation

/// Протокол управления бизнес-логикой модуля LifeEventList
protocol LifeEventListBusinessLogic {
    
    /// Осуществить загрузку (из сети) и сохранить данные в кэш
    ///  - Parameter completion: closure по выполнению (флаг успешности / ошибка)
    func loadData(completion: @escaping (Result<Data, Error>) -> Void)
}

/// Слой бизнес-логики модуля LifeEventList
final class LifeEventListInteractor {
    
    weak var presenter: LifeEventListPresentationManagement?
    
}

// MARK: - LifeEventListBusinessLogic
extension LifeEventListInteractor: LifeEventListBusinessLogic {
    func loadData(completion: @escaping (Result<Data, Error>) -> Void) {
        
    }
}
