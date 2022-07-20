//
//  LifeScreenInteractor.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.07.2022.
//

import Foundation

/// Протокол управления бизнес-логикой в модуле LifeScreen
protocol LifeScreenBusinessLogic {
    
    /// Осуществить загрузку (из сети) и сохранить данные в кэш
    ///  - Parameter completion: closure по выполнению (флаг успешности / ошибка)
    func loadData(completion: @escaping (Result<Data, Error>) -> Void)
}

/// Слой бизнес-логики модуля LifeScreen
final class LifeScreenInteractor {
    
    weak var presenter: LifeScreenPresentationManagement?
}

// MARK: - LifeScreenBusinessLogic
extension LifeScreenInteractor: LifeScreenBusinessLogic {
    func loadData(completion: @escaping (Result<Data, Error>) -> Void) {
        <#code#>
    }
}
