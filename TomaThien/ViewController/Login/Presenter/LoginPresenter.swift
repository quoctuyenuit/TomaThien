//
//  LoginPresenter.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/31/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class LoginPresenter: LoginPresenterProtocol {
    
    
    var view: LoginViewProtocol?
    
    var interactor: LoginInteractorProtocol?
    
    var router: LoginRouterProtocol?
    
    func login(userName: String, password: String) {
        self.interactor?.login(userName: userName, password: password, completion: { (result) in
            switch result {
            case .fault(let error):
                self.view?.loginFault(message: error)
            case .success(let userInfor):
                self.view?.loginSuccessful(user: userInfor)
            }
        })
    }
    
    func showRegisterView(from viewController: UIViewController) {
        self.router?.showRegisterView(from: viewController)
    }
}
