//
//  AppDelegate.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 19.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /// Настраиваем UIWindow
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        /// Создаем основной ТабБар
        let mainTabbarController = UITabBarController()
        
        /// Помещаем в ТабБар 2 VC обернутых в NavigationVC
        let navigationVC1 = UINavigationController(rootViewController: LifeEventListViewController())
        let navigationVC2 = UINavigationController(rootViewController: LifeScreenViewController())
    
        mainTabbarController.addChild(navigationVC1)
        mainTabbarController.addChild(navigationVC2)
        
        window.rootViewController = mainTabbarController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

