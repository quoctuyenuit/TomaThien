//
//  SqliteDatabase.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/31/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import SQLite
enum SQLiteDatabaseError: String, Error {
    case makePath = "Cannot make database path"
}

class SqliteDatabase {
    private static let databaseFileName = "CacheDatabase.sqlite"
    var database: Connection!
    private static var filePath: String? = {
        let folder = FileManager.default.cacheURL?.appendingPathComponent("DatabaseCache", isDirectory: true)
        var isCreated = false
        FileManager.default.createDirectoy(at: folder, is: &isCreated)
        if !isCreated {
            return nil
        }
        
        return folder?.appendingPathComponent(databaseFileName).relativePath
    }()
    
    func setup() {
        do
        {
            guard let path = SqliteDatabase.filePath else { throw SQLiteDatabaseError.makePath }
            self.database = try Connection(path)
        } catch (let ex) {
            print(ex.localizedDescription)
        }
    }
}
