//
//  DelegateDispatcher.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/3/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

public class ZPDelegateDispatcher: NSObject, UIApplicationDelegate {
    
    //MARK: Properties
    private (set) lazy var allService: [DelegateBaseProtocol] = [
        UIAppDelegate.shareInstance
    ]
    
    //MARK: UIApplicationDelegate
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        for service in self.allService {
            _ = service.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
        return true
    }
    
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        for service in self.allService{
            if service.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation) {
                return true;
            }
        }
        return false;
    }
    
    public func applicationWillResignActive(_ application: UIApplication) {
        for service in self.allService {
            service.applicationWillResignActive(application)
        }
    }
    
    public func applicationWillEnterForeground(_ application: UIApplication) {
        for service in self.allService {
            service.applicationWillEnterForeground(application)
        }
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        for service in self.allService {
            service.applicationDidBecomeActive(application)
        }
    }
    
    public func applicationDidEnterBackground(_ application: UIApplication) {
        for service in self.allService {
            service.applicationDidEnterBackground(application)
        }
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        for service in self.allService {
            service.applicationWillTerminate(application)
        }
    }
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        for service in self.allService {
            service.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        }
    }
    
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        for service in self.allService {
            service.application(application, didReceiveRemoteNotification: userInfo)
        }
    }
    public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        for service in self.allService {
            if service.application(application, continue: userActivity) {
                return true
            }
        }
        return false
    }
    
    @available(iOS 9.0, *)
    public func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        for service in self.allService {
            service.application(application, performActionFor: shortcutItem, completionHandler: completionHandler)
        }
    }
}
