//
//  EventSaveManager.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 30.09.2022.
//

import Foundation

/// Протокол сохранения события в БД
protocol EventSaveProtocol {
    func convertAndSave(from eventModel: AddEventModel,
                        id: String?,
                        completion: @escaping (AddEventFailure?) -> Void)
}

/// Сервис сохранения событий
final class EventSaveManager {
    
    private let localeStorage: LocaleStorageManagement
    
    init(localeStorage: LocaleStorageManagement = LocaleStorageManager()){
        self.localeStorage = localeStorage
    }
    
    private func convertEvent(from model: AddEventModel,
                              completion: @escaping (Result<EventModel, AddEventFailure>) -> Void) {
        let event = EventModel()
        event.title = model.title
        event.specification = model.text
        event.date = model.date
        event.id = IdСonfigurator.shared.getId(title: event.title,
                                               date: event.date)
        let data = model.imageData.compactMap{$0}
        let urlsString = FileManagerService.shared.write(
            data,
            date: event.date,
            file: event.title
        )
        
        guard !urlsString.isEmpty else {
            completion(.failure(.eventNotExist))
            return }
        urlsString.forEach {
            event.images.append(Image(urlString: $0))
        }
        completion(.success(event))
    }
}

//MARK: - EventSaveProtocol
extension EventSaveManager: EventSaveProtocol {
    
    func convertAndSave(from eventModel: AddEventModel,
                        id: String?,
                        completion: @escaping (AddEventFailure?) -> Void) {
        switch id {
        case .none:
            convertEvent(from: eventModel) { [weak self] result in
                switch result {
                case .success(let event):
                    self?.localeStorage.saveObject(event)
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
            
            
        case .some:
            let model = eventModel
            guard let event = localeStorage
                .fetchObjects(EventModel.self)?
                .filter({ $0.id == id })
                .first else {
                completion(.eventNotExist)
                return
            }
            
            localeStorage.updateObject(event) { [weak self] in
                self?.convertEvent(from: eventModel, completion: { result in
                    switch result {
                    case .success(let newEvent): break
//                        event = newEvent
                    case .failure(let error):
                        completion(error)
                    }
                })
            }
        }
    }
}
