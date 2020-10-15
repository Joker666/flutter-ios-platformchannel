//
//  AppDelegate.swift
//  HelloFlutter
//
//  Created by Hasan Rafi on 10/14/20.
//

import UIKit
import Flutter
import FlutterPluginRegistrant

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    lazy var flutterEngine = FlutterEngine(name: "my flutter engine")
    private var lifeCycleDelegate: FlutterPluginAppLifeCycleDelegate?
    
    override init() {
        super.init()
        lifeCycleDelegate = FlutterPluginAppLifeCycleDelegate()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        flutterEngine.run(withEntrypoint: nil)
        GeneratedPluginRegistrant.register(with: flutterEngine)
        if let lo = launchOptions {
            return lifeCycleDelegate?.application(application, didFinishLaunchingWithOptions: lo) ?? false
        }
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        lifeCycleDelegate?.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any],
            fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        lifeCycleDelegate?.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
    }

    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return lifeCycleDelegate?.application(application, open: url, options: options) ?? false
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return lifeCycleDelegate?.application(application, handleOpen: url) ?? false
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return lifeCycleDelegate?.application(application,open: url, sourceApplication: sourceApplication!, annotation: annotation) ?? false
    }
    
    func application(_ application: UIApplication,performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        lifeCycleDelegate?.application(application, performActionFor: shortcutItem, completionHandler: completionHandler)
    }

    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        lifeCycleDelegate?.application(application, handleEventsForBackgroundURLSession: identifier, completionHandler: completionHandler)
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        lifeCycleDelegate?.application(application, performFetchWithCompletionHandler: completionHandler)
    }

    func addApplicationLifeCycle(_ delegate: (NSObjectProtocol & FlutterPlugin)?) {
        lifeCycleDelegate?.add(delegate!)
    }
}

