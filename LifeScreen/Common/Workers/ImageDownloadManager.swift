//
//  ImageDownloadManager.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.07.2022.
//

import Foundation

enum ImageLoadingErrors: String, Error {
    case failureWhenDownloading
}

/// Протокол загрузки изображений
protocol ImageDownloadManagement {
    
    /// Осуществить загрузку изображений (из сети / локально)
    ///  - Parameters:
    ///     - url: URL-адрес изображения
    ///     - completion: closure по выполнению (флаг успешности / ошибка)
    func loadImage(from url: URL,
                   completion: @escaping (Result<Data, Error>) -> Void)
}

/// Сервис загрузки изображений
final class ImageDownloadManager {
    
    var imageCache = NSCache<NSString, NSData>()
}

// MARK: - ImageDownloadManagement
extension ImageDownloadManager: ImageDownloadManagement {
    func loadImage(from url: URL,
                   completion: @escaping (Result<Data, Error>) -> Void) {
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            print("Loading from cache")
            completion(.success(cachedImage as Data))
        } else {
            
            getData(from: url) { data, response, optionalError in
                guard let data = data else {
                    guard let error = optionalError else {
                        completion(.failure(ImageLoadingErrors.failureWhenDownloading))
                        return
                    }
                    completion(.failure(error))
                    return
                }
                
                self.imageCache.setObject(data as NSData, forKey: url.absoluteString as NSString)
                completion(.success(data))
            }
        }
    }
    
    private func getData(from url: URL,
                         completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
