//
//  RegistationNotifyDetailViewController.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/11/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

struct RegistationItem {
    var label: String
    var title: String
}

class UITableViewCellSubtitle: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RegistationNotifyDetailViewController: UIViewController, RegistationNotifyDetailViewProtocol {
    var presenter: RegistationNotifyDetailPresenterProtocol?
    //MARK: - Constant properties
    private let avatarSize: CGFloat = 100
    private let avatarTopPadding: CGFloat = 50
    private let itemHeight: CGFloat = 44
    private let itemCount: CGFloat = 11
    private let reuseIdentifier = "RegistationNotify"
    private var user: User?
    private var itemsList: [RegistationItem] = []
    //MARK: - View properties
    private lazy var headerBound: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        return view
    }()
    private lazy var footerBound: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        return view
    }()
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCellSubtitle.self, forCellReuseIdentifier: self.reuseIdentifier)
        return table
    }()
    private lazy var confirmButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .appBase
        btn.setTitle("Xác nhận", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 4
        btn.addTarget(self, action: #selector(confirmTapped(_:)), for: .touchUpInside)
        return btn
    }()
    private lazy var headerLine: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        return line
    }()
    private lazy var footerLine: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        return line
    }()
    
    private lazy var avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = avatarSize / 2
        imageView.backgroundColor = .white
        imageView.clearsContextBeforeDrawing = true
        imageView.layer.borderWidth = 2
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "ico_personal")
        return imageView
    }()
    
    convenience init(user: User) {
        self.init(nibName: nil, bundle: nil)
        self.user = user
        self.updateView(user: user)
    }
    
    private func updateView(user: User) {
        self.itemsList.removeAll()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "dd/MM/yyyy"
        self.itemsList.append(RegistationItem(label: "Họ tên:", title: user.name))
        self.itemsList.append(RegistationItem(label: "Ngày sinh:", title: formatter.string(from: user.birthDay)))
        self.itemsList.append(RegistationItem(label: "Số điện thoại:", title: user.phoneNumber))
        self.itemsList.append(RegistationItem(label: "email:", title: user.email))
        self.itemsList.append(RegistationItem(label: "CMND:", title: user.identify))
        self.itemsList.append(RegistationItem(label: "Trường:", title: user.school))
        self.itemsList.append(RegistationItem(label: "Địa chỉ:", title: user.address))
        self.itemsList.append(RegistationItem(label: "Năm nhập học:", title: "\(user.yearOfAdmission)"))
        self.itemsList.append(RegistationItem(label: "Số năm học:", title: "\(user.yearsOfStudy)"))
        self.itemsList.append(RegistationItem(label: "Nhóm:", title: "\(user.team.name)"))
        self.itemsList.append(RegistationItem(label: "Loại tài khoản:", title: String(describing: user.userType)))
        
        self.avatar.pin_setImage(from: URL(string: user.imageUrl))
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLabel(to string: String, alignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.font = UIFont.sfuiMedium()
        label.textColor = .black
        label.textAlignment = alignment
        label.text = string
        return label
    }
    
    private func setupView() {
        self.view.backgroundColor = UIColor.background
        self.view.addSubview(self.headerBound)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.footerBound)
        
        self.headerBound.addSubview(self.avatar)
        self.headerBound.addSubview(self.headerLine)
        self.footerBound.addSubview(self.confirmButton)
        self.footerBound.addSubview(self.footerLine)
        
        self.avatar.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(self.avatarSize)
            make.bottom.equalToSuperview().offset(-12).priority(.medium)
        }
        
        self.confirmButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
            make.height.equalTo(54)
            make.top.equalToSuperview().offset(12).priority(.medium)
        }
        
        self.headerBound.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(0)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        self.footerBound.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.height.greaterThanOrEqualTo(0)
        }
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerBound.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.footerBound.snp.top)
        }
        
        self.headerLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        self.footerLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.navigationItem.title = "Yêu cầu đăng ký"
    }
    
    @objc private func confirmTapped(_ sender: UIButton) {
        guard let user = self.user else { return }
        self.presenter?.confirmRegistation(user: user)
    }
}

extension RegistationNotifyDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let model = self.itemsList[indexPath.row]
        if let currentUser = self.user {
            if model.label == "Loại tài khoản:"  {
                self.presenter?.showUserTypeList(from: self, currentUserType: currentUser.userType)
            } else if model.label == "Nhóm:" {
                let team = currentUser.team
                self.presenter?.showTeamList(from: self, currentTeam: team)
            }
        }
    }
}

extension RegistationNotifyDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
    
        let item = itemsList[indexPath.row]
        cell.textLabel?.text = item.label
        cell.detailTextLabel?.text = item.title
        if item.label == "Loại tài khoản:" || item.label == "Nhóm:" {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
}

extension RegistationNotifyDetailViewController: UserTypeListDelegate {
    func didSelected(userType: UserType) {
        self.user?.userType = userType
        self.updateView(user: user!)
        self.tableView.reloadData()
    }
}

extension RegistationNotifyDetailViewController: TeamListDelegate {
    func teamListView(didSelect userTeam: Team) {
        self.user?.team = userTeam
        self.updateView(user: user!)
        self.tableView.reloadData()
    }
}
