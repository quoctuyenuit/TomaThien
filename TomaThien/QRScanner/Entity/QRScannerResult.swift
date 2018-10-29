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
    
    init(url: String, name: String, identify: String) {
        self.name = name
        self.identify = identify
        self.imageUrl = url
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
        
        self.imageUrl = url
        self.name = name
        self.identify = identify
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(completed: ((UIImage) -> ())?) {
        guard let url = URL(string: imageUrl) else {
            print("Image url not found")
            return
        }
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                guard let image = UIImage(data: data) else { return }
                completed?(image)
            }
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case imageUrl = "image"
        case name = "name"
        case identify = "identify"
    }
}

