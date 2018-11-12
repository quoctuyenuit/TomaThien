//
//  NotificationViewCell.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/11/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class NotificationViewCell: UITableViewCell {
    //MARK: - constant
    private let iconSize: CGFloat = 40
    //MARK: - view properties
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private lazy var notiTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.notifiTitle
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    private lazy var notiContent: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    private lazy var notiTime: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.notifiTitle
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    private lazy var contentBound = UIView()
    private lazy var titleBound = UIView()
    private lazy var mainBound = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup view functions
    private func setupView() {
        self.addSubview(self.mainBound)
        self.mainBound.addSubview(self.icon)
        self.mainBound.addSubview(self.contentBound)
        self.contentBound.addSubview(self.titleBound)
        self.contentBound.addSubview(self.notiContent)
        self.titleBound.addSubview(self.notiTitle)
        self.titleBound.addSubview(self.notiTime)
        
        self.mainBound.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().offset(-10)
        }
        
        self.icon.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.size.equalTo(self.iconSize)
        }
        
        self.contentBound.snp.makeConstraints { (make) in
            make.left.equalTo(self.icon.snp.right).offset(10)
            make.top.right.bottom.equalToSuperview()
        }
        
        self.notiTitle.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.height.greaterThanOrEqualTo(0)
        }
        
        self.notiTime.snp.makeConstraints { (make) in
            make.right.top.equalToSuperview()
            make.width.height.greaterThanOrEqualTo(0)
        }
        
        self.titleBound.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(0)
        }
        
        self.notiContent.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.titleBound.snp.bottom).offset(20)
            make.bottom.equalToSuperview().priority(.medium)
        }
    }
    
    public func update(for model: NotificationProtocol) {
        self.icon.image = model.notiIcon
        self.notiTitle.text = model.notiTitle.rawValue
        self.notiTime.text = model.notiTime
        self.notiContent.text = model.notiContent
    }
}
