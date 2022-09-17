//
//  PhotoPickerManager.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 23.08.2022.
//

import PhotosUI

/// Ошибки в слое PhotoPicker
enum PhotoPickerError: Error {
    case notImage
    case failedConvertToData
    case imageNotLoaded(String)
}

/// Протокол создания PhotoPicker
protocol PhotoPickerConfiguratable {
    /// Создает и настраивает PhotoPicker
    ///  - Parameter completion: clouser, захватывающий picker для презентации
    func createPhotoPicker(completion: @escaping (PHPickerViewController) -> Void)
}

/// Сервис загрузки объектов из библиотеки фотографий пользователя
final class PhotoPickerManager {
    
    private weak var delegate: DisplayPhotoDelegate?
    
    /// Словарь (идентификатор объекта - результат загрузки)
    private var selection = [String: PHPickerResult]()
    /// Массив идентификаторов выбранных объектов
    private var selectedAssetIdentifiers = [String]()
    /// Модель передачи данных/ошибки
    private var photoPickerResponce = PhotoPickerResponse()
    
    init(delegate: DisplayPhotoDelegate) {
        self.delegate = delegate
    }
    
    /// Загружает выбранные объекты
    private func loadObject() {
        /// Группа для обработки задач, как единое целое
        let dispatchGroup = DispatchGroup()
        
        for id in self.selectedAssetIdentifiers {
            guard let result = selection[id] else { return }
            let itemProvider = result.itemProvider
            
            dispatchGroup.enter() /// войти в группу
            
            /// Пробуем загрузить объект как изображение
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    
                    self?.process(object: image,
                                  assetIdentifier: id,
                                  error: error,
                                  completion: { [weak self] result in
                        switch result {
                        case .success(let data):
                            self?.photoPickerResponce.imagesData.append(data)
                        case .failure(let error):
                            self?.photoPickerResponce.error = error
                        }
                    })
                    
                    dispatchGroup.leave() /// покинуть группу
                }
            }
        }
        
        /// Отправка уведомления после завершения всех задач в группе
        dispatchGroup.notify(queue: .main) {
            self.delegate?.send(response: self.photoPickerResponce)
        }
    }
    
    /// Обрабатывает получаемый объект или получает ошибку
    ///  - Parameters:
    ///   - object: объект
    ///   - assetIdentifier: идентификатор объекта
    ///   - error: ошибка при загрузке
    ///   - completion: closure по выполнению (флаг успешности / ошибка)
    private func process(object: Any?,
                         assetIdentifier: String,
                         error: Error?,
                         completion: @escaping (Result<Data, PhotoPickerError>) -> Void) {
        if let image = object as? UIImage {
            if let imageData = image.pngData() {
                completion(.success(imageData))
            } else {
                completion(.failure(.failedConvertToData))
            }
        } else if error != nil {
            completion(.failure(.imageNotLoaded(assetIdentifier)))
        } else {
            completion(.failure(.notImage))
        }
    }
}

// MARK: - PhotoPickerConfiguratable
extension PhotoPickerManager: PhotoPickerConfiguratable {
    
    func createPhotoPicker(completion: @escaping (PHPickerViewController) -> Void) {
        
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        /// Устанавливаем тип фильтра на фото
        configuration.filter = PHPickerFilter.images
        /// Для множественного выбора
        configuration.selectionLimit = 0
        /// Для установки уже выбранных объектов
        configuration.preselectedAssetIdentifiers = selectedAssetIdentifiers
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        completion(picker)
    }
}

// MARK: - PHPickerViewControllerDelegate
extension PhotoPickerManager: PHPickerViewControllerDelegate {
    
    /// Уведомляет делегата о том, что пользователь завершил выбор или отменил его
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        selection = getNewSelection(with: results)
        selectedAssetIdentifiers = results.map(\.assetIdentifier!)
        
        if !selection.isEmpty {
            loadObject()
        }
    }
    
    /// Получает словарь из текущего выбора пользователя
    ///  - Parameter results: результаты загрузки
    ///  - Returns: текущий словарь (идентификатор объекта - результат загрузки)
    private func getNewSelection(with results: [PHPickerResult]) -> [String: PHPickerResult] {
        let existingSelection = self.selection
        var newSelection = [String: PHPickerResult]()
        
        for result in results {
            guard let identifier = result.assetIdentifier else { continue }
            newSelection[identifier] = existingSelection[identifier] ?? result
        }
        return newSelection
    }
}
