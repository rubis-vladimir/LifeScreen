//
//  UINavigationController + Transition.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 29.08.2022.
//

import UIKit

extension UINavigationController {
    
    /// Анимирование переходов
    func createCustomTransition(with transitionType: CATransitionType) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = transitionType
        transition.subtype = CATransitionSubtype.fromTop
        
        self.view.layer.add(transition, forKey: nil)
    }
}

extension UIViewController {
    func createCustom(with transitionType: CATransitionType) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = transitionType
        transition.subtype = CATransitionSubtype.fromTop
        
        self.view.layer.add(transition, forKey: nil)
    }
}
