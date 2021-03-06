//
//  HomeProtocols.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/3/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol HomeViewProtocol {
    
    var presenter: HomePresenterProtocol? { get set }
}
protocol HomePresenterProtocol {
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    //View -> Presenter
    func showQRScanner()
    func showNotification(from viewController: UIViewController?, listNotification: [NotificationProtocol])
    func getNotification(completion: @escaping (NotificationProtocol) -> ())
}
protocol HomeInteractorProtocol {
    func getNotification() -> Observable<NotificationProtocol>
}
protocol HomeRouterProtocol {
    static func mainStoryboard() -> UIStoryboard
    static func createHomeViewController() -> UIViewController
    func showQRScanner()
    func showNotification(from viewController: UIViewController?, listNotification: [NotificationProtocol])
}
