//
//  RegisterRouter.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/31/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class RegisterRouter: RegisterRouterProtocol {
    static func createRegisterViewController() -> UIViewController {
        let view: RegisterViewProtocol & UIViewController = RegisterViewController()
        let presenter: RegisterPresenterProtocol = RegisterPresenter()
        let interactor: RegisterInteractorProtocol = RegisterInteractor()
        let router: RegisterRouterProtocol = RegisterRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }
}
