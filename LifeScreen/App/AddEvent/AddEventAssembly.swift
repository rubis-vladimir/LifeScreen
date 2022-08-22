//
//  AddEventAssembly.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 17.08.2022.
//

import UIKit

/// Компоновщик VIPER-модуля AddEvent
final class AddEventAssembly {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - Assemblying
extension AddEventAssembly: Assemblying {
    
    func assembly(viewController: UIViewController) {
        
        guard let vc = viewController as? AddEventViewController else { return }
        let interactor = AddEventInteractor()
        let presenter = AddEventPresenter(viewController: vc,
                                          interactor: interactor)
        vc.presenter = presenter
        interactor.presenter = presenter
    }
}
