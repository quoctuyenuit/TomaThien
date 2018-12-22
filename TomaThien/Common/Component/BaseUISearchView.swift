//
//  BaseUISearchView.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/21/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class BaseUISearchView: UIView {
    private lazy var _searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Tìm kiếm"
        textField.textColor = UIColor.black
        textField.clearButtonMode = .always
        return textField
    }()
    
    private lazy var _searchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ico_search")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        imageView.tintColor = UIColor.lightGray
        return imageView
    }()
    
    private lazy var _contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 240/255, alpha: 1)
        view.layer.cornerRadius = 5
        return view
    }()
    
    public var rx: PublishSubject<String>?
    
    private func setupView() {
        self.addSubview(self._contentView)
        self._contentView.addSubview(self._searchIcon)
        self._contentView.addSubview(self._searchTextField)
        
        self._contentView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        self._searchIcon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(6)
            make.width.height.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        self._searchTextField.snp.makeConstraints { (make) in
            make.left.equalTo(self._searchIcon.snp.right).offset(8)
            make.top.bottom.right.equalToSuperview()
        }
        
        self.backgroundColor = UIColor.white
    }
    
    private func setupEvents() {
        
//        self.rx?.bind(to: <#T##(PublishSubject<String>) -> R#>)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
