//
//  RegisterProtocols.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/31/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

protocol RegisterViewProtocol {
    var presenter: RegisterPresenterProtocol? { get set }
}

protocol RegisterPresenterProtocol {
    var view: RegisterViewProtocol? { get set }
    var interactor: RegisterInteractorProtocol? { get set }
    var router: RegisterRouterProtocol? { get set }
    
    //View -> Presenter
    func register(user: LocalUser)
}

protocol RegisterInteractorProtocol {
    func register(user: LocalUser)
}

protocol RegisterRouterProtocol {
    static func createRegisterViewController() -> UIViewController
}
