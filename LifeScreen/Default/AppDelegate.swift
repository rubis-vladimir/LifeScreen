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
        
        /// Создаем основной TabBarController
        let mainTabbarController = MainTabBarController()
        /// Создаем NavigationController для TabBarController
        let navigationVC = UINavigationController(rootViewController: mainTabbarController)
        /// Устанавливаем зависимости и настраиваем TabBarController
        MainTabBarAssembly(navigationController: navigationVC).assembly(viewController: mainTabbarController)
        
        /// Определяем rootVC и отображаем на экране
        window.rootViewController = navigationVC
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

