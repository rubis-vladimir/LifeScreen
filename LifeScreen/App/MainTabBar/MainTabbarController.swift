//
//  MainTabBarController.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 19.07.2022.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    var layerHeight = CGFloat()
    
    var buttonTapped = false
    var middleButton: UIButton = {
        let b = UIButton()
        let c = UIImage.SymbolConfiguration(pointSize: 15, weight: .heavy, scale: .large)
        b.setImage(UIImage(systemName: "plus", withConfiguration: c), for: .normal)
        b.imageView?.tintColor = .orange
        b.backgroundColor = .blue
        return b
    }()
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        
//        let tabBar = CustomTabBar()
//        
//        self.tabBar = tabBar
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateTabBar()
        
        let bar = CustomTabBar(frame: self.tabBar.bounds)
        self.setValue(bar, forKey: "tabBar")
        
        tabBar.isTranslucent = false
        tabBar.tintColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        
        
        
        
        guard let tabBar = self.tabBar as? CustomTabBar else {
            return
            
        }
        
        tabBar.didTapButton = { [unowned self] in
            self.routeToCreateEvent()
        }
        
        
        print("asd")
    }
    
    private func generateTabBar() {
//        let lifeEventListViewController = LifeEventListViewController()
//        let lifeScreenViewController = LifeScreenViewController()
//        let addEvent = UIViewController()
//
//        lifeEventListViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
//
//        lifeScreenViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
//
//        addEvent.tabBarItem = UITabBarItem(title: nil, image: nil, selectedImage: nil)
//
//        let navigationVC1 = UINavigationController(rootViewController: lifeEventListViewController)
//        let navVC = UINavigationController(rootViewController: addEvent)
//        let navigationVC2 = UINavigationController(rootViewController: lifeScreenViewController)
//
//        LifeEventListAssembly(navigationController: navigationVC1).assembly(viewController: lifeEventListViewController)
//        LifeScreenAssembly(navigationController: navigationVC2).assembly(viewController: lifeScreenViewController)
//
//        let viewControllers = [navigationVC1, navVC, navigationVC2]
        
        viewControllers = [
            setupVC(LifeEventListViewController(),
                    image: UIImage(systemName: "house"),
                    selectedImage: UIImage(systemName: "house.fill")),
            
            setupVC(UIViewController()),
            
            setupVC(LifeScreenViewController(),
                    image: UIImage(systemName: "gearshape"),
                    selectedImage: UIImage(systemName: "gearshape.fill"))
        ]
        
        self.setViewControllers(viewControllers, animated: false)
        
        addMiddleButton()
    }
    
    private func setupVC(_ viewController: UIViewController,
                         image: UIImage? = nil,
                         selectedImage: UIImage? = nil) -> UIViewController {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.selectedImage = selectedImage
//        viewController.tabBarItem.titlePositionAdjustment.horizontal = 
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        switch viewController {
        case viewController as? LifeScreenViewController:
            LifeScreenAssembly(navigationController: navigationController).assembly(viewController: viewController)
        case viewController as? LifeEventListViewController:
            LifeEventListAssembly(navigationController: navigationController).assembly(viewController: viewController)
        default: break
        }
        return viewController
    }
    
    func addMiddleButton() {
        
        // DISABLE TABBAR ITEM - behind the "+" custom button:
        DispatchQueue.main.async {
            if let items = self.tabBar.items {
                 items[1].isEnabled = false
            }
        }
        
        // shape, position and size
        tabBar.addSubview(middleButton)
        let size = CGFloat(40)
        let constant: CGFloat = 20  + 5
        middleButton.layer.cornerRadius = size / 2
        
        
        
        // set constraints
        let constraints = [
            middleButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            middleButton.centerYAnchor.constraint(equalTo: tabBar.topAnchor, constant: constant),
            middleButton.heightAnchor.constraint(equalToConstant: size),
            middleButton.widthAnchor.constraint(equalToConstant: size)
        ]
        
        for constraint in constraints {
            constraint.isActive = true
        }
        
        // shadow
        middleButton.layer.shadowColor = UIColor.systemGray.cgColor
        middleButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        middleButton.layer.shadowOpacity = 0.75
        middleButton.layer.shadowRadius = 13
        
        // other
        middleButton.layer.masksToBounds = false
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        
        // action
        middleButton.addTarget(self, action: #selector(buttonHandler(sender:)), for: .touchUpInside)
        
    }
    
    
    
    @objc func buttonHandler(sender: UIButton) {
        
        print("asdasa")
//        // define background color
//        let buttonBGColor = UIColor(named: "iDoxViewColor")
//
//        // if button needs to open
//        if buttonTapped == false {
//
//            UIView.animate(withDuration: 0.3, animations: ({
//
//                // rotate the button
//                self.middleButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4 )
//
//                // change appearance
//                self.middleButton.backgroundColor = .white
//                self.middleButton.imageView?.tintColor = buttonBGColor
//
//                self.middleButton.layer.borderWidth = 5
//                self.middleButton.layer.borderColor = buttonBGColor?.cgColor
//
//                // button is on selected mode
//                self.buttonTapped = true
//
//                // perform an action
//                self.setUpButtons(count: self.options.count, center: self.middleButton, radius: 80)
//
//            }))
//
//        // if button needs to close
//        } else {
//
//            UIView.animate(withDuration: 0.15, animations: ({
//
//                // rotate the button back
//                self.middleButton.transform = CGAffineTransform(rotationAngle: 0)
//
//                // change appearance
//                self.middleButton.backgroundColor = buttonBGColor
//                self.middleButton.layer.borderWidth = 0
//                self.middleButton.imageView?.tintColor = .white
//
//                // button is no longer on selected mode
//                self.buttonTapped = false
//
//                // perform an action
//                self.removeButtons()
//
//            }))
//        }
    }
    
    func routeToCreateEvent() {
        print("Переход на экран добавления События")
    }
}

//extension MainTabbarController: UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        guard let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else {
//            return true
//        }
//
//        // Your middle tab bar item index.
//        // In my case it's 1.
//        if selectedIndex == 1 {
//            return false
//        }
//
//        return true
//    }
//}
