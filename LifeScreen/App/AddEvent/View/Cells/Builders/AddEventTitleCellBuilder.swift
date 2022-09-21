//
//  AddEventTitleCellBuilder.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//

import UIKit

/// Строитель ячейки AddEventTitleCell
final class AddEventTitleCellBuilder {
    
    /// Высота ячейки
    private let height = CGFloat(70)
    /// Название заголовка события
    private let title: String?
    /// Делегат для передачи введенного текста
    weak var delegate: AddEventPresentation?
    
    init(title: String?) {
        self.title = title
    }
}

// MARK: - TVCBuilderProtocol
extension AddEventTitleCellBuilder: TVCBuilderProtocol {
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
