//
//  DateConvertService.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 11.08.2022.
//

import Foundation

final class DateConvertService {
    
    /// Преобразует формат Date в String
    /// - Parameter date: дата
    static func convertDateToStr(_ date: Date?) -> String {
        let df = DateFormatter()
        
        guard let date = date else { return "error while wrapping Date"}
        
        df.dateStyle = .short
        df.locale = Locale(identifier: "ru_RU")
        df.dateFormat = "HH:mm  dd.MMM.yyyy"
        let stringDate = df.string(from: date)
        
        return stringDate
    }
    
    static func convertStrToDate(_ dateString: String) -> Date? {
        let df = DateFormatter()
//        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        df.dateFormat = "MM-dd-yyyy"
        df.locale = Locale(identifier: "ru_RU")
        
        guard let date = df.date(from: dateString) else {
            return nil }
        return date
    }
}

//"2016-04-14T10:44:00+0000"
