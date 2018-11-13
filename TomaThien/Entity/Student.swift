//
//  Student.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/24/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

public enum UserType: Int {
    case member = 1
    case sublead = 2
    case admin = 3
    
    static var allCases: [UserType] = [
        .member,
        .sublead,
        .admin
    ]
}

public class Student {
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
    
    public var key: String {
        return self.identify.lowercased()
    }
    
    public init(name: String, birthDay: Date,
                phoneNumber: String, email: String,
                identify: String, school: String,
                address: String, yearOfAdmission: Int,
                yearsOfStudy: Float, team: Team,
                imageUrl: String, userType: UserType = .member) {
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
            let userType = UserType(rawValue: userTypeRawValue)
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
            "userType": self.userType.rawValue
        ]
    }
}
