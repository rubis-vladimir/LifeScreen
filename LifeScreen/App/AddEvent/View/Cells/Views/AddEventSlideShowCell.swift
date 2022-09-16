//
//  AddEventSlideShowCell.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 12.09.2022.
//

import UIKit

/// Ячейка в формате Слайд-шоу изображений
final class AddEventSlideShowCell: UITableViewCell {
    /// Идентификатор ячейки
    static let reuseId = "AddEventSlideShowCell"
    /// Делегат для обработки взаимодействия
    weak var delegate: AddEventFactoryProtocol?
    /// Массив выбранных изображений
    private var images: [UIImage] = [] {
        didSet {
            refreshSlideShow()
        }
    }
    private var container = UIStackView()
    private var slideShowScrollView = UIScrollView()
    private lazy var pageControl = UIPageControl()
    
    func configure(with images: [UIImage]) {
        setupElements()
        setupConstraints()
        self.images = images
    }
    
    /// Обновляет SlideShow
    private func refreshSlideShow() {
        guard !images.isEmpty else { return }
        /// Удаляем все сабвью в scrollView
        slideShowScrollView.subviews.forEach { $0.removeFromSuperview() }
        
        /// Настраиваем и устанавливаем новые ImageView
        for i in 0..<images.count {
            /// горизонтальный сдвиг
            let offset = i == 0 ? 0 : (CGFloat(i) * container.bounds.width)
            print("ImageView")
            let imageView = UIImageView(frame: CGRect(x: offset,
                                                      y: 0,
                                                      width: self.bounds.width,
                                                      height: self.bounds.height))
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.image = images[i]
            
            slideShowScrollView.addSubview(imageView)
        }
        /// Обновляем contentSize
        slideShowScrollView.contentSize = CGSize(width: CGFloat(images.count) * container.bounds.width,
                                                 height: container.bounds.height)
        
        pageControl.frame = CGRect(x: container.bounds.width / 2 - 60,
                                   y: container.bounds.height * 0.85,
                                   width: 120,
                                   height: 20)
        pageControl.numberOfPages = images.count
        container.addSubview(pageControl)
    }
    
    /// Настраивает UI-элементы
    private func setupElements() {
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .brown
        
        slideShowScrollView.showsHorizontalScrollIndicator = false
        slideShowScrollView.isPagingEnabled = true
        slideShowScrollView.translatesAutoresizingMaskIntoConstraints = false
        slideShowScrollView.delegate = self
    }
    
    /// Настраивает констрейнты
    private func setupConstraints() {
        addSubview(container)
        container.addSubview(slideShowScrollView)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            slideShowScrollView.topAnchor.constraint(equalTo: container.topAnchor),
            slideShowScrollView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            slideShowScrollView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            slideShowScrollView.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
        /// Переопределение размера и положения подпредставлений
        self.layoutSubviews()
    }
}

//MARK: - UIScrollViewDelegate
extension AddEventSlideShowCell: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        /// При прокрутке scrollView обновляем текущую страницу в pageControl
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        pageControl.currentPage = Int(ceil(x/w))
    }
}
