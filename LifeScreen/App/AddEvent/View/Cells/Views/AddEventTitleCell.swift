//
//  AddEventTitleCell.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//

import UIKit

/// Протокол загрузки данных для AddEventTitleCell
protocol AddEventTitleCellProtocol {
    func displayData(_ title: String)
}

final class AddEventTitleCell: UITableViewCell {
    
    static let reuseId = "AddEventTitleCell"
    
    weak var delegate: AddEventTFProtocol?
    
    var titleEventTF: UITextField = {
        let tf = UITextField()
        let font = UIFont(name: "Helvetica-Bold", size: 20)
    
        tf.textColor = .black.withAlphaComponent(0.7)
        tf.font = font
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        
        let placeholder = "Заголовок"
        tf.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray3,
                                                                   NSAttributedString.Key.font: font ?? UIFont()])
        return tf
    }()
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupConstraints()
    }
    
    private func setupElements() {
        self.selectionStyle = .none
        
        titleEventTF.delegate = self
    }
    
    private func setupConstraints() {
        
        addSubview(titleEventTF)
        
        titleEventTF.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleEventTF.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        titleEventTF.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        titleEventTF.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
    }
}

//MARK: - AddEventTitleCellProtocol
extension AddEventTitleCell: AddEventTitleCellProtocol {
    func displayData(_ title: String) {
        
    }
}

//
extension AddEventTitleCell: UITextFieldDelegate {
    
    /// Скрыть клавиатуру при нажатии по пустому месту
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let vc = delegate as? AddEventViewController else { return }
        vc.tableView.endEditing(true)
    }
}
