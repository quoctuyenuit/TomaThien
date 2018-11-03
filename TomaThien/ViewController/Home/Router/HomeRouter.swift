//
//  HomeRouter.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/3/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter: HomeRouterProtocol {
    private static var vc: UIViewController?
    
    class func createHomeViewController() -> UIViewController {
        let view = HomeViewController()
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        vc = view
        return view
    }
    
    func showQRScanner() {
        let scannerViewController = QRScannerRouter.createQRScanner()
        HomeRouter.vc?.present(scannerViewController, animated: false, completion: nil)
    }
}
