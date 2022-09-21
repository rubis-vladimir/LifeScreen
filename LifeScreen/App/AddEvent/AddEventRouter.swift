//
//  AddEventRouter.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 27.08.2022.
//

import UIKit

/// Типы ответов от модулей PhotoPicker и DatePickerBottomSheet
enum AddEventResponse {
    /// Ответ от PhotoPicker
    case photoPicker(response: PhotoPickerResponse)
    /// Ответ от DatePicker
    case dataPicker(date: Date)
}

/// Навигация в модуле AddEvent
enum AddEventTarget {
    /// Загрузчик изображений
    case photoPicker
    /// Child VC с DataPicker
    case dataPicker(date: Date)
}

/// Протокол управления слоем навигации
protocol AddEventRouting {
    /// Переход по target
    func route(to: AddEventTarget, moduleOutput: AddEventResponseDelegate)
}

/// Слой навигации модуля AddEvent
final class AddEventRouter {
    weak var viewController: AddEventViewController?
    private lazy var photoPickerManager = PhotoPickerManager()
}

//MARK: - AddEventRouting
extension AddEventRouter: AddEventRouting {
    
    func route(to: AddEventTarget,
               moduleOutput: AddEventResponseDelegate) {
        guard let vc = viewController else { return }
        
        switch to {
        case .photoPicker:
            photoPickerManager.setupNewSession()
            photoPickerManager.delegate = moduleOutput
            photoPickerManager.createPhotoPicker{ picker in
                vc.present(picker, animated: true)
            }
        case .dataPicker(let date):
            
            let sheet = DatePickerBottomSheetViewController()
            sheet.view.backgroundColor = .clear
            if let sheet = sheet.sheetPresentationController {
                sheet.detents = [.medium()]
//                sheet.selectedDetentIdentifier = .medium
            }
            DatePickerBottomSheetAssembly().assembly(viewController: sheet,
                                                     date: date,
                                                     moduleOutput: moduleOutput)
            
            vc.present(sheet, animated: true)
        }
    }
}


