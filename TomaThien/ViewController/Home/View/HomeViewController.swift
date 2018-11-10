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
                HomeCellModel(identify: .sendServer, image: UIImage(named: "ico_sendserver"), title: "Gửi lên server")
            ]
        case .sublead?:
            items = [
                HomeCellModel(identify: .qrCodeScanner, image: UIImage(named: "ico_qrcode"), title: "Quét điểm danh"),
                HomeCellModel(identify: .showList, image: UIImage(named: "ico_view"), title: "Xem danh sách"),
                HomeCellModel(identify: .sendServer, image: UIImage(named: "ico_sendserver"), title: "Gửi lên server")
            ]
        case .member?:
            items = [
                HomeCellModel(identify: .qrCodeView, image: UIImage(named: "ico_show_qrcode"), title: "Xuất mã QR"),
                HomeCellModel(identify: .showList, image: UIImage(named: "ico_view"), title: "Xem danh sách"),
                HomeCellModel(identify: .checkRegister, image: UIImage(named: "ico_check"), title: "Kiểm tra điểm danh")
            ]
        default: break
        }
        return items
    }()
    private var cellSize: CGSize {
        let width: CGFloat = UIScreen.main.bounds.width / 3
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
    
    private lazy var notifyButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .appBase
        guard let icon = UIImage(named: "ico_notify") else { return btn }
        btn.setImage(icon, for: .normal)
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
        case .qrCodeView:
            let qrCodeView = QRCodeRouter.createQRCodeViewController()
            self.parentView?.navigationController?.pushViewController(qrCodeView, animated: true)
        default:
            break
        }
    }
}

extension HomeViewController {
    private func getNotification() {
        ServerServices.sharedInstance
            .pullListData(path: "Notification"){ (snapshot) in
                guard let data = snapshot.value as? [String: Any] else { return }
                print(data)
            }
    }
}
