//
//  LocaleStorageManager.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 10.08.2022.
//

import Foundation
import RealmSwift

/// Протокол управления локальным хранилищем
protocol LocaleStorageManagement {
    
    ///
    func saveObject<T:Object>(_ object: T)
    ///
    func fetchUser(_ key: Any) -> UserModel?
    
}

/// Сервис работы с локальным хранилищем
final class LocaleStorageManager {
    fileprivate var realm: Realm? {
        do {
            return try Realm()
        } catch let error {
            print("Default realm init failed: ", error)
        }
        return nil
    }
}

// MARK: - LocaleStorageManagement
extension LocaleStorageManager: LocaleStorageManagement {
    
    
    func saveObject<T: Object>(_ object: T) {
        do {
            try realm?.write{
                realm?.add(object)
            }
        } catch let error {
            print("Failed to save", error)
        }
    }
    
//    func fetchObject<T>(_ key: String) -> T? where T: Object  {
//        guard let realm: Realm = self.realm else { return nil }
//        guard let object: T = realm.object(ofType: T.self, forPrimaryKey: key) else { return nil }
//        return !object.isInvalidated ? object : nil
//    }
    
    func fetchUser(_ key: Any) -> UserModel? {
        
        guard let model = realm?.object(ofType: UserModel.self, forPrimaryKey: key) else {
            print("Юзер не найден")
            return nil }
        return !model.isInvalidated ? model : nil
    }
    
}
