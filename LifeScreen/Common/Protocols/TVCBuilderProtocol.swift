//
//  TVCBuilderProtocol.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 21.08.2022.
//

import UIKit

/// Протокол создания и конфигурации ячейки
protocol TVCBuilderProtocol {
    /// Возвращает высоту ячейки
    func cellHeight() -> CGFloat
    
    /// Создает ячейку по indexPath
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
}
