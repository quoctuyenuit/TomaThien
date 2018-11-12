//
//  RegistationNotifyDetailProtocols.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/11/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

protocol RegistationNotifyDetailViewProtocol {
    var presenter: RegistationNotifyDetailPresenterProtocol? { get set }
}
protocol RegistationNotifyDetailPresenterProtocol {
    var view: RegistationNotifyDetailViewProtocol? { get set }
    var interactor: RegistationNotifyDetailInteractorProtocol? { get set }
    var router: RegistationNotifyDetailRouterProtocol? { get set }
    
    //MARK: - View -> Presenter
    func showUserTypeList(from viewController: UIViewController, currentUserType: UserType)
    func showTeamList(from viewController: UIViewController, currentTeam: Team)
    func confirmRegistation(user: LocalUser)
}
protocol RegistationNotifyDetailInteractorProtocol {
    func confirmRegistation(user: LocalUser)
}
protocol RegistationNotifyDetailRouterProtocol {
    static func createRegistationNotifyDetail(user: LocalUser) -> UIViewController
    func showUserTypeList(from viewController: UIViewController, currentUserType: UserType)
    func showTeamList(from viewController: UIViewController, currentTeam: Team)
}
