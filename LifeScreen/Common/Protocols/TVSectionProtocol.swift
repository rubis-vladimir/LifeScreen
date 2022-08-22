//
//  TVSectionProtocol.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//

import UIKit

protocol TVSectionProtocol {
    
    /// Строители ячеек
    var builders: [TVCBuilderProtocol] { get set }
    
    /// Определяет количество ячеек
    func numberOfRows() -> Int
    
    /// Устанавливает высоту ячейки по indexPath
    func cellHeightFor(indexPath: IndexPath) -> CGFloat
    
    /// Возвращает ячейку и настраивает ее
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
}

