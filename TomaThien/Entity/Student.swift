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

struct Student {
    public var ref: DatabaseReference?
    private var name: String
    private var birthDay: Date
    private var phoneNumber: String
    private var email: String
    private var school: String
    private var address: String
    private var yearOfAdmission: Int
    private var yearsOfStudy: Float
    private var team: Int
    private var identify: String
    
    public var key: String {
        return self.identify.lowercased()
    }
    
    public init(name: String, birthDay: Date, phoneNumber: String, email: String, identify: String, school: String, address: String, yearOfAdmission: Int, yearsOfStudy: Float, team: Int) {
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
            let team = value["team"] as? Int
            else {
                return nil
        }
        
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = "dd/MM/yyyy"
        guard let birthDay = dateFormatted.date(from: birthDayString) else { return nil }
        
        self.init(name: name, birthDay: birthDay, phoneNumber: phoneNumber, email: email, identify: identify,school: school, address: address, yearOfAdmission: yearOfAdmission, yearsOfStudy: yearsOfStudy, team: team)
        
        self.ref = snapshot.ref
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
            "team": self.team,
            "qrCode": ""
        ]
    }
    
    func uploadMedia(completion: @escaping (_ url: String?) -> Void) {
        let storageRef = Storage.storage().reference().child("\(self.key).png")
        if let uploadData = UIImage(named: "qrcode")!.pngData() {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print(error)
                    completion(nil)
                } else {
                    completion(metadata?.path)
                }
            }
        }
    }
}
