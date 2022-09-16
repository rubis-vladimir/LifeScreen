//
//  AddEventRouter.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 27.08.2022.
//

import UIKit

/// Навигация в модуле AddEvent
enum AddEventTarget {
    /// Загрузчик изображений
    case photoPiker
    /// Child VC с DataPicker
    case dataPicker
}

/// Протокол обновления модели и установки фото
protocol DisplayPhotoDelegate: AnyObject {
    
    /// Добавляет в текущую модель фото и обновляет UI элементы
    ///  - Parameter data: data загруженного изображения из галереи
    func send(responce: PhotoPickerResponse)
}

/// Протокол управления слоем навигации
protocol AddEventRouting {
    /// Переход по target
    func route(to: AddEventTarget)
}

/// Слой навигации модуля AddEvent
final class AddEventRouter {
    
    weak var viewController: AddEventViewController?
    weak var presenter: AddEventDisplayPhotoDelegate?
    private var photoPickerManager: PhotoPickerConfiguratable?
    
}

//MARK: - AddEventRouting
extension AddEventRouter: AddEventRouting {
    func route(to: AddEventTarget) {
        guard let vc = viewController else { return }
        
        switch to {
            
        case .photoPiker:
            photoPickerManager = PhotoPickerManager(delegate: self)
            photoPickerManager?.createPhotoPicker(completion: { picker in
                vc.present(picker, animated: true)
            })
        case .dataPicker:
            DatePickerBottomSheetViewController(presentedViewController: vc, presenting: .none)
        }
    }
}


//MARK: - DisplayPhotoProtocol
extension AddEventRouter: DisplayPhotoDelegate {
    func send(responce: PhotoPickerResponse) {
        if !responce.imagesData.isEmpty {
            presenter?.updateModel(with: responce.imagesData)
        }
    }
}
