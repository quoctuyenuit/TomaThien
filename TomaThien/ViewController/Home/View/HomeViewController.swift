//
//  HomeViewController.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/3/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit
import UICollectionViewLeftAlignedLayout
import RxSwift

private let reuseIdentifier = "Cell"

class HomeViewController: UIViewController, HomeViewProtocol {
    var presenter: HomePresenterProtocol?
    var parentView: UIViewController?
    var notificationCaches = [NotificationProtocol]()
    var numberOfNotification = 0
    private let disposeBag = DisposeBag()
    //MARK: - Constant variable
    private let headerHeight: CGFloat = 44
    
    private lazy var items: [HomeCellModel] = {
        var items = [HomeCellModel]()
        switch LoginManager.sharedInstance.user?.userType {
        case .admin?:
            items = [
                HomeCellModel(identify: .qrCodeScanner, image: UIImage(named: "ico_qrcode"), title: "Quét điểm danh"),
                HomeCellModel(identify: .showList, image: UIImage(named: "ico_view"), title: "Xem danh sách"),
                HomeCellModel(identify: .report, image: UIImage(named: "ico_report"), title: "Báo cáo"),
            ]
        case .sublead?:
            items = [
                HomeCellModel(identify: .qrCodeScanner, image: UIImage(named: "ico_qrcode"), title: "Quét điểm danh"),
                HomeCellModel(identify: .showList, image: UIImage(named: "ico_view"), title: "Xem danh sách"),
            ]
        case .member?:
            items = [
                HomeCellModel(identify: .qrCodeView, image: UIImage(named: "ico_show_qrcode"), title: "Xuất mã QR"),
                HomeCellModel(identify: .showList, image: UIImage(named: "ico_view"), title: "Xem danh sách"),
            ]
        default: break
        }
        return items
    }()
    private var cellSize: CGSize {
        let width: CGFloat = UIScreen.main.bounds.width / 2
        return CGSize(width: width, height: width)
    }
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewLeftAlignedLayout()
        // Now setup the flowLayout required for drawing the cells
        let space = 5.0 as CGFloat
        flowLayout.itemSize = cellSize
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.allowsSelection = true
        return collectionView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .minimal
        search.barStyle = .default
        search.placeholder = "Search"
        search.backgroundColor = .appBase
        search.layer.borderWidth = 0
        search.layer.borderColor = UIColor.appBase.cgColor
        return search
    }()
    
    private lazy var notifyButton: UIButtonWithBadge = {
        let btn = UIButtonWithBadge()
        btn.backgroundColor = .appBase
        guard let icon = UIImage(named: "ico_notify") else { return btn }
        btn.icon = icon
        btn.buttonTapped = HomeViewController.notifyButtonTapped(self)
        return btn
    }()
    private lazy var headerBoundView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBase
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.collectionView.indicatorStyle = .white
        self.getNotification()
        self.navigationItem.title = "Trang chủ"
    }
    
    private func setupView() {
        self.setupHeaderView()
        self.setupCollectionView()
        self.view.backgroundColor = .appBase
        
    }
    
    private func setupCollectionView() {
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(self.headerBoundView.snp.bottom).offset(5)
        }
    }
    
    private func setupHeaderView() {
        self.view.addSubview(self.headerBoundView)
        self.headerBoundView.addSubview(self.searchBar)
        self.headerBoundView.addSubview(self.notifyButton)
        
        self.notifyButton.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(40)
        }
        self.searchBar.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.right.equalTo(self.notifyButton.snp.left)
        }
        self.headerBoundView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(self.headerHeight)
        }
    }
    
    func configure(items: [HomeCellModel]) {
        self.items = items
    }
}


extension HomeViewController: UICollectionViewDelegate {}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? HomeViewCell else { return UICollectionViewCell() }
        let model = items[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.items[indexPath.row]
        switch item.identify {
        case .qrCodeScanner:
            let scannerViewController = QRScannerRouter.createQRScanner()
            self.parentView?.navigationController?.pushViewController(scannerViewController, animated: true)
        case .showList:
            let view = ShowListRouter.createShowListViewController()
            self.parentView?.navigationController?.pushViewController(view, animated: true)
        default:
            break
        }
    }
}

extension HomeViewController {
    private func getNotification() {
        ServerServices
            .sharedInstance
            .pullData(path: ServerReferncePath.notificationRegister,
                      completion: { (listSnapshot) in
                        listSnapshot.forEach({ (snapshot) in
                            if let user = NotificationRegistation(snapshot: snapshot) {
                                self.notificationCaches.append(user)
                                self.numberOfNotification += 1
                                self.notifyButton.setBadge(value: self.numberOfNotification)
                            }
                        })
            })
    }
}

extension HomeViewController {
    @objc private func notifyButtonTapped(_ sender: UIButton) {
        self.presenter?.showNotification(from: self.parentView, listNotification: notificationCaches)
    }
}
