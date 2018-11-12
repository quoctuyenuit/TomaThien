//
//  NotificationPresenter.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/11/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class NotificationPresenter: NotificationPresenterProtocol {
    var view: NotificationViewProtocol?
    var interactor: NotificationInteractorProtocol?
    var router: NotificationRouterProtocol?
    
    func showDetail(notification: NotificationProtocol) {
        
    }
}
