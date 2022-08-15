//
//  FilterManager.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 11.08.2022.
//

import Foundation

protocol FileManagerProtocol {
    func read(from directoryYear: String,
              and directoryEvent: String,
              file: String) -> String?
    
    func write(_ image: Data,
               to directoryYear: String,
               and directoryEvent: String,
               file: String)
}

final class FileManagerService {
    
    private let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}


extension FileManagerService: FileManagerProtocol {
    
    func read(from directoryYear: String,
              and directoryEvent: String,
              file: String) -> String? {
        
        let filePath = path.appendingPathComponent(directoryYear).appendingPathComponent(directoryEvent).appendingPathComponent(file).path
        
        if FileManager.default.fileExists(atPath: filePath) {
            return filePath
        }
        return nil
//        do {
//            let photos = try String(contentsOf: file)
//
//            for photo in photos.split(separator: ";") {
//                print(photo)
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
    }
    
    
    
    func write(_ image: Data,
               to directoryYear: String,
               and directoryEvent: String,
               file: String) {
        
        let filePath = path.appendingPathComponent(directoryYear).appendingPathComponent(directoryEvent)
        print(filePath.path)
        if !FileManager.default.fileExists(atPath: filePath.absoluteString) {
            do {
                try FileManager.default.createDirectory(at: filePath,
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }

        
        do {
            try image.write(to: filePath.appendingPathComponent(file))
        } catch {
            print(error.localizedDescription)
        }
    }
//    
//    func createDirectory() {
//        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("photosFolder")
//
//    }
}
