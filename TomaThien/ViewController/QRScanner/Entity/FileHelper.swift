//
//  FileHelper.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/29/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation

// MARK: - File
public extension FileManager {
    func fileExist(at url: URL?) -> Bool {
        guard let url = url, url.isFileURL else {
            return false
        }
        return self.fileExists(atPath: url.path)
    }
    
    @discardableResult
    func createFile(at url: URL?, contents: Data? = nil, attributes: [FileAttributeKey: Any]? = nil) -> Bool {
        guard let url = url, url.isFileURL else {
            return false
        }
        return self.createFile(atPath: url.path, contents: contents, attributes: attributes)
    }
    
    func removeFile(at url: URL?) {
        guard let url = url, url.isFileURL else {
            return
        }
        try? self.removeItem(at: url)
    }
    
    func createDirectoy(at url: URL?, is created: inout Bool) {
        guard let fWriteFile = url else {
            return
        }
        var isDirectory: ObjCBool = false
        let exist = self.fileExists(atPath: fWriteFile.path, isDirectory: &isDirectory)
        guard !exist || !isDirectory.boolValue else {
            created = true
            return
        }
        do {
            try self.createDirectory(at: fWriteFile, withIntermediateDirectories: true, attributes: nil)
            created = true
        } catch {
            created = false
            #if DEBUG
            assert(false, error.localizedDescription)
            #endif
        }
    }
    
    var cacheURL: URL? {
        return self.urls(for: .cachesDirectory, in: .userDomainMask).first
    }
}
