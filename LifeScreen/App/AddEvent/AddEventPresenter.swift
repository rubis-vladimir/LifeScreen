//
//  AddEventPresenter.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 17.08.2022.
//

import Foundation

/// Протокол передачи UI-эвентов слою презентации
protocol AddEventPresentation {
    
    /// Текущая модель события
    var eventModel: AddEventModel { get }
    /// Настраивает событие при необходимости его изменения
    func setupEditEvent()
    /// Переход по target
    func route(to: AddEventTarget)
    /// Cохранение события
    func save(event: AddEventModel)
}

/// Протокол передачи
protocol AddEventDisplayPhotoDelegate: AnyObject {
    
    /// Обновляет модель при загрузке изображения
    ///  - Parameter imageData: data изображения
    func updateModel(with imageData: Data)
}

/// Пока не используется
protocol AddEventPresentationManagement: AnyObject {
    
}

/// Слой презентации модуля AddEvent
final class AddEventPresenter {
    /// Модель редактируемого события
    var editModel: EventModel?
    
    private(set) var eventModel: AddEventModel = AddEventModel(title: "", text: "") {
        didSet {
            delegate?.updateUI(with: eventModel)
        }
    }
    
    weak var delegate: AddEventPresenterDelegate?
    private let interactor: AddEventBusinessLogic
    private let router: AddEventRouting
    
    init(interactor: AddEventBusinessLogic = AddEventInteractor(),
         router: AddEventRouting = AddEventRouter()) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - AddEventPresentation
extension AddEventPresenter: AddEventPresentation {
    
    func setupEditEvent() {
        guard let editModel = editModel else { return }
        
        interactor.getCorvertEditModel(editModel: editModel) { [weak self] result in
            switch result {
            case .success(let model):
                self?.eventModel = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func route(to: AddEventTarget) {
        router.route(to: to)
    }
    
    func save(event: AddEventModel) {
        interactor.save(event: event)
    }
}

//MARK: - AddEventDisplayPhotoDelegate
extension AddEventPresenter: AddEventDisplayPhotoDelegate {
    
    func updateModel(with imageData: Data) {
        
        interactor.changeModel(with: imageData) { [weak self] result in
            switch result {
            case .success(let model):
                self?.eventModel = model
            case .failure(let error):
                print("Ошибка", error.localizedDescription)
            }
        }
    }
}

// MARK: - AddEventPresentationManagement
extension AddEventPresenter: AddEventPresentationManagement {
    
    
}


