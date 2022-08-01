//
//  Event2.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 29.07.2022.
//

import Foundation

struct Event2: Codable {
    
    var title: String
    var discription: String
    var date: Date
//    var eventImage: Data?
//    var photoArray: [Data]?
    var eventImage: URL?
    var photoArray: [URL]?
    
    

    static func generateEvent() -> Event {
        let randomImageH = Int.random(in: 1500...2800)
        let randomImageW = Int.random(in: 1500...2800)

        let urlString = "https://source.unsplash.com/random/\(randomImageH)x\(randomImageW)?sig=\(Int.random(in: 0...5000))"
        
        let mockedDummy = Event(
            titleInfo: "Dummy",
            // Full hd image to be used afte user tap on thumb
            mainImage: Image(url: urlString,
                             width: Double(randomImageW),
                             height: Double(randomImageH))
            ,
            thumbnail: Image(url: urlString,
                             width: Double(randomImageW),
                             height: Double(randomImageH))
            )
        return mockedDummy
    }
}

