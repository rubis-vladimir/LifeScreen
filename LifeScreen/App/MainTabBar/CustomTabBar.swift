//
//  CustomTabBar.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 15.08.2022.
//

import UIKit

class CustomTabBar: UITabBar {
    
    public var didTapButton: (() -> Void)?
    
    public lazy var middleButton: UIButton! = {
        let button = UIButton()
        
        let size: CGFloat = 48
        button.frame.size = CGSize(width: size, height: size)
        
        let image = UIImage(systemName: "plus")!
        button.setImage(image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.662712386, blue: 0.6762944693, alpha: 1)
        button.tintColor = .white
        button.layer.cornerRadius = size / 2
        
        button.addTarget(self, action: #selector(self.middleButtonAction), for: .touchUpInside)
        
        self.addSubview(button)
        
        return button
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        middleButton.center = CGPoint(x: frame.width / 2, y: 25)
    }
    
    @objc func middleButtonAction(sende: UIButton) {
        didTapButton?()
        print("Тест")
    }
    
    
    
}

