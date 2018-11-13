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
import SystemConfiguration

enum ServerServicesErrors: String, Error {
    case noInternet = "Network is not available"
}
enum ServerReferncePath: String {
    case studentList = "StudentList"
    case notification = "Notification"
    case notificationRegister = "Notification/Registation"
    case registationList = "RegistationList"
    case teamList = "TeamList"
}

class ServerServices {
    static public let sharedInstance = ServerServices()
    
    fileprivate let storageReference = Storage.storage().reference()
    fileprivate let databaseReference = Database.database().reference()
    
    private let queue = DispatchQueue.init(label: "serverservices.firebase",
                                           qos: .background,
                                           attributes: .concurrent,
                                           autoreleaseFrequency: .inherit,
                                           target: nil)
    
    enum Response<T> {
        case susscess(T)
        case fail(Error)
    }
    
    public func pullData(path: ServerReferncePath,
                         completion: @escaping ([DataSnapshot]) -> ()) {
        self.queue.async {
            self.databaseReference.child(path.rawValue).observe(.value) { (snapshot) in
                var listSnapshot = [DataSnapshot]()
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot {
                        listSnapshot.append(snapshot)
                    }
                }
                completion(listSnapshot)
            }
            
        }
    }
    
    public func pushData(key: String,
                         from parent: ServerReferncePath,
                         value: Any,
                         completion: @escaping (Error?, DatabaseReference?) -> ()) {
//        if Reachability.isConnectedToNetwork().not {
//            completion(ServerServicesErrors.noInternet, nil)
//        }
        self.queue.async {
            let path = "\(parent.rawValue)/\(key)"
            self.databaseReference.child(path).setValue(value, withCompletionBlock: completion)
        }
    }
    
    public func observe(path: String, doSomething: @escaping (DataSnapshot) -> ()) {
        self.databaseReference.child(path).observe(.childAdded) { (snapshot) in
            doSomething(snapshot)
        }
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
        self.queue.async {
            let storageRef = self.storageReference.child("\(key).png")
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
    }
//
//    func downloadImage(key: String, completion: @escaping (_ image: UIImage) -> ()) {
//        if let cacheImage = self.imageCache.object(forKey: "\(key).png" as NSString) {
//            completion(cacheImage)
//            return
//        }
//
//        self.storageReference.child("\(key).png").downloadURL { (url, error) in
//            if let error = error {
//                print(error)
//            } else if let url = url {
//                self.downloadImage(url: url, completion: { (image) in
//                    completion(image)
//                })
//            }
//        }
//    }
//
//    fileprivate func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
//    }
//
//    fileprivate func downloadImage(url: URL, completion: ((UIImage) -> ())?) {
//        print("Download Started")
//        getData(from: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//            print(response?.suggestedFilename ?? url.lastPathComponent)
//            print("Download Finished")
//            DispatchQueue.main.async() {[weak self] in
//                guard let image = UIImage(data: data) else { return }
//                self?.imageCache.setObject(image, forKey: url.lastPathComponent as NSString)
//                completion?(image)
//            }
//        }
//    }
}


public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}
