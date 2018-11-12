//
//  ViewController.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/24/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import SnapKit
import AlamofireImage
import Alamofire

class ViewController: UIViewController {
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1..<11 {
            try? TeamDataCache.sharedInstance.insert(value: Team(id: i))
        }
    }
}

