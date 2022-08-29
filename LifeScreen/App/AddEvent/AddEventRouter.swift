//
//  AddEventRouter.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 27.08.2022.
//

import UIKit

enum AddEventTarget {
    case photoPiker, dataPicker
}


/// Протокол управления слоем навигации
protocol AddEventRouting {
    func route(to: AddEventTarget)
}

/// Слой навигации модуля AddEvent
final class AddEventRouter {
    
    weak var viewController: AddEventViewController?
    var photoPickerManager: PhotoPickerConfiguratable?
    
}

//MARK: - AddEventRouting
extension AddEventRouter: AddEventRouting {
    func route(to: AddEventTarget) {
        guard let vc = viewController else { return }
        
        switch to {
            
        case .photoPiker:
            photoPickerManager?.createPhotoPicker(completion: { picker in
                vc.present(picker, animated: true)
            })
        case .dataPicker:
            DatePickerBottomSheetViewController(presentedViewController: vc, presenting: .none)
        }
        
        
        
        
//        vConroller.present(vc, animated: true)
    }
}
