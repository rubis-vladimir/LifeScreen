//
//  AddEventInfoCellBuilder.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//

import UIKit

/// Строитель ячейки AddEventInfoCell
final class AddEventInfoCellBuilder {
    
    /// Высота ячейки
    private let height = CGFloat(350)
    /// Текст описания события
    private let text: String?
    /// Делегат для передачи введенного текста
    weak var delegate: AddEventFactoryProtocol?
    
    init(text: String?) {
        self.text = text
    }
}

//MARK: - TVCBuilderProtocol
extension AddEventInfoCellBuilder: TVCBuilderProtocol {
    var reuseId: String { String(describing: AddEventInfoCell.self) }
    
    var cellType: AddEventCellType { .infoCell }
    
    func cellHeight() -> CGFloat { height }
    
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddEventInfoCell.reuseId, for: indexPath) as! AddEventInfoCell
        cell.displayData(text)
        cell.delegate = delegate
        return cell
    }
}
