//
//  ShowListViewController.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/19/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class ShowListDetailViewController: UIViewController, ShowListViewProtocol {
    var presenter: ShowListPresenterProtocol?
    private var _listItems = [User]()
    private var _typeList: TypeList!
    
    private lazy var _tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ShowListDetailCell.self, forCellReuseIdentifier: ShowListDetailCell.REUSE_IDENTIFIER)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.getListMemberInformation(for: self._typeList, callBack: {[weak self] (user) in
            if let alreadyIndex = self?._listItems.firstIndex(where: { $0.identify == user.identify }) {
                self?._listItems[alreadyIndex] = user
                self?._tableView.reloadData()
                return
            }
            self?._listItems.append(user)
            self?._tableView.reloadData()
        })
        
        
        self._tableView.estimatedRowHeight = 50
        self._tableView.rowHeight = UITableView.automaticDimension
        self.setupView()
    }
    
    private func setupView() {
        self.view.addSubview(self._tableView)
        self._tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    convenience init(for typeList: TypeList) {
        self.init(nibName: nil, bundle: nil)
        self.navigationItem.title = typeList.description
        self._typeList = typeList
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShowListDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShowListDetailCell.REUSE_IDENTIFIER, for: indexPath) as! ShowListDetailCell
        
        let model = self._listItems[indexPath.row]
        cell.setConfig(for: model)
        return cell
    }
    
    
}

extension ShowListDetailViewController: UITableViewDelegate {
    
}
