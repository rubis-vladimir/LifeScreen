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
    
    // delegate
    
    init(height: CGFloat, color: UIColor) {
        self.height = height
        self.color = color
    }
    
    func cellHeight() -> CGFloat { height }
    
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddEventPhotoCell.reuseId, for: indexPath) as! AddEventPhotoCell
        
        cell.setup()
        
        return cell
    }
}



