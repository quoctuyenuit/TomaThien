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
    func register(user: LocalUser) {
        self.storeCache(user: user)
        self.pushNotifyData(user: user)
        self.pushUserImage(image: user.image, key: user.key)
    }
    
    private func storeCache(user: LocalUser) {
        do {
            try UserDataCache.sharedInstance.insert(value: user)
        } catch (_) {
            try? UserDataCache.sharedInstance.update(id: user.identify, value: user)
        }
    }
    
    private func pushNotifyData(user: LocalUser) {
        ServerServices.sharedInstance.pushData(key: user.key,
                                               from: ServerReferncePath.notificationRegister,
                                               value: user.toObject()) { (error, reference) in
                                                if let error = error {
                                                    print(error.localizedDescription)
                                                }
        }
    }
    
    private func pushUserImage(image: UIImage?, key: String) {
        guard let image = image else { return }
        ServerServices
            .sharedInstance
            .pushImage(key: key, from: ServerReferncePath.notifyImage, image: image)
            { (error, path) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                ServerServices.sharedInstance.pushData(key: "\(key)/imageUrl",
                    from: ServerReferncePath.notificationRegister,
                    value: path ?? "", completion: { (_, _) in
                        
                })
        }
    }
}
