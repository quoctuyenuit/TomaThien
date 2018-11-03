//
//  DelegateBaseProtocol.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/3/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

protocol DelegateBaseProtocol {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable: Any]?) -> Bool
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool
    
    func applicationWillResignActive(_ application: UIApplication)
    
    func applicationDidBecomeActive(_ application: UIApplication)
    
    func applicationDidEnterBackground(_ application: UIApplication)
    
    func applicationWillEnterForeground(_ application: UIApplication)
    
    func applicationWillTerminate(_ application: UIApplication)
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any])
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity) -> Bool
    @available(iOS 9.0, *)
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void)
}

extension DelegateBaseProtocol {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable: Any]?) -> Bool {
        return false
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return false
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity) -> Bool {
        return false
    }
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
    }
}
