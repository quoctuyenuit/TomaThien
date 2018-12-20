//
//  ProfileViewController.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/18/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, ProfileViewProtocol {

    var presenter: ProfilePresenterProtocol?
    var parentView: UIViewController?
    
    private var _listItems = [ProfileCellModel]()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(ProfileViewCell.self, forCellReuseIdentifier: ProfileViewCell.REUSE_IDENTIFIER)
        table.register(ProfileHeaderViewCell.self, forCellReuseIdentifier: ProfileHeaderViewCell.REUSE_IDENTIFIER)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._listItems = self.presenter?.getListItems() ?? []
        self.setupView()
    }
    
    private func setupView() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self._listItems[indexPath.row]
        
        switch item.type {
        case .header:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: ProfileHeaderViewCell.REUSE_IDENTIFIER) as! ProfileHeaderViewCell
            cell.setConfig(for: item)
            return cell
        default:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: ProfileViewCell.REUSE_IDENTIFIER) as! ProfileViewCell
            cell.setConfig(for: item)
            return cell
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let item = self._listItems[indexPath.row]
        
        switch item.type {
        case .header:
            break
        case .qrCodeView:
            self.presenter?.showQRCodeView(from: self.parentView)
        }
    }
}
