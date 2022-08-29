//
//  UIViewController + CustomNB.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 27.08.2022.
//

import UIKit

extension UIViewController {
    
    func createCustomNavigationBar() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }
    
    func createTitleButton(title: String, selector: Selector) -> UIButton {
        let button = UIButton()
        
        button.frame = CGRect(x: 0, y: 0, width: 180, height: 25)
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.systemGray4.cgColor
        
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black.withAlphaComponent(0.7), for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        
//        let dataPicker = UIDatePicker()
//        dataPicker.frame = CGRect(x: 20, y: 0, width: view.frame.width - 20, height: view.frame.height)
//        dataPicker.datePickerMode = .date
//        dataPicker.preferredDatePickerStyle = .wheels
//        view.addSubview(dataPicker)
//
        
        return button
    }
    
    func createCustomBarButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate),
            for: .normal
        )
        button.tintColor = .black.withAlphaComponent(0.7)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
}
