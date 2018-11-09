//
//  File.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/3/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

enum HomeCellIdentify {
    case qrCodeScanner
    case qrCodeView
    case showList
    case report
    case sendServer
    case checkRegister
}

struct HomeCellModel {
    var identify: HomeCellIdentify
    var image: UIImage?
    var title: String
}
