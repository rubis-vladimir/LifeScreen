////
////  AddEventPhotoCell2.swift
////  LifeScreen
////
////  Created by Владимир Рубис on 23.08.2022.
////
//
//import UIKit
//import PhotosUI
//
//final class AddEventPhotoCell2: UITableViewCell, PHPickerViewControllerDelegate {
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//        dismiss(animated: true)
//        
//        let existingSelection = self.selection
//        var newSelection = [String: PHPickerResult]()
//        for result in results {
//            let identifier = result.assetIdentifier!
//            newSelection[identifier] = existingSelection[identifier] ?? result
//        }
//        
//        // Track the selection in case the user deselects it later.
//        selection = newSelection
//        
//        print(newSelection    )
//        selectedAssetIdentifiers = results.map(\.assetIdentifier!)
//        selectedAssetIdentifierIterator = selectedAssetIdentifiers.makeIterator()
//        
////        if selection.isEmpty {
////            displayEmptyImage()
////        } else {
////            displayNext()
////        }
//    }
//    
//
//    static let reuseId = "AddEventPhotoCell2"
//    
//    
//    var photoImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.backgroundColor = .systemGray5
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    var addPhotoButton: UIButton = {
//        let button = UIButton()
//        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
//        button.setImage(UIImage(systemName: "plus")?.withConfiguration(configuration), for: .normal)
//        button.backgroundColor = .systemGray2
//        button.imageView?.tintColor = .white
//        button.translatesAutoresizingMaskIntoConstraints = false
//        
//        return button
//    }()
//    
//    private var selection = [String: PHPickerResult]()
//    private var selectedAssetIdentifiers = [String]()
//    private var selectedAssetIdentifierIterator: IndexingIterator<[String]>?
//    private var currentAssetIdentifier: String?
//    
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        
//        setupConstraints()
//    }
//    
//    private func setupConstraints() {
//    
//        let size: CGFloat = 70
//        
//        addSubview(photoImageView)
//        addSubview(addPhotoButton)
//        
//        /// Настройка констрейнтов
//        let constraints = [
//            photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
//            photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//
//            addPhotoButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            addPhotoButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            addPhotoButton.widthAnchor.constraint(equalToConstant: size),
//            addPhotoButton.heightAnchor.constraint(equalToConstant: size)
//        ]
//        
//        for constraint in constraints {
//            constraint.isActive = true
//        }
//    }
//    
//    @objc func add(sender: UIButton) {
//        presentPicker(filter: PHPickerFilter.images)
//    }
//    
//    func setup() {
//        self.selectionStyle = .none
//        self.addPhotoButton.addTarget(self, action: #selector(add(sender:)), for: .touchUpInside)
//    }
//    
//    private func presentPicker(filter: PHPickerFilter?) {
//        var configuration = PHPickerConfiguration(photoLibrary: .shared())
//        
//        // Set the filter type according to the user’s selection.
//        configuration.filter = filter
//        // Set the mode to avoid transcoding, if possible, if your app supports arbitrary image/video encodings.
//        configuration.preferredAssetRepresentationMode = .current
//        // Set the selection behavior to respect the user’s selection order.
//        if #available(iOS 15, *) {
//            configuration.selection = .ordered
//        } else {
////            configuration.
//        }
//        // Set the selection limit to enable multiselection.
//        configuration.selectionLimit = 0
//        // Set the preselected asset identifiers with the identifiers that the app tracks.
//        if #available(iOS 15, *) {
//            configuration.preselectedAssetIdentifiers = selectedAssetIdentifiers
//        } else {
//            // Fallback on earlier versions
//        }
//        
//        let picker = PHPickerViewController(configuration: configuration)
//        picker.delegate = self
//        present(picker, animated: true)
//    }
//}
