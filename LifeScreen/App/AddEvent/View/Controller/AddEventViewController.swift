//
//  AddEventViewController.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 17.08.2022.
//

import UIKit

protocol AddEventViewable: AnyObject {
    
}

class AddEventViewController: UITableViewController {
    
    var presenter: AddEventPresentation?
    
    private(set) var factory: AddEventFactory?
    
    var sections: [TVSectionProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshList()
        
    }
    
    
    private func setupFactory() {
        
        factory = AddEventFactory(tableView: tableView)
        guard let sections = factory?.buildSections() else { return }
        self.sections = sections
    }
    
    private func setupTableView() {
        
        let margin: CGFloat = 30
        
//        tableView.layoutMargins = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: 30)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        
        tableView.register(AddEventPhotoCell.self, forCellReuseIdentifier: AddEventPhotoCell.reuseId)
        tableView.register(AddEventTitleCell.self, forCellReuseIdentifier: AddEventTitleCell.reuseId)
        tableView.register(AddEventInfoCell.self, forCellReuseIdentifier: AddEventInfoCell.reuseId)
    }
    
    private func refreshList() {
        setupFactory()
        setupTableView()
        
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(sections[section].numberOfRows())
        return sections[section].numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].cellHeightFor(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].cellAt(indexPath: indexPath, tableView: tableView)
    }
}


extension AddEventViewController: AddEventViewable {
    
}
