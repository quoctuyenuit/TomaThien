//
//  RegistationNotifyDetailRouter.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/11/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class RegistationNotifyDetailRouter: RegistationNotifyDetailRouterProtocol {
    class func createRegistationNotifyDetail(user: LocalUser) -> UIViewController {
        
        let view = RegistationNotifyDetailViewController(user: user)
        let presenter = RegistationNotifyDetailPresenter()
        let interactor = RegistationNotifyDetailInteractor()
        let router = RegistationNotifyDetailRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
    
    func showUserTypeList(from viewController: UIViewController, currentUserType: UserType) {
        let userTypeList = UserTypeListViewController(currentType: currentUserType)
        userTypeList.delegate = viewController as? UserTypeListDelegate
        viewController.navigationController?.pushViewController(userTypeList, animated: true)
    }
    
    func showTeamList(from viewController: UIViewController, currentTeam: Team) {
        let teamList = TeamListViewController(currentTeam: currentTeam)
        teamList.delegate = viewController as? TeamListDelegate
        viewController.navigationController?.pushViewController(teamList, animated: true)
    }
}
