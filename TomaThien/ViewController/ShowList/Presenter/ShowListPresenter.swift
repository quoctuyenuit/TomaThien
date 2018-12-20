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
        self.router?.showListOfDetail(from: viewController, for: typeList)
    }
    
    func getListMemberInformation(for typeList: TypeList, callBack: @escaping (User) -> ()) {
        
        if typeList == TypeList.registedMember {
            self.interactor?.getListRegistedMemberInformation()
                .asObservable()
                .subscribe(onNext: { user in
                    callBack(user)
                })
                .disposed(by: self.disposeBag)
        } else {
            self.interactor?.getListMemberInformation(for: typeList)
                .asObservable()
                .subscribe(onNext: { user in
                    callBack(user)
                })
                .disposed(by: self.disposeBag)
        }
    }
}
