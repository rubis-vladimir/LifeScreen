//
//  AddEventPhotoCellBuilder.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//

import UIKit

final class AddEventPhotoCellBuilder: TVCBuilderProtocol {
    
    private let height: CGFloat
    private let color: UIColor
    
    var delegate: PresentPickerDelegate?
    
    init(height: CGFloat, color: UIColor, delegate: PresentPickerDelegate?) {
        self.height = height
        self.color = color
        self.delegate = delegate
    }
    
    func cellHeight() -> CGFloat { height }
    
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddEventPhotoCell.reuseId, for: indexPath) as! AddEventPhotoCell
        
        cell.setup()
        cell.delegate = delegate
        
        return cell
    }
}



