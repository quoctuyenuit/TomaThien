//
//  UserLocal.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/31/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import SQLite
import RxSwift

class UserDataCache: SqliteDatabase {
    private var userTable: Table!
    private let name = Expression<String?>("name")
    private let birthDay = Expression<Date?>("birthday")
    private let phoneNumber = Expression<String?>("phoneNumber")
    private let email = Expression<String?>("email")
    private let identify = Expression<String>("identify")
    private let school = Expression<String?>("school")
    private let address = Expression<String?>("address")
    private let yearOfAdmission = Expression<Int?>("yearOfAdmission")
    private let yearsOfStudy = Expression<String?>("yearsOfStudy")
    private let team = Expression<Int?>("team")
    private let image = Expression<String?>("image")
    private let userType = Expression<Int?>("image")
    private let status = Expression<Bool?>("status")
    
    public static let sharedInstance = UserDataCache()
    
    override init() {
        super.init()
        self.setup()
    }
    
    override func setup() {
        super.setup()
        do
        {
            try database.run(userTable.create { t in
                t.column(identify, primaryKey: true)
                t.column(name)
                t.column(birthDay)
                t.column(phoneNumber)
                t.column(email)
                t.column(school)
                t.column(address)
                t.column(yearOfAdmission)
                t.column(yearsOfStudy)
                t.column(team)
                t.column(image)
                t.column(userType)
                t.column(status)
            })
        } catch (let ex) {
            print(ex.localizedDescription)
        }
    }
    
    public func insert(value: LocalUser) throws {
        let insert = self.userTable.insert(identify <- value.identify.encodeId(),
                                           name <- value.name,
                                           birthDay <- value.birthDay,
                                           phoneNumber <- value.phoneNumber,
                                           email <- value.email,
                                           school <- value.school,
                                           address <- value.address,
                                           yearOfAdmission <- value.yearOfAdmission,
                                           yearsOfStudy <- "\(value.yearsOfStudy)",
                                           team <- value.team,
                                           userType <- value.userType.rawValue,
                                           status <- value.status == .authentic ? true : false)
        try self.database.run(insert)
    }
    
    public func select(id: String) -> LocalUser? {
        let element = self.userTable.filter(self.identify == id)
        var user: LocalUser?
        
        try? self.database.prepare(element).forEach({ (row) in
            user = LocalUser(name: row[name] ?? "",
                             birthDay: row[birthDay] ?? Date(),
                             phoneNumber: row[phoneNumber] ?? "",
                             email: row[email] ?? "",
                             identify: row[identify] ,
                             school: row[school] ?? "",
                             address: row[address] ?? "",
                             yearOfAdmission: row[yearOfAdmission] ?? 0,
                             yearsOfStudy: Float.init(row[yearsOfStudy] ?? "0") ?? 0,
                             team: row[team] ?? 0,
                             image: row[image] ?? "",
                             userType: UserType(rawValue: row[userType] ?? 1) ?? .member,
                             status: (row[status] ?? false) ? .authentic : .notAuthentic)
        })
        return user
    }
    
    public func update(id: String, value: LocalUser) throws {
        let student = self.userTable.filter(self.identify == id)
        try self.database.run(student.update(identify <- value.identify.encodeId(),
                                             name <- value.name,
                                             birthDay <- value.birthDay,
                                             phoneNumber <- value.phoneNumber,
                                             email <- value.email,
                                             school <- value.school,
                                             address <- value.address,
                                             yearOfAdmission <- value.yearOfAdmission,
                                             yearsOfStudy <- "\(value.yearsOfStudy)",
                                             team <- value.team,
                                             userType <- value.userType.rawValue,
                                             status <- value.status == .authentic ? true : false))
    }
    
    public func count() throws -> Int {
        return try self.database.scalar(self.userTable.count)
    }
}
