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
        
        let model = EventModel(title: "Чирик-Чирик", specification: "Чижик пыжик, где ты был?")
        vc.presenter = presenter
        presenter.delegate = vc
        router.viewController = vc
        presenter.setupEditEvent(with: model)
    }
}
