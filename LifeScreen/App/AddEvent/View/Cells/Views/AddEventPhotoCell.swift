//
//  AddEventPhotoCell.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//

import PhotosUI

/// Протокол загрузки данных AddEventPhotoCell
protocol AddEventPhotoCellProtocol {
    func displayData(_ image: UIImage?)
}

final class AddEventPhotoCell: UITableViewCell {
    
    static let reuseId = "AddEventPhotoCell"
    
    weak var delegate: PresentPickerDelegate?
    
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
    
    
    deinit {
        print("PhotoCell деинициализирована")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupElements()
        setupConstraints()
    }
    
    private func setupElements() {
        selectionStyle = .none
        addPhotoButton.addTarget(self, action: #selector(add(sender:)), for: .touchUpInside)
        
        
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
        delegate?.presentPicker()
    }
}

//MARK: - AddEventPhotoCellProtocol
extension AddEventPhotoCell: AddEventPhotoCellProtocol {
    func displayData(_ image: UIImage?) {
        if let image = image {
            self.addPhotoButton.isHidden = true
            self.photoImageView.image = image
        } else {
            self.addPhotoButton.isHidden = false
        }
    }
}
