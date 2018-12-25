//
//  UIViewController + Extension.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/24/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        
        let contentView = UIView()
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = false
        
        let label = UILabel()
        label.text = "Loading..."
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.backgroundColor = UIColor.white
        
        let ai = UIActivityIndicatorView.init(style: .gray)
        ai.startAnimating()
        
        DispatchQueue.main.async {
            
            onView.addSubview(spinnerView)
            spinnerView.addSubview(contentView)
            contentView.addSubview(label)
            contentView.addSubview(ai)
            
            label.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(20)
                make.width.height.greaterThanOrEqualTo(0)
                make.centerX.equalToSuperview()
            }
            
            ai.snp.makeConstraints({ (make) in
                make.top.equalTo(label.snp.bottom).offset(10)
                make.width.height.greaterThanOrEqualTo(0)
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().offset(-10).priority(.medium)
            })
            
            contentView.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(30)
                make.right.equalToSuperview().offset(-30)
                make.height.greaterThanOrEqualTo(0)
                make.center.equalToSuperview()
            }
            
            
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

