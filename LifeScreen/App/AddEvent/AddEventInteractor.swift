//
//  AddEventInteractor.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 17.08.2022.
//

import Foundation


enum AddEventFailure: Error {
    case failConvertImageData, eventNotExist, userModelNotFound, idNotTransferred
}

/// Протокол управления бизнес логикой модуля AddEvent
protocol AddEventBusinessLogic {
    
    /// Переводит основную модель редактируемой EventModel в частную AddEventModel
    ///  - Parameters:
    ///    - editModel: модель редактируемого события
    ///    - completion: возвращает переопределенную модель
    func getCorvertEditModel(editModel: EventModel, completion: (Result<AddEventModel, AddEventFailure>) -> Void)
    
    /// Изменяет модель при загрузке изображения из PhotoPicker
    ///  - Parameters:
    ///     - imageData: Data подгружаемого изображения
    ///     - completion: захватывает новую модель
    func changeModel(with imageData: Data,
                     completion: @escaping (Result<AddEventModel, AddEventFailure>) -> Void)
    
    func changeModel(with text: String, type: AddEventCellType)
    
    /// Сохраняет событие
    func saveEvent()
}

/// Слой бизнес логики модуля AddEvent
final class AddEventInteractor {
    
    private(set) var eventModel: AddEventModel = AddEventModel(title: "", text: "")
    private var id: String?
    
    weak var presenter: AddEventPresentationManagement?
    private let fileManagerService: FileManagerProtocol
    private let localeStorage: LocaleStorageManagement
    
    init(fileManager: FileManagerProtocol = FileManagerService(),
         localeStorage: LocaleStorageManagement = LocaleStorageManager()) {
        self.fileManagerService = fileManager
        self.localeStorage = localeStorage
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
    
    func getCorvertEditModel(editModel: EventModel,
                             completion: (Result<AddEventModel, AddEventFailure>) -> Void) {
        
        let imageDatas = editModel.images.compactMap { [weak self] image in
            self?.getImageDataFromFile(editModel: editModel,
                                       urlString: image.urlString)
        }
        eventModel = AddEventModel(imageData: imageDatas[0],
                                   title: editModel.title,
                                   text: editModel.description,
                                   date: editModel.date)
        self.id = editModel.id
        completion(.success(eventModel))
    }
    
    func changeModel(with imageData: Data,
                     completion: @escaping (Result<AddEventModel, AddEventFailure>) -> Void) {
        
        eventModel.imageData = imageData
        completion(.success(eventModel))
    }
    
    func changeModel(with text: String, type: AddEventCellType) {
        switch type {
        case .titleCell:
            eventModel.title = text
        case .infoCell:
            eventModel.text = text
        default: break
        }
    }
    
    func saveEvent() {
        if id != nil {
            update(from: eventModel)
            print("Обновили")
        } else {
            saveNewEvent(from: eventModel)
            print("Сохранили")
        }
    }
    
    private func update(from model: AddEventModel) {
        guard let editModel = localeStorage
            .fetchObjects(EventModel.self)?
            .filter({ $0.id == id })
            .first else { return }
        
        localeStorage.updateObject(editModel) {
            editModel.title = model.title ?? ""
            editModel.specification = model.text
            editModel.date = model.date ?? Date()
            
            guard let data = model.imageData else { return }
            guard let newUrlString = FileManagerService.shared.write(
                data,
                to: "2022",
                and: model.title ?? "",
                file: "Test123"
            ) else { return }
            editModel.images.append(Image(urlString: newUrlString))
        }
    }
    
    private func saveNewEvent(from model: AddEventModel) {
        print(model)
        let event = EventModel()
        event.title = model.title ?? ""
        event.specification = model.text
        event.date = model.date ?? Date()
        event.id = "\(model.title ?? "")+12345"
        
        guard let data = model.imageData else { return }
        guard let newUrlString = FileManagerService.shared.write(
            data,
            to: "2022",
            and: model.title ?? "",
            file: "Test123"
        ) else {
            return
        }
        event.images.append(Image(urlString: newUrlString))
        
        localeStorage.saveObject(event)
        print(event)
    }
}
