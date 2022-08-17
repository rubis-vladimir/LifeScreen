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
        let mainTabbarController = MainTabBarController()
        
        /// Создаем вкладки (экраны) ТабБара и конфигурируем их
//        let lifeEventListViewController = LifeEventListViewController()
//        let lifeScreenViewController = LifeScreenViewController()
//
//        let navigationVC1 = UINavigationController(rootViewController: lifeEventListViewController)
//        let navigationVC2 = UINavigationController(rootViewController: lifeScreenViewController)
//
//        LifeEventListAssembly(navigationController: navigationVC1).assembly(viewController: lifeEventListViewController)
//        LifeScreenAssembly(navigationController: navigationVC2).assembly(viewController: lifeScreenViewController)
//
//        mainTabbarController.addChild(navigationVC1)
//        mainTabbarController.addChild(navigationVC2)
        
        /// Создаем вкладки (экраны) ТабБара и конфигурируем их
//        let lifeEventListViewController = LifeEventListViewController()
//        let lifeScreenViewController = LifeScreenViewController()
//        let addEvent = UIViewController()
//    
//        let navigationVC1 = UINavigationController(rootViewController: lifeEventListViewController)
//        let navVC = UINavigationController(rootViewController: addEvent)
//        let navigationVC2 = UINavigationController(rootViewController: lifeScreenViewController)
//        
//        LifeEventListAssembly(navigationController: navigationVC1).assembly(viewController: lifeEventListViewController)
//        LifeScreenAssembly(navigationController: navigationVC2).assembly(viewController: lifeScreenViewController)
//    
//        mainTabbarController.addChild(navigationVC1)
//        mainTabbarController.addChild(navVC)
//        mainTabbarController.addChild(navigationVC2)
        MainTabBarAssembly(navigationController: UINavigationController()).assembly(viewController: mainTabbarController)
        window.rootViewController = mainTabbarController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

