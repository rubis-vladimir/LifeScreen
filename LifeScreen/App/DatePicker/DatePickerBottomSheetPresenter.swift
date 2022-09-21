//
//  DatePickerBottomSheetPresenter.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.09.2022.
//

import Foundation

protocol DatePickerBottomSheetPresentation {
    func send(date: Date)
}


final class DatePickerBottomSheetPresenter {
    weak var presenter: DatePickerBottomSheetPresenterDelegate?
    weak var delegate: AddEventResponseDelegate?
    
    private var date: Date 
    
    init(date: Date) {
        self.date = date
    }
    
    deinit {
        print("DATE PICKER PRESENTER OFF")
    }
    
    func updateView() {
        presenter?.showDate(date)
    }
}

extension DatePickerBottomSheetPresenter: DatePickerBottomSheetPresentation {
    func send(date: Date) {
        delegate?.handleResponse(.dataPicker(date: date))
    }
}
