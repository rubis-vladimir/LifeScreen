//
//  AddEventPhotoCell.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//

import UIKit
import PhotosUI

final class AddEventPhotoCell: UITableViewCell {

    static let reuseId = "AddEventPhotoCell"
    
    var delegate: PresentPickerDelegate?
    
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var addPhotoButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        button.setImage(UIImage(systemName: "plus")?.withConfiguration(configuration), for: .normal)
        button.backgroundColor = .systemGray2
        button.imageView?.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
    
        let size: CGFloat = 70
        
        addSubview(photoImageView)
        addSubview(addPhotoButton)
        
        /// Настройка констрейнтов
        let constraints = [
            photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            addPhotoButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addPhotoButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            addPhotoButton.widthAnchor.constraint(equalToConstant: size),
            addPhotoButton.heightAnchor.constraint(equalToConstant: size)
        ]
        
        for constraint in constraints {
            constraint.isActive = true
        }
    }
    
    @objc func add(sender: UIButton) {
        print("121123")
        delegate?.presentPicker()
    }
    
    func setup() {
        self.selectionStyle = .none
        self.addPhotoButton.addTarget(self, action: #selector(add(sender:)), for: .touchUpInside)
    }
}
