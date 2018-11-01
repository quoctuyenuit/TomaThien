//
//  User.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/31/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation

enum UserType: Int {
    case member = 1
    case sublead = 2
    case admin = 3
}

enum UserStatus: Int {
    case authentic = 0
    case notAuthentic = 1
}

class LocalUser: Student {
    var userType: UserType = .member
    var status: UserStatus = .notAuthentic
    
    init(name: String,
                birthDay: Date,
                phoneNumber: String,
                email: String,
                identify: String,
                school: String,
                address: String,
                yearOfAdmission: Int,
                yearsOfStudy: Float,
                team: Int,
                image: String,
                userType: UserType,
                status: UserStatus) {
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
                  image: image)
        self.userType = userType
        self.status = status
    }
}
