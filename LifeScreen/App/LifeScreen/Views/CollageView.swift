//
//  CollageView.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 27.07.2022.
//

import UIKit

/// Типы макетов коллажа
enum CollageLayout:  CaseIterable {
    case clOnePhoto, clTwoPhoto, clThreePhoto, clFourPhoto
}

/// Кастомная вью для отрисовки Событий в формате Коллажа
final class CollageView: UIView {
    
    let photoImageViewOne = UIImageView()
    let photoImageViewTwo = UIImageView()
    let photoImageViewThree = UIImageView()
    let photoImageViewFour = UIImageView()
    
    let eventLabel = UILabel()
    
    private let stackViewOne = UIStackView()
    private let stackViewTwo = UIStackView()
    private let stackViewThree = UIStackView()
    
    /// Случайный вариант коллажа
    private let randomVariant = [0, 1, 2].randomElement()
    
    /// Настраивает Layout для CollageView
    ///  - Parameter collageLayout: тип layout в зависимости
    ///  от количества загруженных фотографий
    func configure(for collageLayout: CollageLayout) {
        
        [photoImageViewOne, photoImageViewTwo, photoImageViewThree, photoImageViewFour].forEach {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
        eventLabel.font = UIFont(name: "HelveticaNeue", size: 17)
        
        switch collageLayout {
            /// Коллаж с одним фото
        case .clOnePhoto:
            setupLayout(for: collageLayout,
                        with: photoImageViewOne,
                        variant: randomVariant ?? 0)
            
            /// Коллаж с двумя фото
        case .clTwoPhoto:
            stackViewOne.spacing = 5
            stackViewOne.distribution = .fillProportionally
            
            if randomVariant == 0 { stackViewOne.axis = .vertical }
            
            stackViewOne.addArrangedSubview(photoImageViewOne)
            stackViewOne.addArrangedSubview(photoImageViewTwo)
            
            setupLayout(for: collageLayout,
                        with: stackViewOne,
                        variant: randomVariant ?? 0)
            
            /// Коллаж с тремя фото
        case .clThreePhoto:
            [stackViewOne, stackViewTwo].forEach {
                $0.spacing = 5
                $0.distribution = .fillProportionally
            }
            
            stackViewOne.addArrangedSubview(photoImageViewTwo)
            stackViewOne.addArrangedSubview(photoImageViewThree)
            
            switch randomVariant {
            case 0:
                stackViewTwo.axis = .vertical
                stackViewTwo.addArrangedSubview(photoImageViewOne)
                stackViewTwo.addArrangedSubview(stackViewOne)
                
            case 1:
                stackViewTwo.axis = .vertical
                stackViewTwo.addArrangedSubview(stackViewOne)
                stackViewTwo.addArrangedSubview(photoImageViewOne)
                
            default:
                stackViewOne.axis = .vertical
                stackViewTwo.addArrangedSubview(photoImageViewOne)
                stackViewTwo.addArrangedSubview(stackViewOne)
            }
            
            setupLayout(for: collageLayout,
                        with: stackViewTwo,
                        variant: randomVariant ?? 0)
            
            /// Коллаж с четырьмя фото
        case .clFourPhoto:
            [stackViewOne, stackViewTwo, stackViewThree].forEach {
                $0.spacing = 5
                $0.distribution = .fillProportionally
            }
            
            switch randomVariant {
            case 2:
                stackViewThree.axis = .vertical
                stackViewOne.addArrangedSubview(photoImageViewOne)
                
                stackViewTwo.addArrangedSubview(photoImageViewTwo)
                stackViewTwo.addArrangedSubview(photoImageViewThree)
                stackViewTwo.addArrangedSubview(photoImageViewFour)
                
            default:
                stackViewThree.axis = .vertical
                stackViewOne.addArrangedSubview(photoImageViewOne)
                stackViewOne.addArrangedSubview(photoImageViewTwo)
                
                stackViewTwo.addArrangedSubview(photoImageViewThree)
                stackViewTwo.addArrangedSubview(photoImageViewFour)
            }
            
            stackViewThree.addArrangedSubview(stackViewOne)
            stackViewThree.addArrangedSubview(stackViewTwo)
            
            setupLayout(for: collageLayout,
                        with: stackViewThree,
                        variant: randomVariant ?? 0)
        }
    }
    
    /// Донастраивает свойства параметров CollageView и устанавливает констрейнты
    private func setupLayout(for collageLayout: CollageLayout,
                             with view: UIView,
                             variant: Int) {
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        
        /// Основной стэк - Коллаж фото + Название события
        let mainStackView = UIStackView()
        
        mainStackView.axis = .vertical
        mainStackView.spacing = 5
        mainStackView.distribution = .fillProportionally
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.addArrangedSubview(view)
        mainStackView.addArrangedSubview(eventLabel)
        
        addSubview(mainStackView)
        
        mainStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        eventLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        /// Устанавливает дополнительные ограничения для каждого варианта коллажа
        switch collageLayout {
        case .clTwoPhoto:
            photoImageViewTwo.heightAnchor.constraint(equalTo: stackViewOne.heightAnchor, multiplier: 0.7).isActive = true
            
        case .clThreePhoto:
            switch variant {
            case 0:
                photoImageViewOne.heightAnchor.constraint(equalTo: stackViewTwo.heightAnchor,
                                                          multiplier: 0.35).isActive = true
            case 1:
                photoImageViewTwo.widthAnchor.constraint(equalTo: stackViewOne.widthAnchor,
                                                         multiplier: 0.25).isActive = true
                photoImageViewOne.heightAnchor.constraint(equalTo: stackViewTwo.heightAnchor,
                                                          multiplier: 0.25).isActive = true
            default:
                photoImageViewThree.heightAnchor.constraint(equalTo: stackViewOne.heightAnchor,
                                                            multiplier: 0.6).isActive = true
                stackViewOne.widthAnchor.constraint(equalTo: stackViewTwo.widthAnchor,
                                                    multiplier: 0.4).isActive = true
            }
            
        case .clFourPhoto:
            switch variant {
            case 1:
                photoImageViewOne.widthAnchor.constraint(equalTo: stackViewOne.widthAnchor,
                                                         multiplier: 0.3).isActive = true
                photoImageViewFour.widthAnchor.constraint(equalTo: stackViewTwo.widthAnchor,
                                                          multiplier: 0.3).isActive = true
            case 2:
                photoImageViewOne.heightAnchor.constraint(equalTo: stackViewThree.heightAnchor,
                                                          multiplier: 0.75).isActive = true
            default: break
            }
            
        default: break
        }
    }
}

