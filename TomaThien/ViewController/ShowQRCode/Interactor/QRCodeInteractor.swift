//
//  QRCodeInteractor.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/9/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation

class QRCodeInteractor: QRCodeInteractorProtocol {
    func createQRData(from userInfo: User, completion: @escaping (Data) -> ()) {
        let id = userInfo.identify
        let name = userInfo.name
        let team = userInfo.team.id
        let imageUrl = userInfo.imageUrl
        
        let dictionary: NSDictionary = [
            "identify": id,
            "name": name,
            "team": team,
            "imageUrl": imageUrl
        ]
        
        if let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) {
            completion(data)
        } else {
            print("Cannot generate QRCode")
        }
    }
}
