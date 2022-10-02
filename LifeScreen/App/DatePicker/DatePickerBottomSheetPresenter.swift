//
//  DatePickerBottomSheetPresenter.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.09.2022.
//

import Foundation

/// Протокол передачи даты события
protocol DatePickerBottomSheetPresentation {
    
    /// Отправляет дату делегату
    ///  - Parameter date: дата
    func send(date: Date)
}

/// Слой презентации модуля DatePickerBottomSheet
final class DatePickerBottomSheetPresenter {
    
    weak var view: DatePickerBottomSheetPresenterDelegate?
    weak var delegate: AddEventResponseDelegate?
    private var date: Date 
    
    init(date: Date) {
        self.date = date
    }
    
    func updateView() {
        view?.showDate(date)
    }
}

//MARK: - DatePickerBottomSheetPresentation
extension DatePickerBottomSheetPresenter: DatePickerBottomSheetPresentation {
    func send(date: Date) {
        delegate?.handleResponse(.dataPicker(date: date))
    }
}
