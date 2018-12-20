//
//  ProfileRouter.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/18/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class ProfileRouter: ProfileRouterProtocol {
    class func createProfileViewController() -> UIViewController {
        let view = ProfileViewController()
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor()
        let router = ProfileRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
    
    func showQRCodeView(from viewController: UIViewController?) {
        let qrCodeView = QRCodeRouter.createQRCodeViewController()
        viewController?.navigationController?.pushViewController(qrCodeView, animated: true)
    }
}
