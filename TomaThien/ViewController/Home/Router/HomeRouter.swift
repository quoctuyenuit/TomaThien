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
    
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func createHomeViewController() -> UIViewController {
        let view = HomeViewController()
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
    
    func showQRScanner() {
        let scannerViewController = QRScannerRouter.createQRScanner()
        HomeRouter.vc?.present(scannerViewController, animated: false, completion: nil)
    }
    
    func showNotification(from viewController: UIViewController?, listNotification: [NotificationProtocol]) {
        let notificationViewController = NotificationRouter.createNotificationView(listNotification: listNotification)
        viewController?.navigationController?.pushViewController(notificationViewController, animated: true)
    }
}
