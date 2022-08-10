//
//  UserModel.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 10.08.2022.
//

import Foundation
import RealmSwift

/// Модель пользователя для сохранения в Realm
final class UserModel: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    /// Имя
    @Persisted var name: String = ""
    /// Почта
    @Persisted var email: String?
    /// Телефон
    @Persisted var phone: String?
    /// События
    @Persisted var events = List<EventModel>()
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    override static func primaryKey() -> String? {
      return "_id"
    }
}
