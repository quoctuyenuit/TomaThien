//
//  QRCodeViewController.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/9/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import PINRemoteImage
import SnapKit

class QRCodeViewController: UIViewController, QRCodeViewProtocol {
    //MARK: - Common Properties
    var presenter: QRCodePresenterProtocol?
    private var userInfo = LoginManager.sharedInstance.user
    //MARK: - view Properties
    private let iconSize: CGFloat = 50
    private let qrSize: CGFloat = 250
    
    private lazy var qrBoundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.pin_setImage(from: URL(string: self.userInfo?.imageUrl ?? ""))
        imageView.layer.cornerRadius = iconSize / 2
        imageView.backgroundColor = .white
        imageView.clearsContextBeforeDrawing = true
        imageView.layer.borderWidth = 2
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var qrImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    //MARK: - Function
    func bindToQRImage(from image: UIImage?) {
        self.qrImage.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        guard let user = self.userInfo else { return }
        self.presenter?.createQRData(from: user)
    }
    
    //MARK: - Function to setupview
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.qrBoundView)
        self.setupQRCode()
        self.qrBoundView.snp.makeConstraints { (make) in
            make.size.equalTo(self.qrSize)
            make.center.equalToSuperview()
        }
    }
    
    private func setupQRCode() {
        self.qrBoundView.addSubview(self.qrImage)
        self.qrBoundView.addSubview(self.icon)
        
        self.qrImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.icon.snp.makeConstraints { (make) in
            make.size.equalTo(self.iconSize)
            make.center.equalToSuperview()
        }
    }
}
