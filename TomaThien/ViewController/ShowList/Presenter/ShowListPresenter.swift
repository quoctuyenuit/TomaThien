//
//  ShowListPresenter.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/19/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ShowListPresenter: ShowListPresenterProtocol {
    var view: ShowListViewProtocol?
    var interactor: ShowListInteractorProtocol?
    var router: ShowListRouterProtocol?
    
    private let disposeBag = DisposeBag()
    
    func showUserInformationDetail(from viewController: UIViewController, for user: User) {
        self.router?.showUserInformationDetail(from: viewController, for: user)
    }
    
    func showListOfDetail(from viewController: UIViewController, for typeList: TypeList) {
        
        switch typeList {
        case .allMember:
            self.router?.showListAllMember(from: viewController)
        case .registedMember:
            self.router?.showListRegistedList(from: viewController)
        default:
            self.router?.showListOfDetail(from: viewController, for: typeList)
        }
        
    }
    
    func getListMemberInformation(for typeList: TypeList, callBack: @escaping (User) -> ()) {
        
        self.interactor?.getListMemberInformation(for: typeList)
            .asObservable()
            .subscribe(onNext: { user in
                callBack(user)
            })
            .disposed(by: self.disposeBag)
    }
    
    func getListRegistedMember(for date: String, callBack: @escaping (User) -> ()) {
        self.interactor?.getListRegistedMemberInformation(for: date)
            .asObservable()
            .subscribe(onNext: { user in
                callBack(user)
            })
            .disposed(by: self.disposeBag)
    }
    
    func getListAllMemberByTeam(teamId: Int, callBack: @escaping (User) -> ()) {
        self.interactor?.getListAllMemberByTeam(teamId: teamId)
            .asObservable()
            .subscribe(onNext: { user in
                callBack(user)
            })
            .disposed(by: self.disposeBag)
    }
}
