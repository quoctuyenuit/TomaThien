//
//  SelectUserTypeViewController.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/12/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

protocol UserTypeListDelegate {
    func didSelected(userType: UserType)
}
class UserTypeListViewController: UIViewController {
    //MARK: - Constant properties
    private let listItems = UserType.allCases
    private let reuseIdentifier = "SelectUserTypeCell"
    var delegate: UserTypeListDelegate?
    private var selectedItem: UserType = .member
    //MARK: - View properties
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: self.reuseIdentifier)
        return table
    }()
    
    convenience init(currentType: UserType) {
        self.init(nibName: nil, bundle: nil)
        self.selectedItem = currentType
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
}

extension UserTypeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.visibleCells.forEach { $0.accessoryType = .none }
        let selectedCell = self.tableView.cellForRow(at: indexPath)
        selectedCell?.accessoryType = .checkmark
        self.delegate?.didSelected(userType: self.listItems[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension UserTypeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
        let model = self.listItems[indexPath.row]
        cell.textLabel?.text = String(describing: model)
        
        if model == self.selectedItem {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
}
