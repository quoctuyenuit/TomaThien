//
//  QRScannerResultPopupView.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/28/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

protocol QRScannerResultPopupViewDelegate {
    func didDismiss()
    func didConfirm(result: (id: String, name: String))
}

class QRScannerResultPopupView: UIViewController {
    private let imageViewWidth = 100
    private var tapGesture: UITapGestureRecognizer!
    private final let closeDurationAnimation: TimeInterval = 0.3
    var delegate: QRScannerResultPopupViewDelegate?
    fileprivate var scannerResult: QRScannerResult?
    
    //MARK: - View Properties
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var maskView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private lazy var contentView: UIView = {
        let bound = UIView(frame: .zero)
        return bound
    }()
    
    private lazy var boundTitle: UIView = {
        let bound = UIView(frame: .zero)
        return bound
    }()
    
    private lazy var boundInfo: UIView = {
        let bound = UIView(frame: .zero)
        return bound
    }()
    
    private lazy var nameTitle: UILabel = {
        let title = UILabel()
        title.text = "Họ tên:"
        title.font = UIFont.sfuiMedium()
        title.textAlignment = .right
        return title
    }()
    
    private lazy var identifyTitle: UILabel = {
        let title = UILabel()
        title.text = "CMND:"
        title.font = UIFont.sfuiMedium()
        title.textAlignment = .right
        return title
    }()
    
    private lazy var nameLabel: UILabel = {
        let title = UILabel()
        title.text = self.scannerResult?.name ?? "Unknown"
        title.font = UIFont.sfuiMedium()
        title.textAlignment = .left
        return title
    }()
    
    private lazy var identifyLabel: UILabel = {
        let title = UILabel()
        title.text = self.scannerResult?.identify ?? "Unknown"
        title.font = UIFont.sfuiMedium()
        title.textAlignment = .left
        return title
    }()
    
    private lazy var confirmButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("OK", for: .normal)
        btn.backgroundColor = UIColor.appBase
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(confirmTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - Setup View functions
    private func setupView() {
        self.view.addSubview(self.maskView)
        self.view.addSubview(self.mainView)
        self.mainView.addSubview(self.imageView)
        self.mainView.addSubview(self.contentView)
        self.mainView.addSubview(self.confirmButton)
        
        self.boundTitle.addSubview(self.nameTitle)
        self.boundTitle.addSubview(self.identifyTitle)
        self.boundInfo.addSubview(self.nameLabel)
        self.boundInfo.addSubview(self.identifyLabel)
        self.contentView.addSubview(self.boundTitle)
        self.contentView.addSubview(self.boundInfo)
        
        self.imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.imageViewWidth)
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        self.nameTitle.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(20)
        }
        self.identifyTitle.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(self.nameTitle.snp.bottom).offset(6)
        }
        
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(20)
        }
        self.identifyLabel.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(self.nameTitle.snp.bottom).offset(6)
        }
        
        self.boundTitle.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.greaterThanOrEqualTo(50)
        }
        
        self.boundInfo.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(self.boundTitle.snp.right).offset(12)
            make.right.equalToSuperview().priority(.medium)
        }
        
        self.contentView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom).offset(20)
        }
        
        self.confirmButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(54)
            make.bottom.equalToSuperview().offset(-12).priority(.medium)
        }
        
        self.mainView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
        }
        
        self.maskView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(self.mainView.snp.top)
        }
    }
    
    @objc private func cancelBtnTapped(_ sender: UIButton) {
        self.dismissView()
    }
    
    @objc
    private func dismissView(animated: Bool = true) {
        if !animated {
            self.delegate?.didDismiss()
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        UIView.animateKeyframes(withDuration: self.closeDurationAnimation, delay: 0, options: [.calculationModeLinear], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) {
                self.mainView.transform = CGAffineTransform(translationX: 0, y: self.mainView.frame.height)
            }
        }) { (_) in
            self.delegate?.didDismiss()
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    //MARK: - Init
    convenience init(json: String) {
        self.init()
        self.scannerResult = QRScannerResult(jsonString: json)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(white: 0.0, alpha: 0.5)
        self.setupView()
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(cancelBtnTapped(_:)))
        self.maskView.addGestureRecognizer(self.tapGesture)
        guard let urlString = self.scannerResult?.identify else { return }
//        ServerServices.sharedInstance.downloadImage(key: urlString) { (image) in
//            self.imageView.image = image
//        }
    }
    
    //MARK: - Functions
    @objc private func confirmTapped(_ sender: UIButton) {
        defer {
            self.dismissView()
        }
        guard
            let identify = self.scannerResult?.identify,
            let name = self.scannerResult?.name else {
                self.delegate?.didDismiss()
                return
        }
        self.delegate?.didConfirm(result: (id: identify, name: name))
    }
}
