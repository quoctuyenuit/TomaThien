//
//  LoginRouter.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/31/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class LoginRouter: LoginRouterProtocol {
    static func createLoginViewController() -> UIViewController {
        let view = LoginViewController()
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        let router = LoginRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        let navigationController = UINavigationController(rootViewController: view)
        
        return navigationController
    }
    
    func showRegisterView(from viewController: UIViewController) {
        let registerView = RegisterRouter.createRegisterViewController()
        viewController.navigationController?.present(registerView, animated: true, completion: nil)
    }
}
