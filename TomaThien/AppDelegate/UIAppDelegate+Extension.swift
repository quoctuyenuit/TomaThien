//
//  UIAppDelegate+Extension.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/3/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit


extension UIAppDelegate {
    public func showMainViewController() {
        let tabviewController = TabBarViewController()
        let navigationController = UINavigationController(rootViewController: tabviewController)
        self.window?.rootViewController = navigationController
    }
}

class CustomNavigationBar: UINavigationBar {
    override func layoutSubviews() {
        super.layoutSubviews();
        if #available(iOS 11, *){
            self.layoutMargins = UIEdgeInsets()
            for subview in self.subviews {
                if String(describing: subview.classForCoder).contains("ContentView") {
                    let oldEdges = subview.layoutMargins
                    subview.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: oldEdges.right)
                }
            }
        }
    }
}

extension UINavigationController {
    @objc func clearColorNavigationBarStyle() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        view.backgroundColor = UIColor.clear
        navigationBar.backgroundColor = UIColor.clear
        isNavigationBarHidden = false
    }
    
    @objc func defaultNavigationBarStyle() {
        navigationBar.setBackgroundImage(nil, for: .default)
        navigationBar.barTintColor = UIColor.appBase
        navigationBar.tintColor = UIColor.white
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.sfuiMedium(size: 18)]
    }
    @objc class func defaltAppearanceStyle() {
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor.appBase
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        UINavigationBar.appearance().tintColor = UIColor.white
    }
}
