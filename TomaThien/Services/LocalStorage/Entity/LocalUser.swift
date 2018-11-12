//
//  User.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/31/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import Firebase

enum UserStatus: Int {
    case authentic = 0
    case notAuthentic = 1
}

class LocalUser: Student {
    var status: UserStatus = .notAuthentic
    var image: UIImage?
    
    init(
        name: String,
        birthDay: Date,
        phoneNumber: String,
        email: String,
        identify: String,
        school: String,
        address: String,
        yearOfAdmission: Int,
        yearsOfStudy: Float,
        team: Int,
        image: UIImage?,
        userType: UserType,
        status: UserStatus = .notAuthentic) {
        
        super.init(name: name,
                  birthDay: birthDay,
                  phoneNumber: phoneNumber,
                  email: email,
                  identify: identify,
                  school: school,
                  address: address,
                  yearOfAdmission: yearOfAdmission,
                  yearsOfStudy: yearsOfStudy,
                  team: team,
                  imageUrl: "")
        self.userType = userType
        self.status = status
        self.image = image
    }
    
    override init?(snapshot: DataSnapshot) {
        super.init(snapshot: snapshot)
    }
    
    override func toObject() -> Any {
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
            "team": self.team,
            "imageUrl": self.imageUrl,
            "userType": self.userType.rawValue,
            "time": dateFormatted.string(from: Date())
        ]
    }
}
