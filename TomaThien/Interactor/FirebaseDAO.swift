//
//  FirebaseDatabase.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/24/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import Firebase
import RxSwift

class FirebaseDAO {
    static public let sharedInstance = FirebaseDAO()
    
    fileprivate let storageReference = Storage.storage().reference()
    fileprivate let databaseReference = Database.database().reference()
    
    fileprivate var imageCache = NSCache<NSString, UIImage>()
    
    enum Response<T> {
        case susscess(T)
        case fail(Error)
    }
    
    public func pullData(path: String) -> Observable<DataSnapshot> {
        return Observable.create { (observer) -> Disposable in
            self.databaseReference.child(path).observe(.value) { (snapshot) in
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot {
                        observer.onNext(snapshot)
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    public func pushData(path: String, value: Any) {
        self.databaseReference.child(path).setValue(value)
    }
    
    public func pushImage(path: String, image: UIImage) {
        let ref = self.storageReference.child(path)
        self.uploadImage(key: ref.name) { (reponse) in
            switch reponse {
            case .susscess(_):
                print("Image was uploaded")
            case .fail(let error):
                print("Upload image was fail with \(error)")
            }
        }
    }
    
    private func uploadImage(key: String, completion: @escaping (_ resonse: Response<Any>) -> Void) {
        let storageRef = Storage.storage().reference().child("\(key).png")
        if let uploadData = UIImage(named: "qrcode")!.pngData() {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if let error = error {
                    completion(Response.fail(error))
                } else {
                    guard let path = metadata?.path else { return }
                    completion(Response.susscess(path))
                }
            }
        }
    }
    
    func downloadImage(path: String, completion: @escaping (_ image: UIImage) -> ()) {
        self.storageReference.child("\(path).png").downloadURL { (url, error) in
            if let error = error {
                print(error)
            } else if let url = url {
                self.downloadImage(url: url, completed: { (image) in
                    completion(image)
                })
            }
        }
    }
    
    fileprivate func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    fileprivate func downloadImage(url: URL, completed: ((UIImage) -> ())?) {
        if let cacheImage = self.imageCache.object(forKey: url.absoluteString as NSString) {
            completed?(cacheImage)
            return
        }
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {[weak self] in
                guard let image = UIImage(data: data) else { return }
                self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                completed?(image)
            }
        }
    }
}
