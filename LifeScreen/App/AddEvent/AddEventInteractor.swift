//
//  AddEventInteractor.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 17.08.2022.
//

import UIKit


protocol AddEventBusinessLogic {
    
    func save(event: EventModel)
}


final class AddEventInteractor {
    weak var presenter: AddEventPresentationManagement?
    
    private let localeImageDownloadManager: LocallyLoadedFromDevice
    
    init(localeImageDownloadManager: LocallyLoadedFromDevice = LocalImageDownloadManager()) {
        self.localeImageDownloadManager = localeImageDownloadManager
    }
    
}


extension AddEventInteractor: AddEventBusinessLogic {
    func save(event: EventModel) {
        <#code#>
    }
}
