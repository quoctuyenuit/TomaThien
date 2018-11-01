//
//  TextField.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/31/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TextField: UIView {
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.tintColor = .appBase
        return textField
    }()
    private lazy var underLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.placeHoder
        line.frame.size.height = 1
        return line
    }()
    
    var rx: Reactive<UITextField> {
        return self.textField.rx
    }
    
    init() {
        super.init(frame: .zero)
        self.setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(self.textField)
        self.addSubview(self.underLine)
        
        self.textField.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.underLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
