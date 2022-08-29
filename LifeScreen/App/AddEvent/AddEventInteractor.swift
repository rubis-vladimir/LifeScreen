//
//  AddEventInteractor.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 17.08.2022.
//

import Foundation


protocol AddEventBusinessLogic {
    
    func save(event: AddEventModel)
}


final class AddEventInteractor {
    weak var presenter: AddEventPresentationManagement?
    
    
}


extension AddEventInteractor: AddEventBusinessLogic {
    func save(event: AddEventModel) {
        print("Идем на сохранение")
    }
}
