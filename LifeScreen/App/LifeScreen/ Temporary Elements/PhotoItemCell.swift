//
//  PhotoItemCell.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.07.2022.
//

//
//  PhotoItemCell.swift
//  New Collection design
//
//  Created by Anas Almomany on 17/01/2022.
//

import UIKit

class PhotoItemCell: UICollectionViewCell {
    static let reuseIdentifer = "photo-item"
    let imageView = UIImageView()
    let contentContainer = UIView()

    var photoURL: String? {
        didSet {
            configure()
            test()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func test() {
        guard let url = photoURL else { return }
        NetworkManager.shared.fetchImage(with: url) { result in
            
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                        
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func configure() {
        contentContainer.layer.cornerRadius = 5
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentContainer)

        
        imageView.contentMode = .scaleAspectFill

        contentContainer.clipsToBounds = true
        contentContainer.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(imageView)

        NSLayoutConstraint.activate([
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            imageView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: contentContainer.topAnchor)
        ])
    }
}
