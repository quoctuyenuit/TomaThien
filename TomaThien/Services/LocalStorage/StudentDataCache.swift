//
//  SQLiteDatabase.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/31/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import SQLite
import RxSwift

struct StudentData {
    var id: String
    var image: String
    init(id: String, image: UIImage) {
        self.id = id
        self.image = image.jpegData(compressionQuality: 0)?.base64EncodedString(options: .lineLength64Characters) ?? ""
    }
    
    init(id: String, image: String) {
        self.id = id
        self.image = image
    }
}

class StudentDataCache: SqliteDatabase {
    private var studentTable: Table!
    private let colId = Expression<String>("id")
    private let colImage = Expression<String?>("imageUrl")
    
    public static let sharedInstance = StudentDataCache()
    
    override init() {
        super.init()
        self.setup()
    }
    
    override func setup() {
        super.setup()
        do
        {
            try database.run(studentTable.create { t in
                t.column(colId, primaryKey: true)
                t.column(colImage)
            })
        } catch (let ex) {
            print(ex.localizedDescription)
        }
    }
    
    public func insert(value: StudentData) throws {
        let insert = self.studentTable.insert(colId <- value.id.encodeId(), colImage <- value.image)
        try self.database.run(insert)
    }
    
    public func select(id: String) -> StudentData? {
        let element = self.studentTable.filter(self.colId == id)
        var student: StudentData?
        
        try? self.database.prepare(element).forEach({ (row) in
            student = StudentData(id: row[self.colId], image: row[self.colImage] ?? "")
        })
        
        return student
    }
    
    public func selectAll() -> Observable<StudentData> {
        return Observable.create({ (observer) -> Disposable in
            try? self.database.prepare(self.studentTable).forEach({ (row) in
                let data = StudentData(id: row[self.colId], image: row[self.colImage] ?? "")
                observer.onNext(data)
            })
            return Disposables.create()
        })
    }
    
    public func delete(id: String) throws {
        let student = self.studentTable.filter(self.colId == id)
        try self.database.run(student.delete())
    }
    
    public func update(id: String, newValue: StudentData) throws {
        let student = self.studentTable.filter(self.colId == id)
        try self.database.run(student.update(self.colId <- newValue.id, self.colImage <- newValue.image))
    }
    
    public func count() throws -> Int {
        return try self.database.scalar(self.studentTable.count)
    }
}

extension String {
    public func encodeId() -> String {
        return self.replacingOccurrences(of: " ", with: "").lowercased()
    }
}
