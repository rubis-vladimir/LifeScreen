//
//  PhotoPickerResponce.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 16.09.2022.
//

import Foundation

/// Модель ответа PhotoPicker
struct PhotoPickerResponse {
    var imagesData: [Data] = []
    var error: PhotoPickerError?
}
