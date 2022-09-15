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
              file: String) -> URL?
    
    func write(_ image: Data,
               to directoryYear: String,
               and directoryEvent: String,
               file: String) -> String?
}

final class FileManagerService {
    
    static var shared: FileManagerProtocol = FileManagerService()
    
//    private init() {}
    
    private let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}


extension FileManagerService: FileManagerProtocol {
    
    func read(from directoryYear: String,
              and directoryEvent: String,
              file: String) -> URL? {
        
        let filePath = path.appendingPathComponent(directoryYear).appendingPathComponent(directoryEvent).appendingPathComponent(file)
        
        if FileManager.default.fileExists(atPath: filePath.path) {
            return filePath
        }
        return nil
    }
    
    
    
    
    func write(_ image: Data,
               to directoryYear: String,
               and directoryEvent: String,
               file: String) -> String? {
        
        let filePath = path.appendingPathComponent(directoryYear).appendingPathComponent(directoryEvent)
        
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
            return filePath.appendingPathComponent(file).path
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
