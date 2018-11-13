//
//  QRCodePresenter.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/9/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class QRCodePresenter: QRCodePresenterProtocol {
    var view: QRCodeViewProtocol?
    
    var interactor: QRCodeInteractorProtocol?
    
    var router: QRCodeRouterProtocol?
    
    func createQRData(from userInfo: User) {
        self.interactor?.createQRData(from: userInfo, completion: { (data) in
            let string = String(data: data, encoding: String.Encoding.utf8)
            guard let qrData = string?.data(using: String.Encoding.utf8) else {
                print("Show QRCode: Could not cast string to data")
                return
            }
            self.view?.bindToQRImage(from: UIImage.createQRImage(data: qrData))
        })
    }
}
