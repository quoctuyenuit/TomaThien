//
//  QRScannerResult.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/29/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class QRScannerResult: Codable {
    var imageUrl: String
    var name: String
    var identify: String
    var team: Int
    
    init(imageUrl: String, name: String, identify: String, team: Int) {
        self.name = name
        self.identify = identify
        self.imageUrl = imageUrl
        self.team = team
    }
    
    init?(jsonString: String) {
        guard let data = jsonString.data(using: String.Encoding.utf8),
            let json = try? JSONSerialization.jsonObject(with: data, options: []),
            let dictionay = json as? [String: Any],
            let imageUrl = dictionay["imageUrl"] as? String,
            let name = dictionay["name"] as? String,
            let identify = dictionay["identify"] as? String,
            let team = dictionay["team"] as? Int
        else {
            return nil
        }
        
        self.imageUrl = imageUrl
        self.name = name
        self.identify = identify
        self.team = team
    }
    
    private enum CodingKeys: String, CodingKey {
        case identify = "identify"
        case name = "name"
        case team = "team"
        case imageUrl = "imageUrl"
    }
}

