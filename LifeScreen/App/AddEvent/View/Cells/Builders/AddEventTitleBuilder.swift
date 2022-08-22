//
//  AddEventTitleBuilder.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//

import UIKit

final class AddEventTitleBuilder: TVCBuilderProtocol {
    
    private let height: CGFloat
    private var title: String?
    
    init(height: CGFloat) {
        self.height = height
    }
    
    init(height: CGFloat, title: String) {
        self.height = height
        self.title = title
    }
    
    func cellHeight() -> CGFloat { height }
    
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddEventTitleCell", for: indexPath) as! AddEventTitleCell
        
        cell.setup()
        
        return cell
    }
}
