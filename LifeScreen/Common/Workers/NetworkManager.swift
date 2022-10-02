//
//  NetworkManager.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.07.2022.
//

import Foundation

enum NetworkError: Error {
    case badUrL
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(with urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badUrL))
            return
        }
        
        let queue = DispatchQueue(label: "newQueue", qos: .userInteractive, attributes: [.concurrent])
        
        let workItem = DispatchWorkItem {
            
            if let data = try? Data(contentsOf: url) {
                completion(.success(data))
            }
        }
        
        queue.asyncAfter(deadline: .now() + .seconds(2), execute: workItem)
    }
}
