//
//  User.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/31/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

public enum UserType: Int {
    case member = 1
    case sublead = 2
    case teamLeader = 3
    case admin = 4
    
    static var allCases: [UserType] = [
        .member,
        .sublead,
        .admin,
        .teamLeader
    ]
    
    public var description: String {
        switch self {
        case .member:
            return "Thành viên"
        case .sublead:
            return "Phó ban"
        case .admin:
            return "Trưởng ban"
        case .teamLeader:
            return "Trưởng nhóm"
        }
    }
}

public enum UserStatus: Int {
    case authentic = 0
    case notAuthentic = 1
}

public class User {
    var name: String
    var birthDay: Date
    var phoneNumber: String
    var email: String
    var school: String
    var address: String
    var yearOfAdmission: Int
    var yearsOfStudy: Float
    var team: Team
    var identify: String
    var imageUrl: String //Link download
    var userType: UserType
    var status: UserStatus = .notAuthentic
    var password: String
    
    public var key: String {
        return self.identify.lowercased()
    }
//
//    init() {
//        self.name = "name"
//        self.birthDay = Date()
//        self.phoneNumber = "phoneNumber"
//        self.email = "email"
//        self.identify = "182646466"
//        self.school = "school"
//        self.address = "address"
//        self.yearOfAdmission = 0
//        self.yearsOfStudy = 0
//        self.team = Team(id: 0)
//        self.imageUrl = ""
//        self.userType = .member
//        self.status = .notAuthentic
//        self.password = "admin"
//    }
    
    public init(name: String,
                birthDay: Date,
                phoneNumber: String,
                email: String,
                identify: String,
                school: String,
                address: String,
                yearOfAdmission: Int,
                yearsOfStudy: Float,
                team: Team,
                imageUrl: String,
                userType: UserType = .member,
                status: UserStatus = .notAuthentic,
                password: String) {
        self.name = name
        self.birthDay = birthDay
        self.phoneNumber = phoneNumber
        self.email = email
        self.identify = identify
        self.school = school
        self.address = address
        self.yearOfAdmission = yearOfAdmission
        self.yearsOfStudy = yearsOfStudy
        self.team = team
        self.imageUrl = imageUrl
        self.userType = userType
        self.status = status
        self.password = "admin"
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let birthDayString = value["birthDay"] as? String,
            let phoneNumber = value["phoneNumber"] as? String,
            let email = value["email"] as? String,
            let identify = value["identify"] as? String,
            let school = value["school"] as? String,
            let address = value["address"] as? String,
            let yearOfAdmission = value["yearOfAdmission"] as? Int,
            let yearsOfStudy = value["yearsOfStudy"] as? Float,
            let teamId = value["team"] as? Int,
            let imageUrl = value["imageUrl"] as? String,
            let userTypeRawValue = value["userType"] as? Int,
            let userType = UserType(rawValue: userTypeRawValue),
            let password = value["password"] as? String
            else {
                return nil
        }
        
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = "dd/MM/yyyy"
        guard let birthDay = dateFormatted.date(from: birthDayString) else { return nil }
        
        self.name = name
        self.birthDay = birthDay
        self.phoneNumber = phoneNumber
        self.email = email
        self.identify = identify
        self.school = school
        self.address = address
        self.yearOfAdmission = yearOfAdmission
        self.yearsOfStudy = yearsOfStudy
        self.team = TeamDataCache.sharedInstance.select(id: teamId) ?? Team(id: teamId)
        self.imageUrl = imageUrl
        self.userType = userType
        self.password = password
    }
    
    func toObject() -> Any {
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = "dd/MM/yyyy"
        
        return [
            "name": self.name,
            "birthDay": dateFormatted.string(from: self.birthDay),
            "phoneNumber": self.phoneNumber,
            "email": self.email,
            "identify": self.identify,
            "school": self.school,
            "address": self.address,
            "yearOfAdmission": self.yearOfAdmission,
            "yearsOfStudy": self.yearsOfStudy,
            "team": self.team.id,
            "imageUrl": self.imageUrl,
            "userType": self.userType.rawValue,
            "password": self.password
        ]
    }
}
