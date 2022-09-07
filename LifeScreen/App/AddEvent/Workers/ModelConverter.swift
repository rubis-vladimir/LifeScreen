//
//  ModelConverter.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 01.09.2022.
//

import Foundation

final class ModelConverter {
    
    static var shared = ModelConverter()
    
    private init() {}
    
    func convert<T>(model: T) -> EventModel? {
        
        guard let oldModel = model as? AddEventModel else { return nil }
        
        let newModel = EventModel()
        newModel.title = oldModel.title ?? ""
        newModel.specification = oldModel.text
        newModel.date = oldModel.date ?? Date()
        
        if let data = oldModel.imageData {
            if let newUrlString = FileManagerService.shared.write(
                data,
                to: "2022",
                and: oldModel.title ?? "",
                file: "Test123"
            ) {
                newModel.images.append(Image(urlString: newUrlString))
            }
        }
        
        return EventModel()
        
    }
    
    func convert(from: AddEventModel, to: EventModel) {
        
        
    }
}

//let user = UserModel(name: "Петр")
//user.email = "petyaTop@mail.ru"
//user._id = ObjectId("507f191e810c19729de860ea")
//
//zip(eventsData, dates).forEach { event, date in
//
//    let event = EventModel(title: event.key, specification: event.value)
//    event.date = DateConvertService.convertStrToDate(date) ?? Date()
//
//    urls.forEach {
//        let image = Image(urlString: $0)
//        event.images.append(image)
//    }
//    user.events.append(event)
//}
