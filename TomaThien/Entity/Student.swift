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

public class Student {
    public var ref: DatabaseReference?
    var name: String
    var birthDay: Date
    var phoneNumber: String
    var email: String
    var school: String
    var address: String
    var yearOfAdmission: Int
    var yearsOfStudy: Float
    var team: Int
    var identify: String
    var image: String
    
    public var key: String {
        return self.identify.lowercased()
    }
    
    public init(name: String, birthDay: Date, phoneNumber: String, email: String, identify: String, school: String, address: String, yearOfAdmission: Int, yearsOfStudy: Float, team: Int, image: String) {
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
        self.image = image
    }
    
    public init(name: String, birthDay: Date, phoneNumber: String, email: String, identify: String, school: String, address: String, yearOfAdmission: Int, yearsOfStudy: Float, team: Int, image: UIImage) {
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
        self.image = image.jpegData(compressionQuality: 0)?.base64EncodedString(options: .lineLength64Characters) ?? ""
    }
    
    
    convenience init?(snapshot: DataSnapshot) {
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
            let team = value["team"] as? Int,
            let image = value["image"] as? String
            else {
                return nil
        }
        
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = "dd/MM/yyyy"
        guard let birthDay = dateFormatted.date(from: birthDayString) else { return nil }
        
        self.init(name: name,
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
            "image": self.image
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
