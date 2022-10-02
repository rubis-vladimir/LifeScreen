//
//  DatePickerBottomSheetAssembly.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.09.2022.
//

import UIKit

/// Компоновщик для DatePickerBottomSheet
final class DatePickerBottomSheetAssembly {
    
    func assembly(viewController: UIViewController,
                  date: Date,
                  moduleOutput: AddEventResponseDelegate) {
        
        guard let viewController = viewController as? DatePickerBottomSheetViewController else { return }
        let presenter = DatePickerBottomSheetPresenter(date: date)
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.updateView()
        presenter.delegate = moduleOutput
    }
}
