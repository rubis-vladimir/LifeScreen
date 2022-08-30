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
extension AddEventAssembly {
    
    func assembly(viewController: UIViewController,
                  editModel: EventModel?) {
        
        guard let vc = viewController as? AddEventViewController else { return }
        let interactor = AddEventInteractor()
        let router = AddEventRouter()
        let presenter = AddEventPresenter(interactor: interactor,
                                          router: router)
        
        vc.presenter = presenter
        presenter.delegate = vc
        interactor.presenter = presenter
        router.viewController = vc
        router.presenter = presenter
        presenter.editModel = editModel
    }
}
