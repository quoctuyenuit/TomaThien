//
//  ShowListRouter.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/19/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class ShowListRouter: ShowListRouterProtocol {
    static func createShowListViewController() -> UIViewController {
        let view = ShowListViewController()
        let presenter = ShowListPresenter()
        let interactor = ShowListInteractor()
        let router = ShowListRouter()
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        
        return view
    }
    
    func createShowListDetailViewController(for typeList: TypeList) -> UIViewController {
        let view = ShowListDetailViewController(for: typeList)
        let presenter = ShowListPresenter()
        let interactor = ShowListInteractor()
        let router = ShowListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
    
    func createShowRegistedListViewController() -> UIViewController {
        let view = ShowListRegistedViewController(for: .registedMember)
        let presenter = ShowListPresenter()
        let interactor = ShowListInteractor()
        let router = ShowListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
    
    func createShowAllMemberListViewController() -> UIViewController {
        let view = ShowListAllMemberViewController(for: .allMember)
        let presenter = ShowListPresenter()
        let interactor = ShowListInteractor()
        let router = ShowListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
    
    
    func showUserInformationDetail(from viewController: UIViewController?, for user: User) {
        
    }
    
    func showListRegistedList(from viewController: UIViewController?) {
        let view = self.createShowRegistedListViewController()
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func showListAllMember(from viewController: UIViewController?) {
        let view = self.createShowAllMemberListViewController()
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func showListOfDetail(from viewController: UIViewController?, for typeList: TypeList) {
        let detailView = self.createShowListDetailViewController(for: typeList)
        viewController?.navigationController?.pushViewController(detailView, animated: true)
    }
}
