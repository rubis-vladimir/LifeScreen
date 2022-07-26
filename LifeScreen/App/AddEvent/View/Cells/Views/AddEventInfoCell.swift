//
//  AddEventInfoCell.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//

import UIKit

/// Ячейка для отображения описания события
final class AddEventInfoCell: UITableViewCell {
    
    /// Идентификатор ячейки
    static let reuseId = "AddEventInfoCell"
    /// Делегат для обработки взаимодействия
    weak var delegate: AddEventPresentation?
    /// Таймер
    private var timer: Timer?
    /// Дефолтный текст в TV
    private let placeholder = "Расскажите о вашем событии..."
    
    private var eventTextView: UITextView = {
        let tv = UITextView()
        let font = UIFont(name: "Helvetica", size: 14)
        
        tv.font = font
        tv.textColor = .systemGray
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupCell()
    }
    
    /// Отображает передаваемые данные
    ///  - Parameter text: текст описания
    func displayData(_ text: String?) {
        if text == "" {
            eventTextView.text = placeholder
        } else {
            eventTextView.text = text
            eventTextView.textColor = .black.withAlphaComponent(0.7)
        }
    }
    
    /// Настраивает ячейку и ее элементы
    private func setupCell() {
        self.selectionStyle = .none
        
        eventTextView.delegate = self
        addSubview(eventTextView)
        
        /// Настройка констрейнтов
        NSLayoutConstraint.activate([eventTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
                                     eventTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
                                     eventTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
                                     eventTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)])
    }
}

//MARK: - UITextViewDelegate
extension AddEventInfoCell: UITextViewDelegate {
    
    /// Запрашивает делегата, следует ли заменить указанный текст в текстовом представлении
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        /// Для завершения редактирования при нажатии Return
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    /// Сообщает делегату, когда начинается редактирование
    func textViewDidBeginEditing(_ textView: UITextView) {
        /// Для очистки Placeholder
        if textView.textColor == UIColor.systemGray {
            textView.text = nil
            textView.textColor = UIColor.black.withAlphaComponent(0.7)
        }
    }
    
    /// Сообщает делегату, когда заканчивается редактирование
    func textViewDidEndEditing(_ textView: UITextView) {
        /// Для отображения Placeholder
        if textView.text == "" {
            textView.text = placeholder
            textView.textColor = UIColor.systemGray
        }
    }
    
    /// Сообщает делегату о изменении текста в текстовом представлении
    func textViewDidChangeSelection(_ textView: UITextView) {
        /// Для обновления модели данных
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] (_) in
            guard let text = textView.text,
                  text != self?.placeholder else { return }
            self?.delegate?.handleAction(
                .changeEvent(.changeText(text, type: .infoCell))
            )
        })
    }
}
