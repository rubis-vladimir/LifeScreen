//
//  TVFactoryProtocol.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 28.09.2022.
//

import Foundation

/// Протокол фабрики для TableView
protocol TVFactoryProtocol {
    /// Строители ячеек
    var builders: [TVCBuilderProtocol] { get }
}
