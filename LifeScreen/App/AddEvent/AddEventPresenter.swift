//
//  AddEventPresenter.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 17.08.2022.
//

import Foundation

/// Протокол передачи UI-эвентов слою презентации
protocol AddEventPresentation: AnyObject {
    
    /// Текущая модель события
    var eventModel: AddEventModel { get }
    /// Обработка UI-эвентов а зависимости от типа
    func handleAction(_ type: AddEventActions)
}

/// Протокол передачи
protocol AddEventResponseDelegate: AnyObject {
    
    /// Обрабатывает ответ от PhotoPicker
    ///  - Parameter response: ответ
    func handleResponse(_ response: AddEventResponse)
}

protocol AddEventDatePickerDelegate: AnyObject {
    
}

/// Пока не используется
protocol AddEventPresentationManagement: AnyObject {
    
}

/// Слой презентации модуля AddEvent
final class AddEventPresenter {
    /// Модель редактируемого события
    var editModel: EventModel?
    
    private(set) var eventModel: AddEventModel = AddEventModel(imageData: [], title: "", text: "", date: Date()) {
        didSet {
            delegate?.updateUI()
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
    
    func setupEditEvent(with model: EventModel?) {
        guard let model = model else { return }
        changeModel(.setEditEvent(model))
    }
}

// MARK: - AddEventPresentation
extension AddEventPresenter: AddEventPresentation {
    
    func handleAction(_ type: AddEventActions) {
        switch type {
        case .route(let target):
            router.route(to: target, moduleOutput: self)

        case .saveEvent:
            interactor.saveEvent { [weak self] error in
                if let error = error {
                    self?.delegate?.showError(error)
                    self?.delegate?.isSave = false
                } else {
                    self?.delegate?.isSave = true
                }
            }
            
        case .changeEvent(let change):
            changeModel(change)
        }
    }
    
    private func changeModel(_ type: AddEventChangeModelActions) {
        interactor.changeModel(type: type) { [weak self] result in
            switch result {
            case .success(let model):
                self?.eventModel = model
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}

//MARK: - AddEventDisplayPhotoDelegate
extension AddEventPresenter: AddEventResponseDelegate {
    
    func handleResponse(_ response: AddEventResponse) {
        
        switch response {
        case .photoPicker(let response):
            if !response.imagesData.isEmpty {
                changeModel(.uploadImage(response.imagesData))
            }
            if let error = response.error {
                delegate?.showError(error)
            }
        case .dataPicker(let date):
            changeModel(.updateDate(date))
        }
    }
}

// MARK: - AddEventPresentationManagement
extension AddEventPresenter: AddEventPresentationManagement {
    
    
}


