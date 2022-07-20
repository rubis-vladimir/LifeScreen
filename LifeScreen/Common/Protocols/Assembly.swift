//
//  Assembly.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 19.07.2022.
//

import Foundation
import UIKit

/// Протокол компоновки VIPER-модулей на базе UIViewController
protocol Assemblying {
    
    /// Собрать VIPER-модуль
    ///  - Parameter viewController: UIViewController компонующего модуля
    func assembly(viewController: UIViewController)
}
