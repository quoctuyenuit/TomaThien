//
//  ShowListViewCell.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/19/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit

class ShowListDetailCell: UITableViewCell {

    static var REUSE_IDENTIFIER = "ShowListDetailCell"

    private let avatarSize: CGFloat = 50
    private lazy var _avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = avatarSize / 2
        imageView.backgroundColor = .white
        imageView.clearsContextBeforeDrawing = true
        imageView.layer.borderWidth = 2
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.whiteTwo.cgColor
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "default_avatar")
        return imageView
    }()
    
    private lazy var _nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var _descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private lazy var _moreContentView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(self._avatar)
        self.addSubview(self._moreContentView)
        self._moreContentView.addSubview(self._nameLabel)
        self._moreContentView.addSubview( self._descriptionLabel)
        
        self._avatar.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(self.avatarSize)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        self._nameLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(0)
        }
        
        self._descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self._nameLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(0)
            make.bottom.equalToSuperview().priority(.medium)
        }
        
        self._moreContentView.snp.makeConstraints { (make) in
            make.left.equalTo(self._avatar.snp.right).offset(10)
            make.height.greaterThanOrEqualTo(0)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    public func setConfig(for model: User) {
        self._avatar.pin_setImage(from: URL(string: model.imageUrl))
        self._nameLabel.text = model.name
        self._descriptionLabel.text = model.userType.description
    }

}
