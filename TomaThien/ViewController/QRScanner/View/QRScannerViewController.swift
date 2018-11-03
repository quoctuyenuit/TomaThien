//
//  QRScannerViewController.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/3/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class QRScannerViewController: UIViewController, QRScannerViewProtocol {
    var presenter: QRScannerPresenterProtocol?
    private let headerHeight: CGFloat = 40
    private lazy var navigationHeader: UIView = {
        let bound = UIView()
        bound.backgroundColor = .appBase
        return bound
    }()
    private lazy var backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "ico_back"), for: .normal)
        btn.backgroundColor = .appBase
        return btn
    }()
    private lazy var camera: QRScannerCamera = {
        let camera = QRScannerCamera()
        return camera
    }()
    
    private func setupView() {
        self.view.backgroundColor = .appBase
        self.view.addSubview(self.navigationHeader)
        self.view.addSubview(self.camera.view)
        self.navigationHeader.addSubview(self.backButton)
        
        self.backButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(8)
            make.width.equalTo(40)
        }
        
        self.navigationHeader.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(self.headerHeight)
        }
        
        self.camera.view.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.navigationHeader.snp.bottom)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
}
