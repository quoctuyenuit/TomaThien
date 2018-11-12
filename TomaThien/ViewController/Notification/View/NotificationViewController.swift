//
//  NotificationViewController.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/11/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class NotificationViewController: UIViewController, NotificationViewProtocol {
    //MARK: - Common properties
    var presenter: NotificationPresenterProtocol?
    private var reuseIdentifier: String = "\(NotificationViewCell.self)"
    private var notifications: [NotificationProtocol]!
    //MARK: - View properties
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(NotificationViewCell.self, forCellReuseIdentifier: self.reuseIdentifier)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100

        return table
    }()
    //MARK: - Setup view functions
    private func setupView() {
        self.view.addSubview(self.tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.navigationItem.title = "Thông báo"
        self.navigationItem.titleView?.tintColor = .white
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        
//        let backBtn = UIButton()
//        backBtn.setTitle("Trang chủ", for: .normal)
//        backBtn.setTitleColor(.white, for: .normal)
//        let barButton = UIBarButtonItem(customView: backBtn)
//
//        self.navigationItem
//            .leftBarButtonItems = [barButton]
    }
    
    convenience init(notifications: [NotificationProtocol]) {
        self.init(nibName: nil, bundle: nil)
        self.notifications = notifications
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NotificationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as? NotificationViewCell else {
            return UITableViewCell()
        }
        let notify = self.notifications[indexPath.row]
        cell.update(for: notify)
        return cell
    }
}

extension NotificationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notify = self.notifications[indexPath.row]
        notify.showDetail(from: self)
    }
}
