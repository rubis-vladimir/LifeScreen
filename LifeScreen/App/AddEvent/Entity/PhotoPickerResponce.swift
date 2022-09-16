//
//  PhotoPickerResponce.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 16.09.2022.
//

import Foundation

struct PhotoPickerResponse {
    var imagesData: [Data] = []
    var error: PhotoPickerError?
}
