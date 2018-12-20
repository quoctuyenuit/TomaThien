//
//  ProfileCellModel.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/19/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

enum ProfileCellType {
    case header
    case qrCodeView
}

struct ProfileCellModel {
    var icon: UIImage?
    var type: ProfileCellType
    var title: String?
    var subtitle: String?
    
    init(icon: UIImage? = nil, type: ProfileCellType, title: String, subtitle: String) {
        self.type = type
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
    }
    
    init(icon: UIImage? = nil, type: ProfileCellType) {
        self.type = type
        self.icon = icon
        switch type {
        case .header:
            break
        case .qrCodeView:
            self.title = ProfileLocalizeString.qrCodeView
        }
    }
}

struct ProfileLocalizeString {
    static let qrCodeView = "Mã vạch của tôi"
}
