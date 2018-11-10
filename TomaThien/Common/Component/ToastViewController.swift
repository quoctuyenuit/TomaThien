//
//  ToastViewController.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/9/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ToastViewController: UIViewController {
    //MARK: - Contanst properties
    private let contentWidth: CGFloat = UIScreen.main.bounds.size.width - 20
    private var isShowIcon: Bool = false
    private let iconSize: CGFloat = 50
    private var duration: TimeInterval = 0.6
    private var text: String = "Lưu thành công"
    //MARK: - View properties
    private lazy var boundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private lazy var titleString: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.sfuiMedium()
        label.text = self.text
        label.textAlignment = .center
        return label
    }()
    
    convenience init(text: String, isShowIcon: Bool, duration: TimeInterval) {
        self.init(nibName: nil, bundle: nil)
        self.duration = duration
        self.text = text
        self.isShowIcon = isShowIcon
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup view
    private func setupView() {
        self.view.addSubview(self.boundView)
        self.boundView.addSubview(self.titleString)
//
//        if self.isShowIcon {
//            self.boundView.addSubview(self.icon)
//            self.icon.snp.makeConstraints { (make) in
//                make.size.equalTo(self.iconSize)
//                make.centerX.equalToSuperview()
//                make.top.equalToSuperview().offset(5)
//            }
//        }
       
        self.titleString.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualTo(self.contentWidth)
            make.width.greaterThanOrEqualTo(0)
            make.height.greaterThanOrEqualTo(0)
            make.left.right.equalToSuperview().priority(.medium)
            make.bottom.equalToSuperview().priority(.medium)
        }
        
        self.boundView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(white: 0, alpha: 0)
        self.setupView()
        self.titleString.alpha = 0

        UIView.animateKeyframes(withDuration: 2, delay: 0, options: [.calculationModeLinear], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 1,
                               animations: {
                self.titleString.alpha = 1
            })
            UIView.addKeyframe(withRelativeStartTime: 1,
                               relativeDuration: 1,
                               animations: {
                self.titleString.alpha = 0
            })
            
        }, completion: { _ in
//            self.dismiss(animated: false, completion: nil)
        })
    }
    
    //MARK: - Control function
    static public func showToast(text: String, isShowIcon: Bool = false ,duration: TimeInterval = 1) -> UIViewController {
        return ToastViewController()
    }
}
