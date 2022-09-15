//
//  LocalImageDownloadManager.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 23.08.2022.
//

import PhotosUI

/// Пока не доработан. Подгружает изображения
protocol PhotoPickerConfiguratable {
    func createPhotoPicker(completion: @escaping (PHPickerViewController) -> Void)
}

final class PhotoPickerManager {
    
    private weak var delegate: DisplayPhotoDelegate?
    
    private var selection = [String: PHPickerResult]()
    private var selectedAssetIdentifiers = [String]()
    private var selectedAssetIdentifierIterator: IndexingIterator<[String]>?
    private var currentAssetIdentifier: String?
    private var imagesData: [Data] = [] {
        didSet {
            if imagesData.count == selection.count {
                delegate?.setPhoto(imagesData)
            }
        }
    }
    
    init(delegate: DisplayPhotoDelegate) {
        self.delegate = delegate
    }
    
    private func displayNext() {
        let array = selection.map { $0.key }
        print("ARRAY + \(array) + ARRAY")
        
        //        let dispatchGroup = DispatchGroup()
        //        let dispatchWorkItem = DispatchWorkItem {
        for i in array {
            //            dispatchGroup.enter()
            let itemProvider = self.selection[i]!.itemProvider
            
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    DispatchQueue.main.async {
                        self?.handleCompletion(assetIdentifier: i, object: image, error: error)
                    }
                }
            }
            //            dispatchGroup.leave()
        }
        
        
        
    }
    
    private func handleCompletion(assetIdentifier: String, object: Any?, error: Error? = nil) {
        //        guard currentAssetIdentifier == assetIdentifier else { return }
        
        if let image = object as? UIImage {
            
            if let imageData = image.pngData() {
                
                imagesData.append(imageData)
                print("DATA + \(imageData)")
            } else {
                return
                
            }
            
        } else if let error = error {
            print("Couldn't display \(assetIdentifier) with error: \(error)")
            //            displayErrorImage()
        }
    }
}

extension PhotoPickerManager: PhotoPickerConfiguratable {
    
    func createPhotoPicker(completion: @escaping (PHPickerViewController) -> Void) {
        
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
        
        picker.delegate = self
        completion(picker)
    }
}


extension PhotoPickerManager: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let existingSelection = self.selection
        var newSelection = [String: PHPickerResult]()
        for result in results {
            let identifier = String(result.assetIdentifier!)
            newSelection[identifier] = existingSelection[identifier] ?? result
        }
        
        // Track the selection in case the user deselects it later.
        selection = newSelection
        print("SELECTION + \(selection) + SELECTION")
        
        
        selectedAssetIdentifiers = results.map(\.assetIdentifier!)
        selectedAssetIdentifierIterator = selectedAssetIdentifiers.makeIterator()
        //
        if selection.isEmpty {
            //            displayEmptyImage()
            print("Пусто")
        } else {
            displayNext()
            print("Загрузить фото")
        }
    }
    
    
}
