//
//  EventCollageViewCell.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.07.2022.
//

import UIKit

class EventCollageCell: UICollectionViewCell {
    
    static let reuseId = "EventCollageCell2"
    
    private var viewModel: EventCollageCellViewModelProtocol?
    private var imageDownloadManager: ImageDownloadManagement?
    private var fileManagerService: FileManagerProtocol?
    
    private let contentContainer = CollageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ viewModel: EventCollageCellViewModelProtocol,
                   imageDownloadManager: ImageDownloadManagement = ImageDownloadManager(),
                   fileManagerService: FileManagerProtocol = FileManagerService.shared) {
        self.viewModel = viewModel
        self.imageDownloadManager = imageDownloadManager
        self.fileManagerService = fileManagerService
        
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
        
        // Временно, так как при пролистывании изменяет уже загруженный Коллаж
        let variant = CollageLayout.allCases.randomElement() ?? .clOnePhoto
        
        contentContainer.configure(for: variant)
        
        if let url = viewModel.url {
            
            let lastPartUrl = ""
            
            let imagesData = FileManagerService.shared.getData(from: lastPartUrl, date: Date())
            
            if let imagesData = imagesData {
                guard let image = UIImage(data: imagesData) else { return }
                
                DispatchQueue.main.async {
                    self.contentContainer.photoImageViewOne.image = image
                    self.contentContainer.photoImageViewTwo.image = image
                    self.contentContainer.photoImageViewThree.image = image
                    self.contentContainer.photoImageViewFour.image = image
                
                    self.contentContainer.eventLabel.text = "Welcome, my Friend!"
                    print("Картинка загружена локально")
                }
            } else {
                imageDownloadManager.loadImage(from: url) { [weak self] result in
                    if let data = try? result.get() {
                        
                        if let image = UIImage(data: data) {
                            
                            DispatchQueue.main.async {
                                self?.contentContainer.photoImageViewOne.image = image
                                self?.contentContainer.photoImageViewTwo.image = image
                                self?.contentContainer.photoImageViewThree.image = image
                                self?.contentContainer.photoImageViewFour.image = image
                                
                                self?.contentContainer.eventLabel.text = "Welcome, my Friend!"
                                print("Картинка загружена из сети")
                            }
                            
                            if let data = image.pngData() {
//                                fileManagerService.write(data,
//                                                         date: Date(),
//                                                         file: "\(String(describing: lastPartUrl)).png")
                            }
                        }
                    }
                }
            }
        }
    }
}
