//
//  NotificationProtocols.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/11/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

protocol NotificationProtocol {
    var notiTitle: NotificationTitle { get set }
    var notiTime: String { get set }
    var notiContent: String { get set }
    var notiIcon: UIImage? { get set }
    func showDetail(from viewController: UIViewController) 
}

protocol NotificationViewProtocol {
    var presenter: NotificationPresenterProtocol? { get set }
}
protocol NotificationPresenterProtocol {
    var view: NotificationViewProtocol? { get set }
    var interactor: NotificationInteractorProtocol? { get set }
    var router: NotificationRouterProtocol? { get set }
    
    //MARK: - View -> Presenter
    func showDetail(notification: NotificationProtocol)
}
protocol NotificationInteractorProtocol {
    
}
protocol NotificationRouterProtocol {
    static func createNotificationView(listNotification: [NotificationProtocol]) -> UIViewController
    func showDetail(notification: NotificationProtocol)
}
