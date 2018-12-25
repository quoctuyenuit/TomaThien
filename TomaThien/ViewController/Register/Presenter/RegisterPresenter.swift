//
//  File.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/31/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class RegisterPresenter: RegisterPresenterProtocol {
    var view: RegisterViewProtocol?
    var interactor: RegisterInteractorProtocol?
    var router: RegisterRouterProtocol?
    
    func register(user: User, userImage: UIImage?) {
        self.interactor?.register(user: user, userImage: userImage)
    }
    
    func beginStartRegister() {
        self.view?.showLoadingView()
    }
    
    func registerSuccessful(for user: User) {
        self.view?.hideLoadingView()
        self.view?.registerSuccessful(for: user)
    }
    
    func registerFail() {
        self.view?.hideLoadingView()
        self.view?.registerFail()
    }
}
