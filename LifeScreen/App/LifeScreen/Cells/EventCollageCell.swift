//
//  EventCollageViewCell.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.07.2022.
//

import UIKit

class EventCollageCell: UICollectionViewCell {
    
    static let reuseId = "EventCollageCell"
    let imageView = UIImageView()
    let contentConteiner = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentConteiner.layer.cornerRadius = 5
        contentConteiner.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentConteiner)
        
        
    }
}
