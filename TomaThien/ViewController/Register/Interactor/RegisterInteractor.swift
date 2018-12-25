//
//  RegisterInteractor.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/31/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class RegisterInteractor: RegisterInteractorProtocol {
    var presenter: RegisterPresenterProtocol?
    
    func register(user: User, userImage: UIImage?) {
        
        self.presenter?.beginStartRegister()
        
        self.storeCache(user: user)
        self.pushNotifyData(user: user)
        self.pushUserImage(user: user, image: userImage)
    }
    
    private func storeCache(user: User) {
        do {
            try UserDataCache.sharedInstance.insert(value: user)
        } catch (_) {
            try? UserDataCache.sharedInstance.update(id: user.identify, value: user)
        }
    }
    
    private func pushNotifyData(user: User) {
        let notify = NotificationRegistation(user: user)
        ServerServices.sharedInstance.pushData(key: user.key,
                                               from: ServerReferncePath.notificationRegister,
                                               value: notify.toObject()) { (error, reference) in
                                                if let error = error {
                                                    print(error.localizedDescription)
                                                    return
                                                }
        }
    }
    
    private func pushUserImage(user: User, image: UIImage?) {
        guard let image = image else {
            self.presenter?.registerSuccessful(for: user)
            return
        }
        ServerServices
            .sharedInstance
            .pushImage(key: user.key, from: ServerReferncePath.notifyImage, image: image)
            { (error, path) in
                if let error = error {
                    self.presenter?.registerFail()
                    print(error.localizedDescription)
                    return
                }
                
                ServerServices.sharedInstance.pushData(key: "\(user.key)/imageUrl",
                    from: ServerReferncePath.notificationRegister,
                    value: path ?? "", completion: { (_, _) in
                        self.presenter?.registerSuccessful(for: user)
                })
        }
    }
}
