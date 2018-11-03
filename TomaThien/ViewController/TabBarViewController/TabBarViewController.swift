//
//  TabBarViewController.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/3/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController, HomeViewProtocol {
    var presenter: HomePresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    convenience init(subViews: [UIViewController]) {
        self.init(nibName: nil, bundle: nil)
        self.viewControllers = subViews
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TabBarViewController: UITabBarControllerDelegate {}
