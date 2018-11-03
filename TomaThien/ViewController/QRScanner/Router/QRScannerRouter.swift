//
//  QRScannerRouter.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/28/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit

class QRScannerRouter: QRScannerRouterProtocol {
    class func createQRScanner() -> UIViewController {
        var view: QRScannerViewProtocol & UIViewController = QRScannerViewController()
        var presenter: QRScannerPresenterProtocol = QRScannerPresenter()
        let interactor: QRScannerInteractorProtocol = QRScannerInteractor()
        let router: QRScannerRouterProtocol = QRScannerRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
}
