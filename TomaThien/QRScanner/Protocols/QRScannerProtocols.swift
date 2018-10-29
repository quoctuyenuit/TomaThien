//
//  QRScannerProtocols.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/28/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//
import UIKit

protocol QRScannerViewProtocol {
    var presenter: QRScannerPresenterProtocol? { get set }
}

protocol QRScannerPresenterProtocol {
    var view: QRScannerViewProtocol? { get set }
    var interactor: QRScannerInteractorProtocol? { get set }
    var router: QRScannerRouterProtocol? { get set }
}

protocol QRScannerInteractorProtocol {
    
}

protocol QRScannerRouterProtocol {
    static func createQRScanner() -> UIViewController
}
