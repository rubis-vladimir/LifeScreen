////
////  LifeEventCellViewModel.swift
////  LifeScreen
////
////  Created by Владимир Рубис on 29.07.2022.
////
//
//import Foundation
//
///// Протокол VM LifeEventCellViewModel
/////   - Parameters:
/////     - title: название события
/////     - discription: описание события
/////     - date: дата события
/////     - imageData: картинка(фото) в формате Data
//protocol LifeEventCellViewModelProtocol {
//    var title: String { get }
//    var discription: String { get }
//    var date: Date { get }
//    var imageData: Data? { get }
//    
//    /// Инициализатор VM
//    init(title: String,
//         discription: String,
//         date: Date,
//         imageData: Data?)
//}
//
///// VM для LifeEventCell
//struct LifeEventCellViewModel: LifeEventCellViewModelProtocol {
//    var title: String
//    var discription: String
//    var date: Date
//    var imageData: Data?
//    
//    init(title: String, discription: String, date: Date, imageData: Data?) {
//        self.title = title
//        self.discription = discription
//        self.date = date
//        self.imageData = imageData
//    }
//}
//
