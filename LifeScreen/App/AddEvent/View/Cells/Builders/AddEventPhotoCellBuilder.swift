//
//  AddEventPhotoCellBuilder.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//

import UIKit

/// Конфигуратор ячейки AddEventPhotoCell
final class AddEventPhotoCellBuilder {
    /// Высота ячейки
    private let height = CGFloat(350)
    /// Подгружаемая фотография
    private let image: UIImage?
    /// Делегат для обработки нажатия на кнопку
    private weak var delegate: PresentPickerDelegate?
    
    init(image: UIImage?, delegate: PresentPickerDelegate?) {
        self.image = image
        self.delegate = delegate
    }
    
    /// Временно для отладки
    deinit {
        print("Билдер деинициализирован")
    }
}

// MARK: - TVCBuilderProtocol
extension AddEventPhotoCellBuilder: TVCBuilderProtocol {
    
    var reuseId: String { String(describing: AddEventPhotoCell.self) }
    
    var cellType: AddEventCellType { .photoCell }
    
    func cellHeight() -> CGFloat { height }
    
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddEventPhotoCell.reuseId, for: indexPath) as! AddEventPhotoCellProtocol
        
        cell.delegate = delegate
        cell.displayData(image)
       
        return cell
    }
}



