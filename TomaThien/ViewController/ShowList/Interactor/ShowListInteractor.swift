//
//  ShowListInteractor.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/19/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import RxSwift
import Firebase

class ShowListInteractor: ShowListInteractorProtocol {
    func getListMemberInformation(for typeList: TypeList) -> Observable<User> {
        
        return Observable.create { (observer) -> Disposable in
            ServerServices.sharedInstance.pullData(path: ServerReferncePath.studentList) { (listSnapshot) in
                listSnapshot.forEach({ (snapshot) in
                    if let user = User(snapshot: snapshot),
                        typeList.isMatch.contains(user.userType) {
                        observer.onNext(user)
                    }
                })
            }
            return Disposables.create()
        }
        
    }
    
    func getListRegistedMemberInformation() -> Observable<User> {
        
        return Observable.create { (observer) -> Disposable in
            Database.database()
                .reference()
                .child(ServerReferncePath.registationList.rawValue)
                .observe(DataEventType.value) { (dataSnapshot) in
                    for child in dataSnapshot.children {
                        if let snapshot = child as? DataSnapshot {
                            let identify = self.getIdentify(from: snapshot)
                            self.getUserInformation(for: identify, complication: { (user) in
                                observer.onNext(user)
                            })
                        }
                    }
            }
            return Disposables.create()
        }
        
    }
}

//MARK: - private function
extension ShowListInteractor {
    private func getUserInformation(for identify: String, complication: @escaping (User) -> ()) {
        Database.database()
            .reference()
            .child(ServerReferncePath.studentList.rawValue)
            .queryOrdered(byChild: "identify")
            .queryStarting(atValue: identify)
            .queryEnding(atValue: identify)
            .observe(.value) { (dataSnapshot) in
                for child in dataSnapshot.children {
                    if let snapshot = child as? DataSnapshot {
                        //Just get the first data
                        if let user = User(snapshot: snapshot) {
                            complication(user)
                            return
                        }
                    }
                }
        }
    }
    
    private func getIdentify(from dataSnapshot: DataSnapshot) -> String {
        guard
            let value = dataSnapshot.value as? [String: AnyObject],
            let identify = value.first?.key else { return "" }
        return identify
    }
}
