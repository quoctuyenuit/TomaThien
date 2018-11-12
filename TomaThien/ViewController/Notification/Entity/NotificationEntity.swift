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
    var notiTitle: NotificationTitle = .registation
    
    var notiTime: String
    
    var notiContent: String
    
    var notiIcon: UIImage?
    
    var user: LocalUser
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let user = LocalUser(snapshot: snapshot),
            let time = value["time"] as? String
            else {
                return nil
        }
        
        self.user = user
        self.notiTime = time
        self.notiContent = "\(user.name) đã gửi yêu cầu đăng ký"
    }
    
    func showDetail(from viewController: UIViewController) {
        let detailViewController = RegistationNotifyDetailRouter.createRegistationNotifyDetail(user: self.user)
        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
