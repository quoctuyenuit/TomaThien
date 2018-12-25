//
//  RegistationNotifyDetailInteractor.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/12/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import Firebase

class RegistationNotifyDetailInteractor: RegistationNotifyDetailInteractorProtocol {
    func confirmRegistation(user: User) {
        ServerServices
            .sharedInstance
            .pushData(key: user.key, from: ServerReferncePath.studentList, value: user.toObject()) { (error, datareference) in
                if error == nil {
                    let path = "\(ServerReferncePath.notificationRegister.rawValue)/\(user.key)"
                    Database.database()
                        .reference()
                        .child(path)
                        .removeValue()
                }
        }
    }
}
