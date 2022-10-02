//
//  IdСonfigurator.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 01.09.2022.
//

import Foundation

final class IdСonfigurator {
    
    static var shared = IdСonfigurator()
    
    private init() {}
    
    func getId(title: String,
               date: Date) -> String {
        let dateString = DateConvertService.shared.convertDateToStr(date)
        let string = dateString + " " + title
        return string.data(using: .utf8)?.base64EncodedString() ?? string
    }
}
