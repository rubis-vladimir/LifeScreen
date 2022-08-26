//
//  LocalImageDownloadManager.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 23.08.2022.
//

import PhotosUI

protocol LocallyLoadedFromDevice {
    func presentPicker(completion: @escaping (PHPickerViewController) -> Void)
}

final class LocalImageDownloadManager {
    
}

extension LocalImageDownloadManager: LocallyLoadedFromDevice {
//    func presentPicker(completion: @escaping (UIAlertController) -> Void) {
//        let alert = UIAlertController(title: "Привет", message: "Тест", preferredStyle: .alert)
//
//        let action = UIAlertAction(title: "OK", style: .default) {_ in
//            print("All OK!")
//        }
//        let cancel = UIAlertAction(title: "ОТМЕНА", style: .cancel)
//
//        alert.addAction(action)
//        alert.addAction(cancel)
//
//        completion(alert)
//    }
    
    func presentPicker(completion: @escaping (PHPickerViewController) -> Void) {
        
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        
        // Set the filter type according to the user’s selection.
        configuration.filter = PHPickerFilter.images
        // Set the mode to avoid transcoding, if possible, if your app supports arbitrary image/video encodings.
        configuration.preferredAssetRepresentationMode = .current
        // Set the selection behavior to respect the user’s selection order.
        configuration.selection = .ordered
        // Set the selection limit to enable multiselection.
        configuration.selectionLimit = 0
        // Set the preselected asset identifiers with the identifiers that the app tracks.
//        configuration.preselectedAssetIdentifiers = selectedAssetIdentifiers
        
        let picker = PHPickerViewController(configuration: configuration)
        completion(picker)
        
    }
    
}
