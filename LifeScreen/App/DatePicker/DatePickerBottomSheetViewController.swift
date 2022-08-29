//
//  DatePickerBottomSheetViewController.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 29.08.2022.
//

import UIKit

final class DatePickerBottomSheetViewController: UIPresentationController {
    
    
    
    
    override var frameOfPresentedViewInContainerView: CGRect {
            let bounds = containerView!.bounds
            let halfHeight = bounds.height / 2
            return CGRect(x: 0,
                                 y: halfHeight,
                                 width: bounds.width,
                                 height: halfHeight)
        }
    
    
}
