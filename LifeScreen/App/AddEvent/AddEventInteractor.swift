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
    ///     - completion: захватывает новую модель/ошибку
    func changeModel(type: AddEventChangeModelActions,
                     completion: @escaping (Result<AddEventModel, AddEventFailure>) -> Void)
    
    /// Сохраняет событие
    func saveEvent(completion: @escaping (AddEventFailure?) -> Void)
}

/// Слой бизнес логики модуля AddEvent
final class AddEventInteractor {
    
    private(set) var eventModel: AddEventModel = AddEventModel(imageData: [], title: "", text: "", date: Date())
    private var id: String?
    
    weak var presenter: AddEventPresentationManagement?
    private let fileManagerService: FileManagerProtocol
    private let localeStorage: LocaleStorageManagement
    
    init(fileManager: FileManagerProtocol = FileManagerService(),
         localeStorage: LocaleStorageManagement = LocaleStorageManager()) {
        self.fileManagerService = fileManager
        self.localeStorage = localeStorage
    }
    
    func getCorvertEditModel(editModel: EventModel,
                             completion: @escaping (Result<AddEventModel, AddEventFailure>) -> Void) {
        
        let imageDatas = editModel.images.compactMap { [weak self] image in
            self?.getImageDataFromFile(editModel: editModel,
                                       urlString: image.urlString)
        }
        
        
        
        eventModel = AddEventModel(imageData: [] ,
                                   title: editModel.title,
                                   text: editModel.specification,
                                   date: editModel.date)
        self.id = editModel.id
        completion(.success(eventModel))
    }
    
    func validate() -> Bool {
        eventModel.title == "" || eventModel.imageData.isEmpty ? false : true
    }
    
    /// Получает data из файла, если он существует по заданному пути
    private func getImageDataFromFile(editModel: EventModel, urlString: String) -> Data? {
        
        guard let filePath = fileManagerService.read(from: "2022", and: editModel.title, file: urlString) else { return nil }
        
        var data: Data?
        do {
            data = try Data(contentsOf: filePath)
        } catch let error  {
            print(error.localizedDescription)
        }
        return data
    }
}

// MARK: - AddEventBusinessLogic
extension AddEventInteractor: AddEventBusinessLogic {
    
    func changeModel(type: AddEventChangeModelActions,
                     completion: @escaping (Result<AddEventModel, AddEventFailure>) -> Void) {
        
        switch type {
        case .uploadImage(let imageData):
            eventModel.imageData = imageData
            completion(.success(eventModel))
            
        case .changeText(let text, let type):
            switch type {
            case .titleCell:
                eventModel.title = text
            case .infoCell:
                eventModel.text = text
            default: break
            }
            
        case .deleteImage(let index):
            eventModel.imageData.remove(at: index)
            completion(.success(eventModel))
            
        case .setEditEvent(let model):
            getCorvertEditModel(editModel: model, completion: completion)
            
        case .updateDate(let date):
            eventModel.date = date
            completion(.success(eventModel))
        }
        
    
    }
    
    func saveEvent(completion: @escaping (AddEventFailure?) -> Void) {
        guard validate() else {
            completion(.noValidate)
            return
        }
        
        switch id {
        case .none:
            let event = EventModel()
            convertEvent(from: eventModel, to: event, completion: completion)
            localeStorage.saveObject(event)
            
        case .some(let id):
            let model = eventModel
            guard let event = localeStorage
                .fetchObjects(EventModel.self)?
                .filter({ $0.id == id })
                .first else {
                completion(.eventNotExist)
                return
            }
            
            localeStorage.updateObject(event) { [weak self] in
                self?.convertEvent(from: model, to: event, completion: completion)
            }
        }
    }
    
    private func convertEvent(from model: AddEventModel,
                              to event: EventModel,
                              completion: @escaping (AddEventFailure?) -> Void) {
        event.title = model.title ?? ""
        event.specification = model.text ?? ""
        event.date = model.date ?? Date()
        event.id = "\(model.title ?? "")+12345"
        
        guard let data = model.imageData[0] else { return }
        guard let newUrlString = FileManagerService.shared.write(
            data,
            to: "2022",
            and: model.title ?? "",
            file: "Test123"
        ) else { return }
        
        
        event.images.append(Image(urlString: newUrlString))
    }
}
