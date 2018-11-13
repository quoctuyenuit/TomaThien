//
//  RegisterViewController.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/31/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit


class RegisterViewController: UIViewController, RegisterViewProtocol {
    var presenter: RegisterPresenterProtocol?
    
    private let textFieldPlacing: CGFloat = 5
    private let logoWidth: CGFloat = 60
    private let padding: CGFloat = 20
    private let textFieldHeight: CGFloat = 40
    private lazy var mainBound: UIView = {
        let bound = UIView()
        bound.backgroundColor = .white
        bound.layer.cornerRadius = 5
        bound.layer.masksToBounds = false
        bound.layer.shadowColor = UIColor.black.cgColor
        bound.layer.shadowOpacity = 0.5
        bound.layer.shadowOffset = .zero
        bound.layer.shadowRadius = 1
        bound.addSubview(self.headerBound)
        bound.addSubview(self.scrollView)
        bound.addSubview(self.registerButton)
        return bound
    }()
    private lazy var headerBound: UIView = {
        let bound = UIView()
        bound.addSubview(self.logoImageView)
        bound.addSubview(self.largeTitle)
        bound.addSubview(self.smallTitle)
        return bound
    }()
    
    //MARK: - Properties Header
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.backgroundColor = .clear
        return imageView
    }()
    private lazy var largeTitle: UILabel = {
        let label = UILabel()
        label.text = "TomaThien"
        label.font = UIFont.sfuiMedium(size: 40)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private lazy var smallTitle: UILabel = {
        let label = UILabel()
        label.text = "Mời bạn đăng nhập để tiếp tục"
        label.font = UIFont.sfuiMedium()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    //MARK: - Properties body
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.addSubview(self.bodyBound)
        return scroll
    }()
    
    private lazy var name: TextField = {
        return self.getTextField(placeHolder: "Nhập họ tên nhé")
    }()
    
    private lazy var phoneNumber: TextField = {
        return self.getTextField(placeHolder: "Nhập số điện thoại nhé")
    }()
    
    private lazy var email: TextField = {
        return self.getTextField(placeHolder: "Nhập email nhé")
    }()
    
    private lazy var identify: TextField = {
        return self.getTextField(placeHolder: "Nhập số cmnd nhé")
    }()
    
    private lazy var school: TextField = {
        return self.getTextField(placeHolder: "Nhập trường bạn học nhé")
    }()
    
    private lazy var address: TextField = {
        return self.getTextField(placeHolder: "Nhập địa chỉ nè")
    }()
    
    private lazy var yearOfAdmission: TextField = {
        return self.getTextField(placeHolder: "Nhập năm bạn nhập học nha")
    }()
    
    private lazy var yearsOfStudy: TextField = {
        return self.getTextField(placeHolder: "Nhập số năm bạn học nha")
    }()
    
    private lazy var team: TextField = {
        return self.getTextField(placeHolder: "Nhóm")
    }()
    
    private lazy var bodyBound: UIView = {
        let bound = UIView()
        bound.addSubview(self.name)
        bound.addSubview(self.phoneNumber)
        bound.addSubview(self.email)
        bound.addSubview(self.identify)
        bound.addSubview(self.school)
        bound.addSubview(self.address)
        bound.addSubview(self.yearOfAdmission)
        bound.addSubview(self.yearsOfStudy)
        bound.addSubview(self.team)
        return bound
    }()
    
    private lazy var registerButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Đăng ký", for: .normal)
        btn.layer.cornerRadius = 3
        btn.titleLabel?.textColor = .white
        btn.titleLabel?.font = UIFont.sfuiMedium()
        btn.backgroundColor = UIColor.appBase
        btn.addTarget(self, action: #selector(registerTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    private func getTextField(placeHolder: String) -> TextField{
        let textField = TextField()
        textField.textField.placeholder = placeHolder
        textField.textField.textColor = .black
        textField.textField.tintColor = .appBase
        textField.textField.isSecureTextEntry = true
        return textField
    }
    
    //MARK: - SetupView functions
    private func setupTitle() {
        self.logoImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(self.logoWidth)
            make.centerX.equalToSuperview()
        }
        self.largeTitle.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.logoImageView.snp.bottom).offset(40)
            make.height.greaterThanOrEqualTo(0)
        }
        self.smallTitle.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.largeTitle.snp.bottom).offset(30)
            make.bottom.equalToSuperview().priority(.medium)
        }
    }
    
    private func setupBody() {
        self.name.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(self.textFieldHeight)
        }
        self.phoneNumber.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.name.snp.bottom).offset(self.textFieldPlacing)
            make.height.equalTo(self.textFieldHeight)
        }
        self.email.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.phoneNumber.snp.bottom).offset(self.textFieldPlacing)
            make.height.equalTo(self.textFieldHeight)
        }
        self.identify.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.email.snp.bottom).offset(self.textFieldPlacing)
            make.height.equalTo(self.textFieldHeight)
        }
        self.school.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.identify.snp.bottom).offset(self.textFieldPlacing)
            make.height.equalTo(self.textFieldHeight)
        }
        self.address.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.school.snp.bottom).offset(self.textFieldPlacing)
            make.height.equalTo(self.textFieldHeight)
        }
        self.yearOfAdmission.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.address.snp.bottom).offset(self.textFieldPlacing)
            make.height.equalTo(self.textFieldHeight)
        }
        self.yearsOfStudy.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.yearOfAdmission.snp.bottom).offset(self.textFieldPlacing)
            make.height.equalTo(self.textFieldHeight)
        }
        self.team.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.yearsOfStudy.snp.bottom).offset(self.textFieldPlacing)
            make.height.equalTo(self.textFieldHeight)
            make.bottom.equalToSuperview().priority(.medium)
        }
    }
    
    private func setupView() {
        self.view.backgroundColor = UIColor.background
        self.view.addSubview(self.mainBound)
        self.setupTitle()
        self.setupBody()
        
        self.headerBound.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.greaterThanOrEqualTo(0)
        }
        
        self.bodyBound.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        self.registerButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(self.padding)
            make.right.equalToSuperview().offset(-self.padding)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-20).priority(.medium)
        }
        
        self.scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerBound.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(self.padding)
            make.right.equalToSuperview().offset(-self.padding)
            make.bottom.equalTo(self.registerButton.snp.top).offset(-20)
        }
        
        self.mainBound.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    @objc private func registerTapped(_ sender: UIButton) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "dd/MM/yyyy"
        let user = User(name: "Nguyễn Quốc Tuyến",
                             birthDay: formatter.date(from: "26/06/1997") ?? Date(),
                             phoneNumber: "0968329208",
                             email: "quoctuyen9aht@gmail.com",
                             identify: "184313135",
                             school: "ĐH Công Nghệ Thông Tin - ĐHQG TP.HCM",
                             address: "KTX Khu B - ĐHQG TP.HCM",
                             yearOfAdmission: 2015,
                             yearsOfStudy: 4.5,
                             team: Team(id: 8),
                             imageUrl: "",
                             userType: .admin,
                             status: .notAuthentic)
        
        self.presenter?.register(user: user, userImage: UIImage(named: "avatar")!)
    }
}
