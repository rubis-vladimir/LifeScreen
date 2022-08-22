//
//  AddEventInfoCellBuilder.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//

import UIKit

final class AddEventInfoCellBuilder: TVCBuilderProtocol {
    
    private let height: CGFloat
    private let text: String
    
    // delegate
    
    init(height: CGFloat, text: String) {
        self.height = height
        self.text = text
    }
    
    func cellHeight() -> CGFloat { height }
    
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddEventInfoCell.reuseId, for: indexPath) as! AddEventInfoCell
        
        cell.setup()
        
        return cell
    }
}
