//
//  ViewController.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/24/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import SnapKit
import AlamofireImage
import Alamofire

class ViewController: UIViewController {
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.testDatabase()
    }
    private var imageView: UIImageView!
    private func setupView() {
        self.imageView = UIImageView()
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(200)
            make.top.equalToSuperview().offset(100)
        }
    }
    
    
    private func testDatabase() {
//        let database = FirebaseDAO.sharedInstance
//        let student = Student(name: "Nguyen Quoc Tuyen", birthDay: Date(), phoneNumber: "0968329208", email: "quoctuyen9aht@gmail.com", identify: "184313135", school: "DH CNTT", address: "KTX Khu B", yearOfAdmission: 2015, yearsOfStudy: 4.5, team: 8)
//
//        database.pushData(path: "StudentList/\(student.key)", value: student.toObject())
//        database.downloadImage(path: "\(student.key)") { (image) in
//            self.imageView.image = image
//        }
        
        guard let image = UIImage(named: "qrcode") else { return }
        
//        ServerServices.sharedInstance.pushImage(path: student.key, image: image)
        
//        var dic: [String: String] = [
//            "184313135": "Nguyen Quoc Tuyen",
//            "184313136": "Nguyen Quoc A"
//        ]
//
//        QRScannerStore.sharedInstance.writeCache(dic: dic)
    }

}

