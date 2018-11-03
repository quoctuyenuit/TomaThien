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
    var image: String
    var name: String
    var identify: String
    
    init(image: String, name: String, identify: String) {
        self.name = name
        self.identify = identify
        self.image = image
    }
    
    init?(jsonString: String) {
        guard let data = jsonString.data(using: String.Encoding.utf8),
            let json = try? JSONSerialization.jsonObject(with: data, options: []),
            let dictionay = json as? [String: String],
            let url = dictionay["image"],
            let name = dictionay["name"],
            let identify = dictionay["identify"]
        else {
            return nil
        }
        
        self.image = url
        self.name = name
        self.identify = identify
    }
    
    private enum CodingKeys: String, CodingKey {
        case image = "image"
        case name = "name"
        case identify = "identify"
    }
}

