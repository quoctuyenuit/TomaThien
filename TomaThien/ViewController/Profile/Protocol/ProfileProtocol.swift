//
//  ProfileProtocol.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/18/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileViewProtocol {
    var presenter: ProfilePresenterProtocol? { get set }
}
protocol ProfilePresenterProtocol {
    var view: ProfileViewProtocol? { get set }
    var interactor: ProfileInteractorProtocol? { get set }
    var router: ProfileRouterProtocol? { get set }
    
    func showQRCodeView(from viewController: UIViewController?)
    func getNumberOfRows() -> Int
    func getListItems() -> [ProfileCellModel]
}
protocol ProfileInteractorProtocol {
    
}
protocol ProfileRouterProtocol {
    static func createProfileViewController() -> UIViewController
    func showQRCodeView(from viewController: UIViewController?)
}

