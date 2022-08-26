//
//  AddEventInfoCell.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 22.08.2022.
//

import UIKit

/// Протокол загрузки данных AddEventInfoCell
protocol AddEventInfoCellProtocol {
    
    func displayData(_ text: String)
}

final class AddEventInfoCell: UITableViewCell {

    static let reuseId = "AddEventInfoCell"
    
    var eventTextView: UITextView = {
        let tv = UITextView()
        let font = UIFont(name: "Helvetica", size: 14)
        
        tv.text = "Расскажите о вашем событии..."
        tv.font = font
        tv.textColor = .systemGray
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        return tv
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupCell()
        
        eventTextView.delegate = self
    }
    
    private func setupCell() {
        
        self.selectionStyle = .none
        
        addSubview(eventTextView)
        
        eventTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        eventTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        eventTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        eventTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        
    }
}

//MARK: - AddEventInfoCellProtocol
extension AddEventInfoCell: AddEventInfoCellProtocol {
    func displayData(_ text: String) {
        
    }
}

//MARK: -
extension AddEventInfoCell: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.systemGray {
            textView.text = nil
            textView.textColor = UIColor.black.withAlphaComponent(0.7)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Расскажите о вашем событии..."
            textView.textColor = UIColor.systemGray
        }
    }
}
