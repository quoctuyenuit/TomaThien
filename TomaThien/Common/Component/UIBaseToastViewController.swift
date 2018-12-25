//
//  UIBaseToastViewController.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/24/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class UIBaseToastViewController: UIViewController {
    
    public var isShowIcon: Bool = false
    
    public var message: String? = nil {
        didSet {
            self._titleLabel.text = self.message
        }
    }
    
    public var toastIcon: UIImage? {
        didSet {
            self._icon.image = self.toastIcon
        }
    }
    
    private lazy var _titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var _icon: UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    private lazy var _okButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("OK", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.appBase, for: .normal)
        btn.addTarget(self, action: #selector(okButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    private lazy var _contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        return view
    }()
    
    
    private let _iconSize: CGFloat = 50
    
    private func setupView() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.view.addSubview(self._contentView)
        
        self._contentView.addSubview(self._titleLabel)
        self._contentView.addSubview(self._icon)
        self._contentView.addSubview(self._okButton)
        
        if self.isShowIcon {
            self._icon.snp.makeConstraints { (make) in
                make.size.equalTo(self._iconSize)
                make.top.equalToSuperview().offset(10)
                make.centerX.equalToSuperview()
            }
            
            self._titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(self._icon.snp.bottom).offset(10)
                make.left.equalToSuperview().offset(10)
                make.right.equalToSuperview().offset(-10)
                make.height.greaterThanOrEqualTo(0)
            }
        } else {
            self._titleLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(20)
                make.left.equalToSuperview().offset(10)
                make.right.equalToSuperview().offset(-10)
                make.height.width.greaterThanOrEqualTo(0)
            }
        }
        
        self._okButton.snp.makeConstraints { (make) in
            make.top.equalTo(self._titleLabel.snp.bottom).offset(20)
            make.width.height.greaterThanOrEqualTo(0)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        
        self._contentView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(0)
            make.center.equalToSuperview()
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String, icon: UIImage? = nil) {
        self.init(nibName: nil, bundle: nil)
        self._icon.image = icon
        self.message = message
        self._titleLabel.text = message
        self.isShowIcon = icon != nil ? true : false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
}

extension UIBaseToastViewController {
    @objc private func okButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}
