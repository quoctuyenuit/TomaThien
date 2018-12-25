//
//  RegisterProtocols.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/31/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

protocol RegisterViewProtocol: class {
    var presenter: RegisterPresenterProtocol? { get set }
    func showLoadingView()
    func hideLoadingView()
    func registerSuccessful(for user: User)
    func registerFail()
}

protocol RegisterPresenterProtocol: class {
    var view: RegisterViewProtocol? { get set }
    var interactor: RegisterInteractorProtocol? { get set }
    var router: RegisterRouterProtocol? { get set }
    
    //View -> Presenter
    func register(user: User, userImage: UIImage?)
    func beginStartRegister()
    func registerSuccessful(for user: User)
    func registerFail()
}

protocol RegisterInteractorProtocol: class {
    var presenter: RegisterPresenterProtocol? { get set }
    func register(user: User, userImage: UIImage?)
}

protocol RegisterRouterProtocol: class {
    static func createRegisterViewController() -> UIViewController
}
