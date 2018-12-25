//
//  TeamListViewController.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/12/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

protocol TeamListDelegate {
    func teamListView(didSelect userTeam: Team)
}
class TeamListViewController: UIViewController {
    //MARK: - Constant properties
    private var listItems: [Team] = [Team]()
    private let reuseIdentifier = "TeamListIdentifier"
    var delegate: TeamListDelegate?
    private var selectedItem: Team?
    //MARK: - View properties
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: self.reuseIdentifier)
        return table
    }()
    
    convenience init(currentTeam: Team) {
        self.init(nibName: nil, bundle: nil)
        self.selectedItem = currentTeam
        TeamDataCache.sharedInstance.selectAll { (teams) in
            self.listItems = teams
            self.tableView.reloadData()
        }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.delegate?.teamListView(didSelect: selectedItem!)
    }
}

extension TeamListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.visibleCells.forEach { $0.accessoryType = .none }
        let selectedCell = self.tableView.cellForRow(at: indexPath)
        selectedCell?.accessoryType = .checkmark
        self.delegate?.teamListView(didSelect: self.listItems[indexPath.row])
        self.selectedItem = self.listItems[indexPath.row]
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension TeamListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
        let model = self.listItems[indexPath.row]
        cell.textLabel?.text = String(describing: model.name)
        
        if model == self.selectedItem! {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
}

