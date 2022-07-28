//
//  EventCollageViewCell.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.07.2022.
//

import UIKit

class EventCollageCell2: UICollectionViewCell {
    
    static let reuseId = "EventCollageCell2"
    
    private var viewModel: EventCollageCellViewModelProtocol?
    private var imageDownloadManager: ImageDownloadManagement?
    
    private let contentContainer = CollageView()
    
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
        
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentContainer)
        
        contentContainer.clipsToBounds = true
        contentContainer.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        //        if let data = viewModel.imageData {
        //            if let image = UIImage(data: data) {
        //                DispatchQueue.main.async {
        //                    self.collageImageView.image = image
        //                    print("Картинка загружена")
        //                }
        //            }
        //        }
        
        // Временно, так как при пролистывании изменяет уже загруженный Коллаж
        let variant = CollageLayout.allCases.randomElement() ?? .clOnePhoto
        
        contentContainer.configure(for: variant)
        
        if let url = viewModel.url {
            imageDownloadManager.loadImage(from: url) { [weak self] result in
                if let data = try? result.get() {
                    
                    if let image = UIImage(data: data) {
                        
                        DispatchQueue.main.async {
                            self?.contentContainer.photoImageViewOne.image = image
                            self?.contentContainer.photoImageViewTwo.image = image
                            self?.contentContainer.photoImageViewThree.image = image
                            self?.contentContainer.photoImageViewFour.image = image
                            
                            self?.contentContainer.eventLabel.text = "Welcome, my Friend!"
                        }
                    }
                }
            }
        }
        
//        contentContainer.imageView1.contentMode = .scaleAspectFill
//        contentContainer.imageView2.contentMode = .scaleAspectFill
//        contentContainer.imageView3.contentMode = .scaleAspectFill
        
        
//        contentContainer.layer.cornerRadius = 5

        
        
    }
}
