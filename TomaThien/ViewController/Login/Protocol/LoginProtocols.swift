//
//  LoginProtocols.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/31/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation

protocol LoginViewProtocol {
    var presenter: LoginPresenterProtocol? { get set }
}

protocol LoginPresenterProtocol {
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorProtocol? { get set }
    var router: LoginRouterProtocol? { get set }
    
    //MARK: View -> Presenter
    func login(userName: String, password: String)
    //MARK: Presenter -> Interactor
}

protocol LoginInteractorProtocol {
    
}

protocol LoginRouterProtocol {
    
}
