//
//  LifeScreenInteractor.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.07.2022.
//

import Foundation

/// Протокол управления бизнес-логикой в модуле LifeScreen
protocol LifeScreenBusinessLogic {
    
    /// Осуществить преобразование String в URL
    ///  - Parameter completion: closure по выполнению (флаг успешности / ошибка)
    func getUrls(completion: @escaping (Result<[Event], Error>) -> Void)
}

/// Слой бизнес-логики модуля LifeScreen
final class LifeScreenInteractor {
    
    private var events: [Event] = []
    weak var presenter: LifeScreenPresentationManagement?
    lazy var lanWorker: LifeScreenPresentetionLanWorker = LifeScreenPresentetionLanWorker()
}

// MARK: - LifeScreenBusinessLogic
extension LifeScreenInteractor: LifeScreenBusinessLogic {
    func getUrls(completion: @escaping (Result<[Event], Error>) -> Void) {
    
        lanWorker.getDataModels { result in
            switch result {
            case .success(let events):
                print("Создали DataModels")
                completion(.success(events))
            case .failure(let lanError):
                completion(.failure(lanError))
            }
        }
    }
}
