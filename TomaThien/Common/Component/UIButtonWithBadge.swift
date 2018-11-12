//
//  UIButtonWithBadge.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/10/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class UIButtonWithBadge: UIView {
    private var badgeSize: CGFloat = 30
    public var buttonTapped: ((_ sender: UIButton) -> ())?
    private lazy var badgeView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.backgroundColor = .red
        view.layer.cornerRadius = 8
        view.clearsContextBeforeDrawing = true
        view.layer.masksToBounds = false
        view.clipsToBounds = true
        view.alpha = 0
        return view
    }()
    private lazy var badge: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfuiMedium(size: 10)
        label.textColor = .white
        return label
    }()
    private lazy var button: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return btn
    }()
    var icon: UIImage = UIImage() {
        didSet {
            self.button.setImage(icon, for: .normal)
        }
    }
    
    convenience init() {
        self.init(frame: .zero)
        self.setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(self.button)
        self.button.addSubview(self.badgeView)
        self.badgeView.addSubview(self.badge)
        
        self.button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.badge.snp.makeConstraints { (make) in
            make.top.equalTo(2)
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.bottom.equalTo(-2)
            make.size.greaterThanOrEqualTo(0)
        }
        self.badgeView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.size.greaterThanOrEqualTo(0)
        }
    }
    
    public func setBadge(value: Int) {
        self.badge.text = "\(value)"
        self.badgeView.alpha = value > 0 ? 1 : 0
        
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        self.buttonTapped?(sender)
    }
}
