//
//  TabBarViewController.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/3/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import SnapKit


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

class TabBarViewController: UIViewController {

    private lazy var viewControllers: [UIViewController] = {
        guard let user = LoginManager.sharedInstance.user else { return [] }
        return self.configure(user: user)
    }()
    
    private var tabBarViewController: UITabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        self.setupView()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .appBase
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupView() {
        self.tabBarViewController = UITabBarController()
        self.tabBarViewController.delegate = self
        self.tabBarViewController.viewControllers = self.viewControllers
        self.view.addSubview(self.tabBarViewController.view)
        self.tabBarViewController
            .view
            .snp
            .makeConstraints { make in
                make.edges.equalToSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let testView = UIViewController()
        testView.view.backgroundColor = .green
        self.navigationController?.pushViewController(testView, animated: true)
    }
    
}

extension TabBarViewController: UITabBarControllerDelegate {}

extension TabBarViewController {
    fileprivate func createBarItem(with type: BarType) -> UITabBarItem {
        let image = UIImage(named: type.iconName)
        let item = UITabBarItem(title: type.name, image: image, selectedImage: image?.withRenderingMode(.alwaysOriginal))
        
        item.badgeValue = nil
        item.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -2.0)
        
        item.setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
        item.setTitleTextAttributes([.foregroundColor: UIColor.appBase], for: .selected)
        return item;
    }
    
    func configure(user: User) -> [UIViewController] {
        guard let home =  HomeRouter.createHomeViewController() as? HomeViewController else {
           return []
        }
        
        guard let profile = ProfileRouter.createProfileViewController() as? ProfileViewController else {
            return []
        }
        
        home.parentView = self
        home.tabBarItem = self.createBarItem(with: .home)
        profile.parentView = self
        profile.tabBarItem = self.createBarItem(with: .profile)
        return [home, profile]
    }
}
