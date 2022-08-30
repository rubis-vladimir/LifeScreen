//
//  AddEventFactory.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//

import UIKit

/// Протокол обработки событий при взаимодействии пользователя с ячейками таблицы
protocol AddEventFactoryProtocol: AnyObject {
    
    /// Нажата кнопка вызова галереи фото
    func didPhotoButtonTapped()
    
    /// Был изменен текст. Обновляет модель данных
    ///  - Parameters:
    ///   - type: тип ячейки
    ///   - text: введенный текст
    func didChangedText(with type: AddEventCellType, text: String)
}

/// Фабрика настройки табличного представления модуля AddEvent
final class AddEventFactory {
    
    var model: AddEventModel
    private let tableView: UITableView
    private weak var delegate: PresentPickerProtocol?
    
    /// Инициализатор
    ///  - Parameters:
    ///    - tableView: настраиваемая таблица
    ///    - model: модель данных
    ///    - delegate: делегат для передачи UIEvent (VC)
    init(tableView: UITableView,
         model: AddEventModel,
         delegate: PresentPickerProtocol?) {
        self.tableView = tableView
        self.model = model
        self.delegate = delegate
        
        setupTableView()
    }
    
    /// Настраивает табличное представление
    private func setupTableView() {
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
    
    /// Создает строителя ячеек
    ///  - Parameters:
    ///     - model: модель данных
    ///     - type: тип ячейки
    ///   - Return: объект протокола строителя
    private func createBuilder(with model: AddEventModel, type: AddEventCellType) -> TVCBuilderProtocol {
        
        switch type {
        case .photoCell: /// Для ячейки подгрузки фото
            let builder = AddEventPhotoCellBuilder(image: model.image)
            builder.delegate = self
            tableView.register(AddEventPhotoCell.self, forCellReuseIdentifier: builder.reuseId)
            return builder
            
        case .titleCell: /// Для ячейки заголовка события
            let builder = AddEventTitleCellBuilder(title: model.title)
            builder.delegate = self
            tableView.register(AddEventTitleCell.self, forCellReuseIdentifier: builder.reuseId)
            return builder
            
        case .infoCell: /// Для ячейки описания события
            let builder = AddEventInfoCellBuilder(text: model.text)
            builder.delegate = self
            tableView.register(AddEventInfoCell.self, forCellReuseIdentifier: builder.reuseId)
            return builder
        }
    }
}

//MARK: - TVFactoryProtocol
extension AddEventFactory: TVFactoryProtocol {
    
    var builders: [TVCBuilderProtocol] {
        var builders: [TVCBuilderProtocol] = []
        builders.append(contentsOf: [createBuilder(with: model, type: .photoCell),
                                     createBuilder(with: model, type: .titleCell),
                                     createBuilder(with: model, type: .infoCell)])
        return builders
    }
    
    func catchModel(completion: @escaping (Any?) -> Void) {
        completion(model)
    }
}

//MARK: - AddEventFactoryProtocol
extension AddEventFactory: AddEventFactoryProtocol {

    func didPhotoButtonTapped() {
        delegate?.presentPicker()
    }
    
    func didChangedText(with type: AddEventCellType,
                        text: String) {
        switch type {
        case .titleCell: /// Для ячейки заголовка события
            model.title = text
        case .infoCell: /// Для ячейки описания события
            model.text = text
        default: break
        }
    }
}



