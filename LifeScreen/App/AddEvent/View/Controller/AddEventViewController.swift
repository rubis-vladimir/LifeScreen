//
//  AddEventViewController.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 17.08.2022.
//

import UIKit

/// Протокол обновления модели и установки фото
protocol DisplayPhotoProtocol: AnyObject {
    
    /// Добавляет в текущую модель фото и обновляет UI элементы
    ///  - Parameter image: загруженное изображения из галереи
    func setPhoto(_ image: UIImage)
}

/// Протокол вызова Photo Picker
protocol PresentPickerProtocol: AnyObject {
    
    /// Вызывает Photo Picker
    func presentPicker()
}

/// Пока не используется
protocol AddEventViewable: AnyObject {
    
}

/// Контроллер добавления жизненных событий
class AddEventViewController: UITableViewController {
    
    var presenter: AddEventPresentation?
    /// Менеджер загрузки Photo Picker
    var photoPickerManager: PhotoPickerConfiguratable?
    /// Массив конфигураторов ячеек
    private var builders: [TVCBuilderProtocol] = []
    /// Фабрика настройки табличного представления
    private var factory: TVFactoryProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshList()
    }
    
    private func refreshList(model: AddEventModel = AddEventModel(title: "", text: "")) {
        
        factory = AddEventFactory(tableView: tableView, model: model, delegate: self)
        guard let builders = factory?.builders else { return }
        self.builders = builders
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func eventSaveAndExit() {
        
    }
    
    // MARK: - UITableViewDataSource & Delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { builders.count }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { builders[indexPath.row].cellHeight() }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        builders[indexPath.row].cellAt(indexPath: indexPath, tableView: tableView)
    }
}

//MARK: - DisplayPhotoProtocol
extension AddEventViewController: DisplayPhotoProtocol {
    func setPhoto(_ image: UIImage) {
        /// Захватывает текущую модель, обновляет ее
        /// и перезагружает табличное представление
        factory?.catchModel { [weak self] model in
            guard let model = model as? AddEventModel else { return }
            let eventModel = AddEventModel(image: image,
                                           title: model.title,
                                           text: model.text)
            self?.refreshList(model: eventModel)
        }
    }
}

//MARK: - PresentPickerDelegate
extension AddEventViewController: PresentPickerProtocol {
    
    func presentPicker() {
        photoPickerManager?.createPhotoPicker(completion: { [weak self] picker in
            self?.present(picker, animated: true)
        })
    }
}


//MARK: - AddEventViewable
extension AddEventViewController: AddEventViewable {
    
}
