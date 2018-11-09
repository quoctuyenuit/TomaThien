//
//  QRCodeRouter.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/9/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class QRCodeRouter: QRCodeRouterProtocol {
    class func createQRCodeViewController() -> UIViewController {
        let view = QRCodeViewController()
        let presenter = QRCodePresenter()
        let interactor = QRCodeInteractor()
        let router = QRCodeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        return view
    }
}
