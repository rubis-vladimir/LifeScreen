//
//  AddEventViewController.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 17.08.2022.
//

import UIKit

/// Протокол вызова Photo Picker
protocol PresentPickerProtocol: AnyObject {
    
    /// Передача запроса презентеру на вызов PhotoPicker
    func presentPicker()
    /// Передача текстовых данных в модель
    func didEnteredText(_ text: String, type: AddEventCellType)
}

/// Пока не используется
protocol AddEventPresenterDelegate: AnyObject {
    func updateUI(with model: AddEventModel)
    func showError(_ error: Error)
}

/// Контроллер добавления жизненных событий
class AddEventViewController: UITableViewController {
    
    /// Дефолтная модель данных
    private var defaultModel = AddEventModel(imageData: [], title: "", text: "")
    /// Презентер модуля AddEvent
    var presenter: AddEventPresentation?
    /// Массив конфигураторов ячеек
    private var builders: [TVCBuilderProtocol] = []
    /// Фабрика настройки табличного представления
    private var factory: TVFactoryProtocol?
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showEvent()
        setupNavigitionBarViews()
    }
    
    private func showEvent() {
        presenter?.setupEditEvent()
        refreshList()
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
        
        presenter?.saveCurrentEvent()
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
    private func refreshList() {
        guard let model = presenter?.eventModel else { return }
        
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


//MARK: - PresentPickerDelegate
extension AddEventViewController: PresentPickerProtocol {
    
    func presentPicker() {
        presenter?.route(to: .photoPicker)
    }
    
    func didEnteredText(_ text: String, type: AddEventCellType) {
        presenter?.updateModel(with: text, type: type)
    }
}


//MARK: - AddEventViewable
extension AddEventViewController: AddEventPresenterDelegate {
    func updateUI(with model: AddEventModel) {
        refreshList()
    }
    
    func showError(_ error: Error) {
        guard let error = error as? PhotoPickerError else { return }
        switch error {
        case .notImage:
            print("Not image")
        case .failedConvertToData:
            print("Failed convert Data")
        case .imageNotLoaded(let id):
            print("Image with id: \(id) not loaded.")
        }
    }
}
