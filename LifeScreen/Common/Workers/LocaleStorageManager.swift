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
    
    /// Получаем объект из локального хранилища
    /// - Parameter object: сохраняемый объект (экземпляр модели)
    func saveObject<T:Object>(_ object: T)
    
    /// Получаем объект из локального хранилища
    /// - Parameters:
    ///  - type: тип объекта (модели)
    ///  - key: первичный ключ (primaryKey)
    func fetchObject<T: Object>(_ type: T.Type, key: Any) -> T?
    
    /// Получаем объект из локального хранилища
    /// - Parameters:
    ///  - object: сохраненный объект (экземпляр модели)
    ///  - completion: захват для обновления объекта в блоке `.write {}`
    func updateObject<T: Object>(_ object: T, completion: @escaping () -> Void)
    
    /// Удаление объекта из локального хранилища
    /// - Parameter object: сохраненный объект (экземпляр модели)
    func deleteObject<T: Object>(_ object: T)
}

/// Сервис работы с локальным хранилищем
final class LocaleStorageManager {
    
    /// Экземпляр Realm
    fileprivate var realm: Realm? {
        do {
            return try Realm()
        } catch let error {
            print("Default realm init failed: ", error)
        }
        return nil
    }
    
    /// Экземпляр FileManager
    let manager = FileManager.default
        
}

// MARK: - LocaleStorageManagement
extension LocaleStorageManager: LocaleStorageManagement {
    
    func saveObject<T: Object>(_ object: T) {
        guard let realm: Realm = self.realm else { return }
        
        do {
            try realm.write{
                realm.add(object)
            }
        } catch let error {
            print("Failed to save", error)
        }
    }
    
    func fetchObject<T: Object>(_ type: T.Type, key: Any) -> T?  {
            guard let realm: Realm = self.realm else { return nil }
            return realm.object(ofType: type, forPrimaryKey: key)
    }
    
    func updateObject<T: Object>(_ object: T, completion: @escaping () -> Void)  {
        guard let realm: Realm = self.realm else { return }
        
        do {
            try realm.write{
                completion()
                realm.add(object, update: .modified)
            }
        } catch let error {
            print("Failed to update", error)
        }
    }
    
    func deleteObject<T: Object>(_ object: T) {
        guard let realm: Realm = self.realm else { return }
        
        do {
            try realm.write{
                realm.delete(object)
            }
        } catch let error {
            print("Failed to delete", error)
        }
    }
}
