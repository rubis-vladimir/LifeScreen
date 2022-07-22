//
//  LifeScreenAssembly.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.07.2022.
//

import UIKit

/// Компоновщик VIPER-модуля LifeScreen
final class LifeScreenAssembly {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - Assemblying
extension LifeScreenAssembly: Assemblying {
    func assembly(viewController: UIViewController) {
        guard let vc = viewController as? LifeScreenViewController else { return }
        
        let interactor = LifeScreenInteractor()
        let router = LifeScreenRouter()
        let presenter = LifeScreenPresenter(viewController: vc,
                                            interactor: interactor,
                                            router: router)
        
        vc.presenter = presenter
        interactor.presenter = presenter
        router.navigateionController = navigationController
    }
}
