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
    
    /// Передача запроса презентеру на вызов PhotoPicker
    func presentPicker()
}

/// Пока не используется
protocol AddEventViewable: AnyObject {
    
}

/// Контроллер добавления жизненных событий
class AddEventViewController: UITableViewController {
    
    /// Дефолтная модель данных
    private var defaultModel = AddEventModel(title: "", text: "")
    /// Презентер модуля AddEvent
    var presenter: AddEventPresentation?
    /// Массив конфигураторов ячеек
    private var builders: [TVCBuilderProtocol] = []
    /// Фабрика настройки табличного представления
    private var factory: TVFactoryProtocol?
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshList(model: defaultModel)
        setupNavigitionBarViews()
    }
    
    /// Настраивает кастомный NavigitionBar
    private func setupNavigitionBarViews() {
        
        let saveRightButton = createCustomBarButton(
            imageName: "checkmark",
            selector: #selector(saveAndExitRightButtonTapped)
        )
        let cancelLeftButton = createCustomBarButton(
            imageName: "xmark",
            selector: #selector(cancelLeftButtonTapped)
        )
        let customTitleView = createTitleButton(
            title: "29 августа 2022",
            selector: #selector(routeToDataPickerVC)
        )
        
        navigationItem.rightBarButtonItems = [saveRightButton]
        navigationItem.leftBarButtonItems = [cancelLeftButton]
        navigationItem.titleView = customTitleView
    }
    
    /// Сохраняет событие и скрывает экран
    @objc private func saveAndExitRightButtonTapped() {
        print("saveAndExitRightButtonTapped")
        
        factory?.catchModel(completion: { [weak self] model in
            guard let model = model as? AddEventModel else { return }
            self?.presenter?.save(event: model)
        })
        dismissVC()
    }
    
    deinit {
        print("VC deinit")
    }
    
    /// Скрывает экран
    @objc private func cancelLeftButtonTapped() {
        dismissVC()
    }
    
    /// Переход к экрану с обновлением даты
    @objc private func routeToDataPickerVC() {
        presenter?.route(to: .dataPicker)
    }
    
    /// Скрывает экран
    private func dismissVC() {
        guard let nc = navigationController else { return }
        nc.createCustomTransition(with: .fade)
        nc.popViewController(animated: false)
    }
    
    /// Обновление данных и UI
    ///   - Parameter model: модель сохраняемого события (по умолчанию пустая)
    private func refreshList(model: AddEventModel) {
        
        factory = AddEventFactory(tableView: tableView,
                                  model: model,
                                  delegate: self)
        guard let builders = factory?.builders else { return }
        self.builders = builders
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
        
        var eventModel: AddEventModel?
        factory?.catchModel { [weak self] model in
            guard let model = model as? AddEventModel else { return }
            eventModel = AddEventModel(image: image,
                                           title: model.title,
                                           text: model.text)
        }
        refreshList(model: eventModel ?? defaultModel)
    }
}

//MARK: - PresentPickerDelegate
extension AddEventViewController: PresentPickerProtocol {
    
    func presentPicker() {
        presenter?.route(to: .photoPiker)
    }
}


//MARK: - AddEventViewable
extension AddEventViewController: AddEventViewable {
    
}
