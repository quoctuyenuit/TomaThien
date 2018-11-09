//
//  ShowQRCodeProtocols.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/9/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

protocol QRCodeViewProtocol {
    var presenter: QRCodePresenterProtocol? { get set }
    func bindToQRImage(from image: UIImage?)
}
protocol QRCodePresenterProtocol {
    var view: QRCodeViewProtocol? { get set }
    var interactor: QRCodeInteractorProtocol? { get set }
    var router: QRCodeRouterProtocol? { get set }
    
    func createQRData(from userInfo: LocalUser)
}
protocol QRCodeInteractorProtocol {
    func createQRData(from userInfo: LocalUser, completion: @escaping (Data) -> ())
}
protocol QRCodeRouterProtocol {
    static func createQRCodeViewController() -> UIViewController
}

