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
    weak var delegate: AddEventFactoryProtocol?
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
        eventTextView.text = text == "" ? placeholder : text
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
            guard let text = textView.text  else { return }
            print(text)
            self?.delegate?.didChangedText(with: .infoCell, text: text)
        })
    }
}
