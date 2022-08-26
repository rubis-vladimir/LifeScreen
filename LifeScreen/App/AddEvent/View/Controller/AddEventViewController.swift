//
//  AddEventViewController.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 17.08.2022.
//

import UIKit
import PhotosUI

protocol AddEventViewable: AnyObject {
    
}

protocol PresentPickerDelegate: AnyObject {
    func presentPicker()
}

protocol AddEventTFProtocol: AnyObject {
    
}

class AddEventViewController: UITableViewController {
    
    var presenter: AddEventPresentation?
    
    private(set) var factory: AddEventFactory?
    private var localImageDownloadManager: LocallyLoadedFromDevice? = LocalImageDownloadManager()
    
//    private var event:
    var image: UIImage?
    
    private var selection = [String: PHPickerResult]()
    private var selectedAssetIdentifiers = [String]()
    private var selectedAssetIdentifierIterator: IndexingIterator<[String]>?
    private var currentAssetIdentifier: String?
    
    
    var sections: [TVSectionProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        refreshList()
        
    }
    
    deinit {
        print("VC деинициализирован")
    }
    
    
    
    private func setupTableView() {
        
        let margin: CGFloat = 30
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        
        tableView.register(AddEventPhotoCell.self, forCellReuseIdentifier: AddEventPhotoCell.reuseId)
        tableView.register(AddEventTitleCell.self, forCellReuseIdentifier: AddEventTitleCell.reuseId)
        tableView.register(AddEventInfoCell.self, forCellReuseIdentifier: AddEventInfoCell.reuseId)
    }
    
    private func refreshList() {
        setupFactory()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    func eventSaveAndExit() {
        
        
        let event = EventModel(title: <#T##String#>, specification: <#T##String?#>)
        
    }
    
    private func displayNext() {
        guard let assetIdentifier = selectedAssetIdentifierIterator?.next() else { return }
        currentAssetIdentifier = assetIdentifier
        
        let itemProvider = selection[assetIdentifier]!.itemProvider
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    self?.handleCompletion(assetIdentifier: assetIdentifier, object: image, error: error)
                }
            }
        }
    }
    
    
    func handleCompletion(assetIdentifier: String, object: Any?, error: Error? = nil) {
        guard currentAssetIdentifier == assetIdentifier else { return }
        
        if let image = object as? UIImage {
            self.image = image
            refreshList()
        } else if let error = error {
            print("Couldn't display \(assetIdentifier) with error: \(error)")
//            displayErrorImage()
        }
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].cellHeightFor(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].cellAt(indexPath: indexPath, tableView: tableView)
    }
}


extension AddEventViewController: AddEventViewable {
    
}

extension AddEventViewController: PresentPickerDelegate {
    
//    func displayImage() {
//
//        completion(self.image)
//
//        refreshList()
//    }
    
    func setupFactory() {
        
        factory = AddEventFactory(tableView: tableView, image: self.image, self)
        guard let sections = factory?.buildSections() else { return }
        self.sections = sections
    }
    
    func presentPicker() {
        
        localImageDownloadManager?.presentPicker(completion: { [weak self] picker in
            picker.delegate = self
            self?.present(picker, animated: true)
        })
    }
}

extension AddEventViewController: PHPickerViewControllerDelegate {
    /// - Tag: ParsePickerResults
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        let existingSelection = self.selection
        var newSelection = [String: PHPickerResult]()
        for result in results {
            let identifier = result.assetIdentifier!
            newSelection[identifier] = existingSelection[identifier] ?? result
        }

        // Track the selection in case the user deselects it later.
        selection = newSelection

        print(newSelection)
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


extension AddEventViewController: AddEventTFProtocol {
    
}
