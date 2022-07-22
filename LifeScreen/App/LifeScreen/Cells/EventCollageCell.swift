//
//  EventCollageViewCell.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.07.2022.
//

import UIKit

class EventCollageCell: UICollectionViewCell {
    
    static let reuseId = "EventCollageCell"
    
    private var viewModel: EventCollageCellViewModelProtocol?
    private var imageDownloadManager: ImageDownloadManagement?
    
    private let collageImageView = UIImageView()
    private let contentContainer = UIView()
    private let activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ viewModel: EventCollageCellViewModelProtocol,
                   imageDownloadManager: ImageDownloadManagement = ImageDownloadManager()) {
        self.viewModel = viewModel
        self.imageDownloadManager = imageDownloadManager
        
//        if let data = viewModel.imageData {
//            if let image = UIImage(data: data) {
//                DispatchQueue.main.async {
//                    self.collageImageView.image = image
//                    print("Картинка загружена")
//                }
//            }
//        }
        
                if let url = viewModel.url {
                    imageDownloadManager.loadImage(from: url) { [weak self] result in
                        if let data = try? result.get() {
                            if let image = UIImage(data: data) {
        
                                DispatchQueue.main.async {
                                    self?.collageImageView.image = image
                                    print("Картинка загружена")
                                }
                            }
                        }
                    }
                }
        contentContainer.layer.cornerRadius = 5
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentContainer)
        
        collageImageView.contentMode = .scaleAspectFill
        
        contentContainer.clipsToBounds = true
        contentContainer.layer.masksToBounds = true
        collageImageView.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(collageImageView)
        
        NSLayoutConstraint.activate([
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            collageImageView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            collageImageView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            collageImageView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor),
            collageImageView.topAnchor.constraint(equalTo: contentContainer.topAnchor)
        ])
    }
}
