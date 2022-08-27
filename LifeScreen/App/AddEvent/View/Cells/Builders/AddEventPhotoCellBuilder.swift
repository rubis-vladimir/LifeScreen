//
//  AddEventPhotoCellBuilder.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//

import UIKit

/// Строитель ячейки AddEventPhotoCell
final class AddEventPhotoCellBuilder {
    /// Высота ячейки
    private let height = CGFloat(350)
    /// Подгружаемая фотография
    private let image: UIImage?
    /// Делегат для обработки нажатия на кнопку
    weak var delegate: AddEventFactoryProtocol?
    
    init(image: UIImage?) {
        self.image = image
    }
}

// MARK: - TVCBuilderProtocol
extension AddEventPhotoCellBuilder: TVCBuilderProtocol {
    
    var reuseId: String { String(describing: AddEventPhotoCell.self) }
    
    var cellType: AddEventCellType { .photoCell }
    
    func cellHeight() -> CGFloat { height }
    
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddEventPhotoCell.reuseId, for: indexPath) as! AddEventPhotoCell
        cell.displayData(image)
        cell.delegate = delegate
        return cell
    }
}



