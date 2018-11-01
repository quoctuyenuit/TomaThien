//
//  UIFont+Extension.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/28/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    public class func sfuiMedium(size: CGFloat = 16) -> UIFont {
        return UIFont.init(name: "SFUIText-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
