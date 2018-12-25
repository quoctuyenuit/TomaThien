//
//  NotificationEntity.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/11/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import Firebase

enum NotificationTitle: String {
    case registation = "Đăng ký"
}

struct NotificationRegistation: NotificationProtocol {
    var notiId: String
    
    var notiTitle: NotificationTitle = .registation
    
    var notiTime: String
    
    var notiContent: String
    
    var notiIcon: UIImage?
    
    var user: User
    
    init(user: User) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        self.user = user
        self.notiTime = dateFormatter.string(from: Date())
        self.notiContent = "\(user.name) đã gửi yêu cầu đăng ký"
        self.notiId = user.key
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let user = User(snapshot: snapshot),
            let time = value["time"] as? String,
            let notifyId = value["notifyId"] as? String
            else {
                return nil
        }
        
        self.user = user
        self.notiTime = time
        self.notiContent = "\(user.name) đã gửi yêu cầu đăng ký"
        self.notiId = notifyId
    }
    
    func showDetail(from viewController: UIViewController) {
        let detailViewController = RegistationNotifyDetailRouter.createRegistationNotifyDetail(user: self.user)
        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func toObject() -> Any {
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = "dd/MM/yyyy"
        
        return [
            "name": self.user.name,
            "birthDay": dateFormatted.string(from: self.user.birthDay),
            "phoneNumber": self.user.phoneNumber,
            "email": self.user.email,
            "identify": self.user.identify,
            "school": self.user.school,
            "address": self.user.address,
            "yearOfAdmission": self.user.yearOfAdmission,
            "yearsOfStudy": self.user.yearsOfStudy,
            "team": self.user.team.id,
            "imageUrl": self.user.imageUrl,
            "userType": self.user.userType.rawValue,
            "password": self.user.password,
            "time": dateFormatted.string(from: Date()),
            "notifyId": self.user.key
        ]
    }
}
