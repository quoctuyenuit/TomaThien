//
//  HomeInteractor.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/3/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import RxSwift
import Firebase

class HomeInteractor: HomeInteractorProtocol {
    func getNotification() -> Observable<NotificationProtocol> {
        return Observable.create({ (observer) -> Disposable in
            
            ServerServices
                .sharedInstance
                .pullData(path: ServerReferncePath.notificationRegister,
                          completion: { (listSnapshot) in
                            listSnapshot.forEach({ (snapshot) in
                                if let notify = NotificationRegistation(snapshot: snapshot) {
                                    observer.onNext(notify)
                                }
                            })
                })
            
            return Disposables.create()
        })
    }
}
