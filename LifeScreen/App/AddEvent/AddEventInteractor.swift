//
//  AddEventInteractor.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 17.08.2022.
//

import Foundation

enum AddEventChangeModelActions {
    /// Добавляем данные изображений
    case uploadImage(_ imageData: [Data])
    /// Изменяем текстовые данные в модели события
    case changeText(_ text: String, type: AddEventCellType)
    /// Удаляем изображение
    case deleteImage(_ index: Int)
    /// Устанавливает редактируемое событие
    case setEditEvent(_ model: EventModel)
    /// Устанавливает новую дату
    case updateDate(_ date: Date)
}

enum AddEventFailure: Error {
    case failConvertImageData, eventNotExist, userModelNotFound, idNotTransferred, noValidate
}

/// Протокол управления бизнес логикой модуля AddEvent
protocol AddEventBusinessLogic {
    /// Изменяет модель
    ///  - Parameters:
    ///     - type: тип изменения модели события
    ///     - completion: захватывает новую модель
    func changeModel(type: AddEventChangeModelActions,
                     completion: @escaping (AddEventModel) -> Void)
    
    /// Сохраняет событие
    ///  - Parameter completion: захватывает ошибку
    func saveEvent(completion: @escaping (AddEventFailure?) -> Void)
}

/// Слой бизнес логики модуля AddEvent
final class AddEventInteractor {
    
    private let fileManagerService: FileManagerProtocol
    private let eventSaveManager: EventSaveProtocol
    
    private var eventModel: AddEventModel = AddEventModel(imageData: [], title: "", text: "", date: Date())
    private var id: String?
    
    init(fileManager: FileManagerProtocol = FileManagerService.shared,
         eventSaveManager: EventSaveProtocol = EventSaveManager()) {
        self.fileManagerService = fileManager
        self.eventSaveManager = eventSaveManager
    }
    
    private func validate() -> Bool {
        eventModel.title == "" || eventModel.imageData.isEmpty ? false : true
    }
    
    private func convertEditModel(_ editModel: EventModel) {
        let urlsString = editModel.images.reduce(into: []) {
            $0 += [$1.urlString]
        }
        let imagesData = urlsString.map {
            fileManagerService.getData(from: $0, date: editModel.date)
        }
        id = editModel.id
        eventModel = AddEventModel(imageData: imagesData,
                                   title: editModel.title,
                                   text: editModel.specification,
                                   date: editModel.date)
    }
}

// MARK: - AddEventBusinessLogic
extension AddEventInteractor: AddEventBusinessLogic {
    
    func changeModel(type: AddEventChangeModelActions,
                     completion: @escaping (AddEventModel) -> Void) {
        switch type {
        case .uploadImage(let imageData):
            eventModel.imageData = imageData
            
        case let .changeText(text, type):
            switch type {
            case .titleCell:
                eventModel.title = text
            case .infoCell:
                eventModel.text = text
            default: break
            }
            return
            
        case .deleteImage(let index):
            eventModel.imageData.remove(at: index)
            
        case .setEditEvent(let model):
            convertEditModel(model)
            
        case .updateDate(let date):
            eventModel.date = date
        }
        completion(eventModel)
    }
    
    func saveEvent(completion: @escaping (AddEventFailure?) -> Void) {
        guard validate() else {
            completion(.noValidate)
            return
        }
        eventSaveManager.convertAndSave(from: eventModel,
                                        id: id,
                                        completion: completion)
    }
}
