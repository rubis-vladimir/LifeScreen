//
//  EventModel.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 29.07.2022.
//

import Foundation
import RealmSwift

/// Модель События для сохранения в Realm
final class EventModel: Object {
    /// Название
    @Persisted var title: String = ""
    /// Описание
    @Persisted var specification: String?
    /// Дата
    @Persisted var date: Date = Date()
    /// Картинки/фотографии
    @Persisted var images = List<Image>()
    
    convenience init(title: String,
                     specification: String? = nil,
                     date: Date) {
        self.init()
        self.title = title
        self.specification = specification
        self.date = date
    }
}

/// Модель Image
final class Image: Object {
    /// Путь к картинке
    @Persisted var urlString: String = ""
    /// Является ли картинка избранной
    @Persisted var isFavorite: Bool = false
    
    convenience init(urlString: String) {
        self.init()
        self.urlString = urlString
    }
}

