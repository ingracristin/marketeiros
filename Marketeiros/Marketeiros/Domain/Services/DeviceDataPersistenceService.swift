//
//  DeviceDataPersistenceService.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 08/07/21.
//

import Foundation
import UIKit

enum LocalDirectories : String {
    case posts
    case moodBoard
    case profile
}

class DeviceDataPersistenceService {
    
    static let current = DeviceDataPersistenceService()
    
    private init() {}
    
    var persistedImagesNames : [LocalDirectories : [String]] = [
        LocalDirectories.posts : [String](),
        LocalDirectories.moodBoard : [String](),
        LocalDirectories.profile : [String]()
    ]
    
    enum DevicePersistenceErrors: Error {
        case errorSavingItem(String)
        case errorFetchingItem(String)
        case errorCreatingDirectory(String)
    }
    
    func write(image: UIImage, identifiedBy uid: String,on directory: LocalDirectories) -> Result<Bool, DevicePersistenceErrors> {
        let documentsDirectory = getURLOf(directory: directory.rawValue)
        let dataPath = documentsDirectory.appendingPathComponent(uid)
        
        do {
            guard let imageData = image.jpeg(.high) else {
                return .failure(.errorFetchingItem("Error Saving Item"))
            }
            try imageData.write(to: dataPath, options: [])
            persistedImagesNames[directory]!.append(uid)
            
            return .success(true)
        } catch {
            return .failure(.errorSavingItem(error.localizedDescription))
        }
    }
    
    func getImage(identifiedBy uid: String, on directory: LocalDirectories) -> Result<UIImage, DevicePersistenceErrors> {
        let documentsDirectory = getURLOf(directory: directory.rawValue)
        let dataPath = documentsDirectory.appendingPathComponent(uid)
        do {
            let dataImage = try Data(contentsOf: dataPath)
            guard let image = UIImage(data: dataImage) else {
                return .failure(.errorFetchingItem("Error transforming Data"))
            }
            return .success(image)
        } catch {
            return .failure(.errorFetchingItem(error.localizedDescription))
        }
    }
    
    func directoryExists(named directory : LocalDirectories) -> Bool {
        let fullDirectoryPath = getURLOf(directory: directory.rawValue)
        var isDir : ObjCBool = true
        let exists = FileManager.default.fileExists(atPath: fullDirectoryPath.path, isDirectory: &isDir)

        return exists
    }
    
    func createDirectory(named directory: LocalDirectories) -> Result<Bool, DevicePersistenceErrors> {
        let fullDirectoryPath = getURLOf(directory: directory.rawValue)
        do {
            try FileManager.default.createDirectory(atPath: fullDirectoryPath.path, withIntermediateDirectories: true, attributes: nil)
            return .success(true)
        } catch {
            return .failure(.errorFetchingItem(error.localizedDescription))
        }
    }
    
    func getAllPersistedImagesNames(from directory: LocalDirectories) -> [String] {
        let allUrls = getAllFilesURLFrom(directory: directory)
        var imageNames = [String]()
        
        for url in allUrls {
            let name = String(url.absoluteString.split(separator: "/").last!)
            imageNames.append(name)
        }
        persistedImagesNames[directory] = imageNames
        return imageNames
    }
    
    private func getAllFilesURLFrom(directory: LocalDirectories) -> [URL] {
        let appDocumentsDirectory = getURLOf(directory: directory.rawValue)
        do {
            let urls = try FileManager.default.contentsOfDirectory(at: appDocumentsDirectory, includingPropertiesForKeys: [], options: .skipsHiddenFiles)
            return urls
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    private func getURLOf(directory : String) -> URL {
        let appDocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fullDirectoryPath = appDocumentsDirectory.appendingPathComponent(directory, isDirectory: true)
        return fullDirectoryPath
    }
}

enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        rawValue
    }
}

protocol ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}

extension UserDefaults: ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}
