//
//  EventDetailsAssembly.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.07.2022.
//

import UIKit

/// Компоновщик VIPER-модуля LifeScreen
final class EventDetailsAssembly {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - Assemblying
extension EventDetailsAssembly: Assemblying {
    func assembly(viewController: UIViewController) {
        guard let vc = viewController as? EventDetailsViewController else { return }
        
        let interactor = EventDetailsInteractor()
        let router = EventDetailsRouter(navigateionController: navigationController)
        let presenter = EventDetailsPresenter(viewController: vc,
                                            interactor: interactor,
                                            router: router)
        
        vc.presenter = presenter
        
    }
}
