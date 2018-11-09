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
    private lazy var camera: QRScannerCamera = {
        let camera = QRScannerCamera()
        return camera
    }()
    
    private func setupView() {
        self.view.backgroundColor = .appBase
        self.view.addSubview(self.camera.view)
        self.navigationItem
            .rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                                                 target: self,
                                                 action: #selector(doneTapped(_:)))]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    @objc private func doneTapped(_ sender: UIBarButtonItem) {
        print("Done")
    }
}
