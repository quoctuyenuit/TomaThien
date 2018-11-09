//
//  QRScannerStore.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/29/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import RxSwift

enum QRScannerStoreErorr: String, Error {
    case makeCacheFolder = "Make cache folder failt"
    var description: String {
        return self.rawValue
    }
}

struct QRScannerCache: Codable, Equatable, Hashable {
    let data: Data
    let time: TimeInterval
    
    var hashValue: Int {
        return Int(time)
    }
    
    private enum CodingKeys: String, CodingKey {
        case data
        case time
    }
    
    static func == (lhs: QRScannerCache, rhs: QRScannerCache) -> Bool {
        return lhs.time == rhs.time
    }
    
    init(data: Data, time: TimeInterval) {
        self.data = data
        self.time = time
    }
    
    init(from decoder: Swift.Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode(Data.self, forKey: .data)
        time = try container.decode(TimeInterval.self, forKey: .time)
    }
    
}

class QRScannerStore: SafeAccessFileProtocol {
    private let folderName = "QRScannerStoreCache"
    private let fileName = "QRScannerStoreFile"
    private var cacheURL: URL?
    private var urlCacheFile: URL?
    private var cacheLogs: [QRScannerCache] = []
    private (set) lazy var lockEvent: NSRecursiveLock = NSRecursiveLock()
    private var senderMessage = PublishSubject<[String: String]>()
    private let disposeBag = DisposeBag()
    public static let sharedInstance = QRScannerStore()
    
    private init() {
        self.setupEvent()
    }
    
    private func setupEvent() {
        self.senderMessage
            .subscribe{[weak self] in
                guard let dic = $0.element else { return }
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                    self?.saveCacheMessage(from: jsonData)
                    
                    let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    // here "decoded" is of type `Any`, decoded from JSON data
                    
                    // you can now cast it with the right type
                    if let dictFromJSON = decoded as? [String:String] {
                        print(dictFromJSON)
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            }.disposed(by: disposeBag)
    }
    
    // MARK: - Make folder
    private func makeFolderCache() throws {
        let folder = FileManager.default.cacheURL?.appendingPathComponent(folderName, isDirectory: true)
        // Check exist
        var isCreated = false
        FileManager.default.createDirectoy(at: folder, is: &isCreated)
        if !isCreated {
            // Check
            throw QRScannerStoreErorr.makeCacheFolder
        }
        
        // Cache
        self.cacheURL = folder
        // Find File Log
        self.createFileLog(with: fileName)
        
        // Load
        let urlCache = self.cacheURL?.appendingPathComponent("\(self.fileName).txt")
        print(urlCache?.absoluteString ?? "")
        self.urlCacheFile = urlCache
        guard let fCache = self.urlCacheFile else {
            return
        }
        
        let attsFile = try FileManager.default.attributesOfItem(atPath: fCache.path)
        let size = attsFile[FileAttributeKey.size] as? Double ?? 0
        guard size < 2e+6 else {
            // remove
            debugPrint("Over size")
            FileManager.default.removeFile(at: fCache)
            self.createFileLog(with: fileName)
            return
        }
        let data = try Data.init(contentsOf: fCache)
        guard data.count > 0 else {
            return
        }
        self.cacheLogs = try [QRScannerCache].toValue(from: data)
    }
    
    private func saveCacheMessage(from data: Data) {
        let cache = QRScannerCache(data: data, time: Date().timeIntervalSince1970)
        // Save
        self.save(dataAppend: cache)
    }
    
    private func save(dataAppend: QRScannerCache? = nil) {
        excuteActionInSafe { [unowned self] in
            guard let urlSave = self.urlCacheFile else {
                return
            }
            if let data = dataAppend {
                self.cacheLogs.append(data)
            }
            guard let data = try? self.cacheLogs.toData() else {
                return
            }
            
            
            do {
                try data.write(to: urlSave)
                debugPrint("Write cache successful")
            } catch {
                debugPrint("Write cache failt")
            }
        }
    }
    
    public func writeCache(dic: [String: String]) {
        debug(block: { try makeFolderCache() }, default: nil)
        self.senderMessage.onNext(dic)
    }
}

extension QRScannerStore {
    private func createFileLog(with name: String) {
        let linkFileTxt = self.url(for: name)
        guard FileManager.default.fileExist(at: linkFileTxt).not else {
            return
        }
        FileManager.default.createFile(at: linkFileTxt)
    }
    
    private func url(for file: String) -> URL? {
        let nUrl = cacheURL?.appendingPathComponent("\(file).txt")
        return nUrl
    }
}

// MARK: Helper Debug
@discardableResult
func debug<T>(block: () throws -> T?, default: @autoclosure () -> T?) -> T? {
    do {
        let result = try block()
        return result
    } catch {
        print(error)
        return `default`()
    }
}
