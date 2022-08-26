//
//  AddEventTitleBuilder.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//

import UIKit

final class AddEventTitleBuilder {
    
    /// Высота ячейки
    private let height = CGFloat(50)
    /// Название заголовка события
    private let title: String
    ///
    private weak var delegate: AddEventTFProtocol?
    
    init(title: String = "", delegate: AddEventTFProtocol?) {
        self.title = title
        self.delegate = delegate
    }
}

// MARK: - TVCBuilderProtocol
extension AddEventTitleBuilder: TVCBuilderProtocol {
    var reuseId: String { String(describing: AddEventTitleCell.self) }
    
    var cellType: AddEventCellType { .titleCell }
    
    func cellHeight() -> CGFloat { height }
    
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddEventTitleCell", for: indexPath) as! AddEventTitleCell
        
        cell.delegate = delegate
        cell.displayData(title)
        
        return cell
    }
}
