//
//  LifeEventListAssembly.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 19.07.2022.
//

import UIKit

/// Компоновщик VIPER-модуля LifeEventList
final class LifeEventListAssembly {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - Assemblying
extension LifeEventListAssembly: Assemblying {
    
    func assembly(viewController: UIViewController) {
        guard let vc = viewController as? LifeEventListViewController else { return }
        
        let interactor = LifeEventListInteractor()
        let router = LifeEventListRouter()
        let presenter = LifeEventListPresenter(view: vc,
                                               interactor: interactor,
                                               router: router)
        
        vc.presenter = presenter
        interactor.presenter = presenter
        router.navigationController = navigationController
    }
}
