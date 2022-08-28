//
//  AddEventPhotoCell.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//

import UIKit

/// Ячейка для загрузки фотографий из галереи
final class AddEventPhotoCell: UITableViewCell {
    /// Идентификатор ячейки
    static let reuseId = "AddEventPhotoCell"
    /// Делегат для обработки взаимодействия
    weak var delegate: AddEventFactoryProtocol?
    
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var addPhotoButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(
            pointSize: 30,
            weight: .light
        )
        button.setImage(
            UIImage(systemName: "plus")?.withConfiguration(configuration),
            for: .normal
        )
        button.backgroundColor = .systemGray2
        button.imageView?.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupElements()
        setupConstraints()
    }
    
    /// Настраивает ячейку и элементы
    private func setupElements() {
        selectionStyle = .none
        addPhotoButton.addTarget(
            self, action: #selector(addPhoto),
            for: .touchUpInside
        )
    }
    
    /// Настраивает констрейнты
    private func setupConstraints() {
        let size: CGFloat = 70
        
        addSubview(photoImageView)
        addSubview(addPhotoButton)
        
        /// Настройка констрейнтов
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            addPhotoButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addPhotoButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            addPhotoButton.widthAnchor.constraint(equalToConstant: size),
            addPhotoButton.heightAnchor.constraint(equalToConstant: size)
        ])
    }
    
    /// Вызов PhotoPicker через делегата
    @objc func addPhoto() {
        delegate?.didPhotoButtonTapped()
    }
    
    /// Отображает передаваемые данные
    ///  - Parameter image: фотография
    func displayData(_ image: UIImage?) {
        if let image = image {
            self.addPhotoButton.isHidden = true
            self.photoImageView.image = image
        } else {
            self.addPhotoButton.isHidden = false
        }
    }
}
