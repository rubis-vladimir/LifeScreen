//
//  AddEventTitleCell.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//

import UIKit

/// Ячейка для отображения заголовка события
final class AddEventTitleCell: UITableViewCell {
    
    /// Идентификатор ячейки
    static let reuseId = "AddEventTitleCell"
    /// Делегат для обработки взаимодействия
    weak var delegate: AddEventPresentation?
    /// Таймер
    private var timer: Timer?
    
    private var titleEventTF: UITextField = {
        let tf = UITextField()
        let font = UIFont(name: "Helvetica-Bold", size: 20)
        let placeholder = "Заголовок"
        
        tf.textColor = .black.withAlphaComponent(0.7)
        tf.font = font
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        tf.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray3,
                         NSAttributedString.Key.font: font ?? UIFont()]
        )
        return tf
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupCell()
    }
    
    /// Настраивает ячейку и ее элементы
    private func setupCell() {
        self.selectionStyle = .none
        
        titleEventTF.delegate = self
        addSubview(titleEventTF)
        
        /// Настройка констрейнтов
        NSLayoutConstraint.activate([titleEventTF.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     titleEventTF.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
                                     titleEventTF.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
                                     titleEventTF.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)])
    }
    
    /// Отображает передаваемые данные
    ///  - Parameter text: заголовок
    func displayData(_ title: String?) {
        titleEventTF.text = title
    }
}

//MARK: - UITextFieldDelegate
extension AddEventTitleCell: UITextFieldDelegate {
    
    /// Запрашивает делегата, следует ли обрабатывать нажатие кнопки Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        /// Для завершения редактирования
        self.endEditing(true)
    }
    
    /// Сообщает делегату о изменении текста в текстовом представлении
    func textFieldDidChangeSelection(_ textField: UITextField) {
        /// Для обновления модели данных
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] (_) in
            guard let text = textField.text  else { return }
            self?.delegate?.handleAction(
                .changeEvent(.changeText(text, type: .titleCell))
            )
        })
    }
}
