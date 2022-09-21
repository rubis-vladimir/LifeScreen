//
//  TVFactoryProtocol.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//
import UIKit

/// Фабричный протокол для конфигурации TableView
protocol TVFactoryProtocol {
    /// Строители ячеек
    var builders: [TVCBuilderProtocol] { get }
}

