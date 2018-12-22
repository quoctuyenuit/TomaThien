//
//  ShowListAllMemberViewController.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/22/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class ShowListAllMemberViewController: UIViewController, ShowListViewProtocol {
    var presenter: ShowListPresenterProtocol?
    private let disposeBag = DisposeBag()
    
    private var _currentTeam: Team = Team(id: 1) {
        didSet {
            self._currentTeamLabel.text = self._currentTeam.name
        }
    }
    
    private var _listItems = [User]() {
        didSet {
            self._tableView.reloadData()
        }
    }
    private var _listDataItems = [User]() {
        didSet {
            self._listItems.removeAll()
            self._listDataItems.forEach { self._listItems.append($0) }
        }
    }
    
    private var _typeList: TypeList!
    
    private var _headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var _chooseTeamInputView: TeamListViewController = {
        let ctrl = TeamListViewController(currentTeam: Team(id: 1))
        ctrl.view.frame.size.width = UIScreen.main.bounds.width
        self.view.frame.size.height = 500
        ctrl.delegate = self
        return ctrl
    }()
    
    private lazy var _currentTeamLabel: UITextField = {
        let label = UITextField()
        label.textColor = UIColor.black
        label.placeholder = "Nhóm"
        label.text = self._currentTeam.name
        label.font = UIFont.systemFont(ofSize: 16)
        label.inputView = self._chooseTeamInputView.view
        label.addTarget(self, action: #selector(dateEditingDidEnd(_:)), for: .editingDidEnd)
        return label
    }()
    
    private lazy var _searchBarView: UISearchBar = {
        let searchView = UISearchBar()
        searchView.placeholder = "Tìm kiếm"
        searchView.searchBarStyle = .minimal
        searchView.barStyle = .default
        searchView.backgroundColor = UIColor.white
        searchView.layer.masksToBounds = false
        searchView.layer.shadowOffset = CGSize(width: 0, height: 3  )
        searchView.layer.shadowColor = UIColor.lightGray.cgColor
        searchView.layer.shadowRadius = 1
        searchView.layer.shadowOpacity = 0.2
        return searchView
    }()
    
    private lazy var _tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ShowListDetailCell.self, forCellReuseIdentifier: ShowListDetailCell.REUSE_IDENTIFIER)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self._tableView.estimatedRowHeight = 50
        self._tableView.rowHeight = UITableView.automaticDimension
        self.setupView()
        self.setupEvents()
     
        
        self.getCurrentData()
    }
    
    private func setupView() {
        self.view.addSubview(self._headerView)
        self.view.addSubview(self._tableView)
        self.view.addSubview(self._searchBarView)
        self.view.backgroundColor = UIColor.white
        
        self._headerView.addSubview(self._currentTeamLabel)
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Xong", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneDatePicker(_:)))
        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.backgroundColor = UIColor.white
        self._currentTeamLabel.inputAccessoryView = toolbar
        
        self._headerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.height.equalTo(55)
        }
        
        self._currentTeamLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
            make.height.equalTo(35)
        }
        
        self._searchBarView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self._headerView.snp.bottom)
            make.height.equalTo(55)
        }
        
        self._tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self._searchBarView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupEvents() {
        self._searchBarView
            .rx
            .text
            .subscribe{[weak self] in
                guard let element = $0.element, let text = element else { return }
                
                let preFix = text.folding(options: .diacriticInsensitive, locale: nil).lowercased().replacingOccurrences(of: "đ", with: "d")
                
                self?._listItems = self?._listDataItems.filter {
                    let name = $0.name.folding(options: .diacriticInsensitive, locale: nil).lowercased().replacingOccurrences(of: "đ", with: "d")
                    return name.lowercased().hasPrefix(preFix)
                    } ?? []
            }
            .disposed(by: self.disposeBag)
    }
    
    @objc private func doneDatePicker(_ sender: UIBarButtonItem) {
        self._currentTeamLabel.endEditing(true)
    }
    
    @objc private func dateEditingDidEnd(_ sender: UITextField) {
        self.getCurrentData()
    }
    
    private func getCurrentData() {
        self._listDataItems.removeAll()
        self._tableView.reloadData()
        
        self.presenter?.getListAllMemberByTeam(teamId: self._currentTeam.id, callBack: { [weak self] (user) in
            if let alreadyIndex = self?._listItems.firstIndex(where: { $0.identify == user.identify }) {
                self?._listDataItems[alreadyIndex] = user
                return
            }
            self?._listDataItems.append(user)
        })
    }
    
    convenience init(for typeList: TypeList) {
        self.init(nibName: nil, bundle: nil)
        self.navigationItem.title = typeList.description
        
        self._typeList = typeList
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShowListAllMemberViewController: UITableViewDataSource {
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

extension ShowListAllMemberViewController: UITableViewDelegate {
    
}

extension ShowListAllMemberViewController: TeamListDelegate {
    func didSelected(userTeam: Team) {
        self._currentTeam = userTeam
    }
}
