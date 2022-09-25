//
//  AddEventViewController.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 17.08.2022.
//

import UIKit

/// Протокол работы с Вью слоем модуля AddEvent
protocol AddEventPresenterDelegate: AnyObject {
    /// Флаг сохранения событие
    var isSave: Bool { get set }
    /// Обновляет UI
    func updateUI()
    /// Показывает ошибку
    ///  - Parameter error: ошибка
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
    
    private var customTitleView: UIButton?
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        factory = AddEventFactory(tableView: tableView,
                                  delegate: presenter)
        setupNavigitionBarViews()
        updateUI()
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
        customTitleView = createTitleButton(
            title: "29 августа 2022",
            selector: #selector(routeToDataPickerVC)
        )
        navigationItem.rightBarButtonItems = [saveRightButton]
        navigationItem.leftBarButtonItems = [cancelLeftButton]
        navigationItem.titleView = customTitleView
    }
    
    /// Сохраняет событие и скрывает экран
    @objc private func saveAndExitRightButtonTapped() {
        presenter?.handleAction(.saveEvent)
    }
    
    /// Скрывает экран
    @objc private func cancelLeftButtonTapped() {
        dismissVC()
    }
    
    /// Переход к экрану настройки даты события
    @objc private func routeToDataPickerVC() {
        guard let date = presenter?.eventModel.date else { return }
        
        presenter?.handleAction(
            .route(.dataPicker(date: date))
        )
    }
    
    /// Настраивает скрытие экрана
    private func dismissVC() {
        guard let nc = navigationController else { return }
        nc.createCustomTransition(with: .fade)
        nc.popViewController(animated: false)
    }
    
    // MARK: - UITableViewDataSource & Delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        builders.count }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { builders[indexPath.row].cellHeight() }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        builders[indexPath.row].cellAt(indexPath: indexPath, tableView: tableView)
    }
}

//MARK: - AddEventViewable
extension AddEventViewController: AddEventPresenterDelegate {
    var isSave: Bool {
        get { false }
        set {
            if newValue == true {
                dismissVC()
            }
        }
    }
    
    func updateUI() {
        guard let model = presenter?.eventModel else { return }
        
        customTitleView?.setTitle(model.date?.description, for: .normal)
        
        
        guard let builders = factory?.getBuilders(with: ) else { return }
        self.builders = builders
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        if let error = error as? PhotoPickerError {
            switch error {
            case .notImage:
                print("Not image")
            case .failedConvertToData:
                print("Failed convert Data")
            case .imageNotLoaded(let id):
                print("Image with id: \(id) not loaded.")
            }
        } else if let error = error as? AddEventFailure {
            switch error {
            case .noValidate:
                print("Должна быть фотография и заголовок")
            default: break
            }
        }
    }
}
