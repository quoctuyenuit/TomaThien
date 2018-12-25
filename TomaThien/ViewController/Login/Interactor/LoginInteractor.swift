//
//  LoginInteractor.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/31/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation

class LoginInteractor: LoginInteractorProtocol {
    private let _cacheInstance = UserDataCache.sharedInstance
    private let _serverInstance = ServerServices.sharedInstance
    
    func login(userName: String, password: String, completion: @escaping (LoginResult) -> ()) {
        if let user = self.checkCache(userName: userName, password: password) {
            completion(LoginResult.success(userInfor: user))
        }
        
        self.checkOnline(userName: userName, password: password) { (checkedUser) in
            if let user = checkedUser {
                completion(LoginResult.success(userInfor: user))
            } else {
                completion(LoginResult.fault(error: "Tên đăng nhập hoặc mật khẩu không tồn tại"))
            }
        }
    }
}

//MARK: - private functionality
extension LoginInteractor {
    private func checkCache(userName: String, password: String) -> User? {
        guard let user = self._cacheInstance.select(id: userName) else {
            return nil
        }
        
        return user.password == password ? user : nil
    }
    
    private func checkOnline(userName: String, password: String, completion: @escaping (User?) -> ()) {
        self._serverInstance.pullData(path: ServerReferncePath.studentList) { (listSnapshot) in
            listSnapshot.forEach {
                if let user = User(snapshot: $0), user.identify == userName, user.password == password {
                    completion(user)
                }
            }
            completion(nil)
        }
    }
}
