//
//  EventCollageCellViewModel.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.07.2022.
//

import Foundation

protocol EventCollageCellViewModelProtocol {
    var url: URL? { get }
    var width: Double { get }
    var height: Double { get }
    
    init(url: URL,
         width: Double,
         height: Double)
}

struct EventCollageCellViewModel: EventCollageCellViewModelProtocol {
    
    var url: URL?
    var width: Double
    var height: Double
    
    
    init(url: URL,
         width: Double,
         height: Double) {
        self.url = url
        self.width = width
        self.height = height
    } 
}

