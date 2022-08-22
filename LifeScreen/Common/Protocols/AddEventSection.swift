//
//  AddEventSection.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//

import UIKit

final class AddEventSection {
    
    var builders: [TVCBuilderProtocol]
    
    init(builders: [TVCBuilderProtocol]) {
        self.builders = builders
    }
}

extension AddEventSection: TVSectionProtocol {
    
    func numberOfRows() -> Int {
        return builders.count
    }
    
    func cellHeightFor(indexPath: IndexPath) -> CGFloat {
        return builders[indexPath.row].cellHeight()
    }
    
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        return builders[indexPath.row].cellAt(indexPath: indexPath, tableView: tableView)
    }
}

