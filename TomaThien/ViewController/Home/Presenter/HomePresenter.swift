//
//  HomePresenter.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/3/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class HomePresenter: HomePresenterProtocol {
    var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    private let _disposeBag = DisposeBag()
    
    func showQRScanner() {
        self.router?.showQRScanner()
    }
    
    func showNotification(from viewController: UIViewController?, listNotification: [NotificationProtocol]) {
        self.router?.showNotification(from: viewController, listNotification: listNotification)
    }
    
    func getNotification(completion: @escaping (NotificationProtocol) -> ()) {
        self.interactor?.getNotification()
            .asObservable()
            .subscribe(onNext: {
                completion($0)
            })
            .disposed(by: self._disposeBag)
    }
}
