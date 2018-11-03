//
//  UIAppDelegate.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/3/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class UIAppDelegate: DelegateBaseProtocol {
    var window: UIWindow? {
        let appdelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        return appdelegate?.window
    }
    
    static let shareInstance = UIAppDelegate()
    
    
}
