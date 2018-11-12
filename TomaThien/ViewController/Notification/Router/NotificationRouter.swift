//
//  NotificationRouter.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/11/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class NotificationRouter: NotificationRouterProtocol {
    class func createNotificationView(listNotification: [NotificationProtocol]) -> UIViewController {
        let view = NotificationViewController(notifications: listNotification)
        let presenter = NotificationPresenter()
        let interactor = NotificationInteractor()
        let router = NotificationRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
    
    func showDetail(notification: NotificationProtocol) {
        
    }
}
