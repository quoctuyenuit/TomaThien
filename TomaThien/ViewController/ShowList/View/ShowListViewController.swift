//
//  ShowListViewController.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/19/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class ShowListViewController: UIViewController, ShowListViewProtocol {
    var presenter: ShowListPresenterProtocol?
    private static let REUSE_IDENTIFIER = "ShowListViewCell"
    private var _listItems = TypeList.allCases
    
    private lazy var _tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ShowListViewController.REUSE_IDENTIFIER)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.view.addSubview(self._tableView)
        self._tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension ShowListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShowListViewController.REUSE_IDENTIFIER, for: indexPath)
        let model = self._listItems[indexPath.row]
        cell.textLabel?.text = model.description
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension ShowListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentModel = self._listItems[indexPath.row]
        self.presenter?.showListOfDetail(from: self, for: currentModel)
    }
}
