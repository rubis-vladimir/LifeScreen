//
//  LifeScreenPresenter.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.07.2022.
//

import Foundation

/// Протокол передачи UI-эвентов слою презентации
protocol LifeScreenPresentation: AnyObject {
    func getViewModels(competion: @escaping (Result<[EventCollageCellViewModelProtocol], Error>) -> Void)
}
/// Протокол передачи Data-моделей слою презентации
protocol LifeScreenPresentationManagement: AnyObject {
    
}

/// Слой презентации модуля LifeScreen
final class LifeScreenPresenter {
    
    private weak var viewController: LifeScreenViewable?
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
    func getViewModels(competion: @escaping (Result<[EventCollageCellViewModelProtocol], Error>) -> Void) {
        interactor.getUrls { result in
            
            switch result {
            case .success(let events):
                let viewModels: [EventCollageCellViewModelProtocol] = events.compactMap {
                    guard let url = URL(string: $0.mainImage?.url ?? ""),
                          let width = $0.thumbnail?.width,
                          let heigth = $0.thumbnail?.height else { return nil }
                    return EventCollageCellViewModel.init(url: url,
                                                                   width: width,
                                                                   height: heigth)
                }
                
                print("создали ViewModels")
                competion(.success(viewModels))
            case .failure(let error):
                competion(.failure(error))
            }
        }
    }
}

// MARK: - LifeScreenPresentationManagement
extension LifeScreenPresenter: LifeScreenPresentationManagement {
    
}
