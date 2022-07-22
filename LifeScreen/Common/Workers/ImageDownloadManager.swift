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
    
    /// Осуществить загрузку изображений (из сети)
    ///  - Parameters:
    ///     - url: URL-адрес изображения
    ///     - completion: closure по выполнению (флаг успешности / ошибка)
    func loadImage(from url: URL,
                   completion: @escaping (Result<Data, Error>) -> Void)
}

/// Сервис загрузки изображений
final class ImageDownloadManager {}

// MARK: - ImageDownloadManagement
extension ImageDownloadManager: ImageDownloadManagement {
    func loadImage(from url: URL,
                   completion: @escaping (Result<Data, Error>) -> Void) {
        print("Download Start")
        getData(from: url) { data, response, optionalError in
            guard let data = data else {
                guard let error = optionalError else {
                    completion(.failure(ImageLoadingErrors.failureWhenDownloading))
                    return
                }
                completion(.failure(error))
                return
            }
            
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            completion(.success(data))
        }
    }
    
    private func getData(from url: URL,
                         completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
