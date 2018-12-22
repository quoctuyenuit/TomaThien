//
//  ShowListViewController.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/19/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ShowListDetailViewController: UIViewController, ShowListViewProtocol {
    var presenter: ShowListPresenterProtocol?
    private let disposeBag = DisposeBag()
    
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
        self.presenter?.getListMemberInformation(for: self._typeList, callBack: {[weak self] (user) in
            if let alreadyIndex = self?._listItems.firstIndex(where: { $0.identify == user.identify }) {
                self?._listDataItems[alreadyIndex] = user
                return
            }
            self?._listDataItems.append(user)
        })
        
        
        self._tableView.estimatedRowHeight = 50
        self._tableView.rowHeight = UITableView.automaticDimension
        self.setupView()
        self.setupEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupView() {
        self.view.addSubview(self._tableView)
        self.view.addSubview(self._searchBarView)
        self.view.backgroundColor = UIColor.white
        
        self._searchBarView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
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
