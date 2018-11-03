//
//  UIAppDelegate+Extension.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/3/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

fileprivate enum BarType {
    case home
    case profile
    var name: String {
        switch self {
        case .home:
            return "Trang chủ"
        case .profile:
            return "Cá nhân"
        }
    }
    var iconName: String {
        switch self {
        case .home:
            return "ico_bar_home"
        case .profile:
            return "ico_bar_profile"
        }
    }
}

extension UIAppDelegate {
    public func showMainViewController(user: LocalUser) {
        let tabBarViewController = TabBarViewController(subViews: self.configure(user: user))
        self.window?.rootViewController = tabBarViewController
    }
    
    fileprivate func createBarItem(with type: BarType) -> UITabBarItem {
        let image = UIImage(named: type.iconName)
        let item = UITabBarItem(title: type.name, image: image, selectedImage: image?.withRenderingMode(.alwaysOriginal))
        
        item.badgeValue = nil
        item.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -2.0)
        
        item.setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
        item.setTitleTextAttributes([.foregroundColor: UIColor.appBase], for: .selected)
        return item;
    }
    
    fileprivate func createNavi(vc: UIViewController) -> UINavigationController {
        let navi = UINavigationController.init(navigationBarClass: CustomNavigationBar.self, toolbarClass: nil)
        navi.viewControllers = [vc]
        navi.defaultNavigationBarStyle()
        return navi
    }
    
    func configure(user: LocalUser) -> [UIViewController] {
        let home = self.createNavi(vc: HomeRouter.createHomeViewController())
        home.tabBarItem = self.createBarItem(with: .home)
        
        let profile = self.createNavi(vc: UIViewController())
        profile.tabBarItem = self.createBarItem(with: .profile)
        
        return [home, profile]
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
