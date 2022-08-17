//
//  MainTabBarController.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 19.07.2022.
//

import UIKit


protocol MainTabBarViewable: AnyObject {
    
}

///
final class MainTabBarController: UITabBarController {
    
    var presenter: MainTabBarPresentation?
    
    private let middleButton = UIButton()
    
    private var plusImageView: UIImageView = {
        let imageView = UIImageView()
        let configuration = UIImage.SymbolConfiguration(pointSize: 19, weight: .thin)
        imageView.image = UIImage(systemName: "plus.circle", withConfiguration: configuration)
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        generateTabBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        redefineTabBarFrame()
        addMiddleButton()
    }
    
    private func redefineTabBarFrame() {
        let newTabBarHeight = tabBar.frame.size.height + 10
        
        var newFrame = tabBar.frame
        newFrame.size.height = newTabBarHeight
        newFrame.origin.y = view.frame.size.height - newTabBarHeight
        
        tabBar.frame = newFrame
    }
    
    func addMiddleButton() {
        
        // DISABLE TABBAR ITEM - behind the "+" custom button:
        DispatchQueue.main.async {
            if let items = self.tabBar.items {
                 items[1].isEnabled = false
            }
        }
        
        // shape, position and size
        let size = CGFloat(40)
        let constant = CGFloat(10)
        plusImageView.layer.cornerRadius = size / 2
        
        middleButton.addSubview(plusImageView)
        tabBar.addSubview(middleButton)
        
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        
        // set constraints
        let constraints = [
            middleButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            middleButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor),
            middleButton.heightAnchor.constraint(equalToConstant: tabBar.bounds.height),
            middleButton.widthAnchor.constraint(equalToConstant: tabBar.bounds.width / 3 - constant),
            
            plusImageView.centerXAnchor.constraint(equalTo: middleButton.centerXAnchor),
            plusImageView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: constant),
            plusImageView.widthAnchor.constraint(equalToConstant: size),
            plusImageView.heightAnchor.constraint(equalToConstant: size)
        ]
        
        for constraint in constraints {
            constraint.isActive = true
        }
        
        // action
        middleButton.addTarget(self,
                               action: #selector(routeToCreateEvent(sender:)),
                               for: .touchUpInside)
    }
    
    @objc func routeToCreateEvent(sender: UIButton) {
        presenter?.readyForRoute()
    }
}

// MARK: - MainTabBarViewable
extension MainTabBarController: MainTabBarViewable {
    
}
