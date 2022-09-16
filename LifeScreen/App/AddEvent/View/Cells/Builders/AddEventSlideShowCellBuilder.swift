//
//  AddEventSlideShowCellBuilder.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 08.09.2022.
//

import UIKit

/// Строитель ячейки AddEventSlideShowCell
final class AddEventSlideShowCellBuilder {
    /// Высота ячейки
    private let height = CGFloat(350)
    /// Массив выбранных пользователем изображений
    private var images: [UIImage] = []
    /// Делегат для обработки UI-эвентов
    weak var delegate: AddEventFactoryProtocol?
    
    init(imageData: [Data?]) {
        self.images = convert(data: imageData)
    }
}

// MARK: - TVCBuilderProtocol
extension AddEventSlideShowCellBuilder: TVCBuilderProtocol {
    
    var reuseId: String { String(describing: AddEventSlideShowCell.self) }
    
    var cellType: AddEventCellType { .photoCell }
    
    func cellHeight() -> CGFloat { height }
    
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddEventSlideShowCell.reuseId, for: indexPath) as! AddEventSlideShowCell
        cell.configure(with: images)
        cell.delegate = delegate
        return cell
    }
    
    private func convert(data: [Data?]) -> [UIImage] {
        let images = data.compactMap{$0}.map{ UIImage(data: $0) }
        return images.compactMap{$0}
    }
}
