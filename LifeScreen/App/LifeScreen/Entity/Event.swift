//
//  Event.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 20.07.2022.
//

import Foundation

struct Event: Codable {
    struct Image: Codable {
        var url: String
        var width: Double
        var height: Double
    }

    var titleInfo: String

    // Url to pass if want to display full hd
    var mainImage: Image?
    var thumbnail: Image?

    static func generateDumyImage() -> Event {
        let randomImageH = Int.random(in: 1800...3800)
        let randomImageW = Int.random(in: 1800...3800)

        let urlString = "https://source.unsplash.com/random/\(randomImageH)x\(randomImageW)?sig=\(Int.random(in: 0...1000))"
        
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

