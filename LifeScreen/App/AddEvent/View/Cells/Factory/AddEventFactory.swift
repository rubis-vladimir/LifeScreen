//
//  AddEventFactory.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//

import UIKit

/// Типы текстовых ячеек модуля AddEvent
enum AddEventCellType {
    /// Ячейка для подгрузки фото
    case photoCell
    /// Ячейка с заголовком события
    case titleCell
    /// Ячейка с описанием события
    case infoCell
}

/// Действия при нажатии на кнопки
enum AddEventActions {
    /// Навигация
    case route(_ type: AddEventTarget)
    /// Сохраняем событие
    case saveEvent
    /// Изменяем событие
    case changeEvent(_ type: AddEventChangeModelActions)
}

/// Фабрика настройки табличного представления модуля AddEvent
final class AddEventFactory {
    
    private let tableView: UITableView
    private let model: AddEventModel
    private weak var delegate: AddEventPresentation?
    
    /// Инициализатор
    ///  - Parameters:
    ///    - tableView: настраиваемая таблица
    ///    - delegate: делегат для передачи UIEvent (VC)
    init(tableView: UITableView,
         model: AddEventModel,
         delegate: AddEventPresentation?) {
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
            if !model.imageData.isEmpty {
                let builder = AddEventSlideShowCellBuilder(imageData: model.imageData)
                builder.delegate = delegate
                tableView.register(AddEventSlideShowCell.self, forCellReuseIdentifier: builder.reuseId)
                return builder
            } else {
                let builder = AddEventPhotoCellBuilder()
                builder.delegate = delegate
                tableView.register(AddEventPhotoCell.self, forCellReuseIdentifier: builder.reuseId)
                return builder
            }
            
        case .titleCell: /// Для ячейки заголовка события
            let builder = AddEventTitleCellBuilder(title: model.title)
            builder.delegate = delegate
            tableView.register(AddEventTitleCell.self, forCellReuseIdentifier: builder.reuseId)
            return builder
            
        case .infoCell: /// Для ячейки описания события
            let builder = AddEventInfoCellBuilder(text: model.text)
            builder.delegate = delegate
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
}


