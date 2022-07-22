//
//  LifeScreenAPI.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 21.07.2022.
//

import Foundation



final class LifeScreenPresentetionLanWorker {
    
    func getDataModels(completion: @escaping (Result<[Event], Error>) -> Void) {
        var events: [Event] = []
        
        events = (1...20).map({ _ in Event.generateDumyImage() })
        
        completion(.success(events))
    }
}
