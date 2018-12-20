//
//  ProfileViewCell.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/18/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit

class ProfileViewCell: UITableViewCell {

    public static let REUSE_IDENTIFIER = "ProfileViewCell"
    private lazy var _icon: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.lightGray
        return imageView
    }()
    private lazy var _titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
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
        self.addSubview(self._icon)
        self.addSubview(self._titleLabel)
        
        self._icon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(9)
            make.width.height.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        self._titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self._icon.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.height.greaterThanOrEqualTo(0)
            make.right.equalToSuperview().offset(-8)
        }
    }
    
    public func setConfig(for model: ProfileCellModel) {
        self._titleLabel.text = model.title
        self._icon.image = model.icon
    }
}
