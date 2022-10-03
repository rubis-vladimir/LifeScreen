//
//  FilterManager.swift
//  LifeScreen
//
//  Created by Владимир Рубис on 11.08.2022.
//

import Foundation

protocol FileManagerProtocol {
    func getData(from urlString: String,
                 date: Date) -> Data?
    
    func write(_ image: [Data],
               date: Date,
               file: String) -> [String]
}

final class FileManagerService {
    
    static let shared: FileManagerProtocol = FileManagerService()
    
    private init() {}
    
    private var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}


extension FileManagerService: FileManagerProtocol {
    
    func getData(from urlString: String,
                 date: Date) -> Data? {
        let components = DateConvertService.shared.decomposeDate(date)
        let filePath = getPath(directoryPathComponents: components,
                               file: urlString)
        guard FileManager.default.fileExists(atPath: filePath.path) else { return nil }
        
        do {
            return try Data(contentsOf: filePath)
        } catch {
            return nil
        }
    }
    
    func write(_ images: [Data],
               date: Date,
               file: String) -> [String] {
        
        let components = DateConvertService.shared.decomposeDate(date)
        let filePath = getPath(directoryPathComponents: components,
                               file: file)
        createDirectory(with: filePath)
        var paths: [String] = []
        for i in 0..<images.count {
            do {
                let pathToFile = filePath.appendingPathComponent(i.description)
                try images[i].write(to: pathToFile)
                paths.append(pathToFile.path)
            } catch {
                print(error.localizedDescription)
            }
        }
        print(paths)
        return paths
    }
    
    private func getPath(directoryPathComponents: [String], file: String) -> URL {
        return directoryPathComponents.reduce(path) {
            $0.appendingPathComponent($1)
        }.appendingPathComponent(file)
    }
    
    private func createDirectory(with path: URL) {
        //        let path = path.deletingLastPathComponent()
        if !FileManager.default.fileExists(atPath: path.absoluteString) {
            do {
                try FileManager.default.createDirectory(at: path,
                                                        withIntermediateDirectories: true)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
