//
//  TVFactoryProtocol.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//
import UIKit

/// Фабричный протокол для конфигурации TableView
protocol TVFactoryProtocol {
    associatedtype Model
    associatedtype Builder
    
    func setBuilders(with model: Model) -> [Builder]
}

