//
//  HomePresenter.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/3/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class HomePresenter: HomePresenterProtocol {
    var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    
    func showQRScanner() {
        self.router?.showQRScanner()
    }
    
    func showNotification(from viewController: UIViewController?, listNotification: [NotificationProtocol]) {
        self.router?.showNotification(from: viewController, listNotification: listNotification)
    }
}
