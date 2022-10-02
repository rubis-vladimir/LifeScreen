//
//  DatePickerBottomSheetViewController.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 29.08.2022.
//

import UIKit

/// Протокол работы с DatePicker
protocol DatePickerBottomSheetPresenterDelegate: AnyObject {
    
    /// Отображает текущую дату события
    ///  - Parameter date: дата
    func showDate(_ date: Date)
}

/// Контроллер обновления даты события
final class DatePickerBottomSheetViewController: UIViewController {
    
    /// Презентер модуля DatePickerBottomSheet
    var presenter: DatePickerBottomSheetPresentation?

    let containerView = UIStackView()
    let datePicker = UIDatePicker()
    private var doneButton = UIButton()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupElements()
        setupConstraints()
    }
    
    //MARK: Private func
    /// Настраивает UI элементы
    private func setupElements() {
        containerView.axis = .vertical
        containerView.distribution = .fill
        containerView.alignment = .fill
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        let action = UIAction { [weak self] _ in
            guard let date = self?.datePicker.date else { return }
            self?.presenter?.send(date: date)
            self?.dismiss(animated: true)
        }
        doneButton = UIButton().createButtonTest(action: action)
    }
    
    /// Настраивает констрейнты
    private func setupConstraints() {
        containerView.addArrangedSubview(datePicker)
        containerView.addArrangedSubview(doneButton)
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 50),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            doneButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

//MARK: - DatePickerBottomSheetPresenterDelegate
extension DatePickerBottomSheetViewController: DatePickerBottomSheetPresenterDelegate {
    func showDate(_ date: Date) {
        datePicker.date = date
    }
}
