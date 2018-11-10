//
//  UIResponder+Extension.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/10/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

public extension UIResponder {
    
    private struct Static {
        static weak var responder: UIResponder?
    }
    
    public static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    
    @objc private func _trap() {
        Static.responder = self
    }
}
