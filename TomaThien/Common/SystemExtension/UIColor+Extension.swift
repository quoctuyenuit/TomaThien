//
//  UIColor+Extension.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/28/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    public static var appBase: UIColor {
        return UIColor.init(red: 66/255, green: 103/255, blue: 178/255, alpha: 1)
    }
    
    public static var background: UIColor {
        return UIColor.init(red: 244/255, green: 248/255, blue: 251/255, alpha: 1)
    }
    
    public static var placeHoder: UIColor {
        return UIColor.init(red: 241/255, green: 242/255, blue: 244/255, alpha: 1)
    }
    
    public static var notifiTitle: UIColor {
        return .gray
    }
}
