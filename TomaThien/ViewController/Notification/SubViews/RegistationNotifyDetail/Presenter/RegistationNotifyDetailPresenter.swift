//
//  RegistaionNotifyDetailPresenter.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/12/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class RegistationNotifyDetailPresenter: RegistationNotifyDetailPresenterProtocol {
    var view: RegistationNotifyDetailViewProtocol?
    var interactor: RegistationNotifyDetailInteractorProtocol?
    var router: RegistationNotifyDetailRouterProtocol?
    
    func confirmRegistation(user: User) {
        self.interactor?.confirmRegistation(user: user)
    }
    
    func showUserTypeList(from viewController: UIViewController, currentUserType: UserType) {
        self.router?.showUserTypeList(from: viewController, currentUserType: currentUserType)
    }
    
    func showTeamList(from viewController: UIViewController, currentTeam: Team) {
        self.router?.showTeamList(from: viewController, currentTeam: currentTeam)
    }
    
    
}
