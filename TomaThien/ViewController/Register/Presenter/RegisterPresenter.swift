//
//  File.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/31/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation

class RegisterPresenter: RegisterPresenterProtocol {
    var view: RegisterViewProtocol?
    var interactor: RegisterInteractorProtocol?
    var router: RegisterRouterProtocol?
    
    func register(user: LocalUser) {
        self.interactor?.register(user: user)
    }
}
