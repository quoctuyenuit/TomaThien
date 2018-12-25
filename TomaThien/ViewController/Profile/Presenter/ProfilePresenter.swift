//
//  ProfilePresenter.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/18/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import PINRemoteImage

class ProfilePresenter: ProfilePresenterProtocol {
    var view: ProfileViewProtocol?
    var interactor: ProfileInteractorProtocol?
    var router: ProfileRouterProtocol?
    
    func showQRCodeView(from viewController: UIViewController?) {
        self.router?.showQRCodeView(from: viewController)
    }
    
    func getNumberOfRows() -> Int {
        return 2
    }
    
    func getListItems() -> [ProfileCellModel] {
        let user = LoginManager.sharedInstance.user
        let userName = user?.name ?? "Unknown"
        let userTypeString = String(describing: user?.userType ?? .member)
        let image = UIImageView()
        image.pin_setImage(from: URL(string: user?.imageUrl ?? ""))
        return [
            ProfileCellModel(icon: image.image,type: .header, title: userName, subtitle: userTypeString),
            ProfileCellModel(icon: UIImage(named: "ico_qrView"),type: .qrCodeView)
        ]
    }
}
