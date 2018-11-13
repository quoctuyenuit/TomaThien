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
    private let name = Expression<String>("name")
    private let birthDay = Expression<Date>("birthday")
    private let phoneNumber = Expression<String>("phoneNumber")
    private let email = Expression<String>("email")
    private let identify = Expression<String>("identify")
    private let school = Expression<String>("school")
    private let address = Expression<String>("address")
    private let yearOfAdmission = Expression<Int>("yearOfAdmission")
    private let yearsOfStudy = Expression<String>("yearsOfStudy")
    private let team = Expression<Int>("team")
    private let userType = Expression<Int>("userType")
    private let status = Expression<Bool>("status")
    private let imageUrl = Expression<String>("imageUrl")
    
    public static let sharedInstance = UserDataCache()
    
    override init() {
        super.init()
        self.setup()
    }
    
    override func setup() {
        super.setup()
        self.userTable = Table("\(UserDataCache.self)")
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
                t.column(imageUrl)
                t.column(userType)
                t.column(status)
            })
            print("Create User Table successful")
        } catch (let ex) {
            print(ex.localizedDescription)
        }
    }
    
    public func insert(value: User) throws {
        let insert = self.userTable.insert(identify <- value.identify.encodeId(),
                                           name <- value.name,
                                           birthDay <- value.birthDay,
                                           phoneNumber <- value.phoneNumber,
                                           email <- value.email,
                                           school <- value.school,
                                           address <- value.address,
                                           yearOfAdmission <- value.yearOfAdmission,
                                           yearsOfStudy <- "\(value.yearsOfStudy)",
                                           team <- value.team.id,
                                           imageUrl <- value.imageUrl,
                                           userType <- value.userType.rawValue,
                                           status <- value.status == .authentic ? true : false)
        try self.database.run(insert)
        print("insert successful value = \(value)")
    }
    
    public func update(id: String, value: User) throws {
        let student = self.userTable.filter(self.identify == id)
        try self.database.run(student.update(name <- value.name,
                                             birthDay <- value.birthDay,
                                             phoneNumber <- value.phoneNumber,
                                             email <- value.email,
                                             school <- value.school,
                                             address <- value.address,
                                             yearOfAdmission <- value.yearOfAdmission,
                                             yearsOfStudy <- "\(value.yearsOfStudy)",
                                             team <- value.team.id,
                                             imageUrl <- value.imageUrl,
                                             userType <- value.userType.rawValue,
                                             status <- value.status == .authentic ? true : false))
        print("update user successful")
    }
    
    public func select(id: String) -> User? {
        let element = self.userTable.filter(self.identify == id)
        var user: User?
        
        try? self.database.prepare(element).forEach({ (row) in
            
            let team = TeamDataCache.sharedInstance.select(id: row[self.team]) ?? Team(id: row[self.team])
            user = User(name: row[name],
                             birthDay: row[birthDay] ,
                             phoneNumber: row[phoneNumber],
                             email: row[email],
                             identify: row[identify] ,
                             school: row[school],
                             address: row[address],
                             yearOfAdmission: row[yearOfAdmission] ,
                             yearsOfStudy: Float.init(row[yearsOfStudy] ) ?? 0,
                             team: team,
                             imageUrl: row[imageUrl],
                             userType: UserType(rawValue: row[userType]) ?? .member,
                             status: row[status] ? .authentic : .notAuthentic)
        })
        return user
    }
    
    public func count() throws -> Int {
        return try self.database.scalar(self.userTable.count)
    }
}
