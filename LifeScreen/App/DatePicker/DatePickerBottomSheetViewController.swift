//
//  DatePickerBottomSheetViewController.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 29.08.2022.
//

import UIKit

protocol DatePickerBottomSheetPresenterDelegate: AnyObject {
    func showDate(_ date: Date)
}

final class DatePickerBottomSheetViewController: UIViewController {
    
    var presenter: DatePickerBottomSheetPresentation?
    
    let backgroundView = UIView()
    let containerView = UIStackView()
    let datePicker = UIDatePicker()
    private var doneButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupElements()
        setupConstraints()
    }
    
    deinit {
        print("DATE PICKER VC OFF")
    }
    
    @objc private func didDoneButtonTapped() {
        
    }
    
    private func setupElements() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .clear
        
        containerView.axis = .vertical
        containerView.distribution = .fill
        containerView.alignment = .fill
        containerView.spacing = 10
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
//        doneButton = UIButton().createDoneButton(selector: #selector(didDoneButtonTapped))
        let action = UIAction { [weak self] _ in
            
            guard let date = self?.datePicker.date else { return }
            self?.presenter?.send(date: date)
            self?.dismiss(animated: true)
        }
        doneButton = UIButton().createButtonTest(action: action)
    }
    
    private func setupConstraints() {
        containerView.addArrangedSubview(datePicker)
        containerView.addArrangedSubview(doneButton)
        backgroundView.addSubview(containerView)
        view.addSubview(backgroundView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.topAnchor.constraint(greaterThanOrEqualTo: backgroundView.topAnchor, constant: 50),
            containerView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -50),
            containerView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 30),
            containerView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -30)
        ])
    }
}

extension DatePickerBottomSheetViewController: DatePickerBottomSheetPresenterDelegate {
    func showDate(_ date: Date) {
        print("TEST SUCCESS. DATE - \(date)")
        datePicker.date = date
    }
}
