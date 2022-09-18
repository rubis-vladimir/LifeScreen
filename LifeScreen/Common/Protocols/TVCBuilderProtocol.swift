//
//  TVCBuilderProtocol.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 21.08.2022.
//

import UIKit

/// Протокол конструктора для создания и конфигурации ячейки
protocol TVCBuilderProtocol {
    
    /// Идентификатор ячейки
    var reuseId: String { get }
    /// Тип ячейки
    var cellType: AddEventCellType { get }
    /// Возвращает высоту ячейки
    func cellHeight() -> CGFloat
    /// Создает ячейку по indexPath
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
}
