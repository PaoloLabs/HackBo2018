//
//  AppDelegate.swift
//  HackBo
//
//  Created by Paolo Ramos Mendez on 7/28/18.
//  Copyright © 2018 PaoloLabs. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.sharedManager().enable = true
        
//        // Override point for customization after application launch.
//        let center = UNUserNotificationCenter.current()
//        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
//            // Enable or disable features based on authorization.
//            if error != nil {
//                print("Request authorization failed!")
//            } else {
//                print("Request authorization succeeded!")
//                self.showAlert()
//            }
//        }
        
//        //creating the notification content
//        let content = UNMutableNotificationContent()
//
//        //adding title, subtitle, body and badge
//        content.title = "Hey this is Simplified iOS"
//        content.subtitle = "iOS Development is fun"
//        content.body = "We are learning about iOS Local Notification"
//        content.badge = 1
//
//        //getting the notification trigger
//        //it will be called after 5 seconds
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
//
//        //getting the notification request
//        let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
//
//        //adding the notification to notification center
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
        return true
    }

    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // code taken from http://stackoverflow.com/questions/37956482/registering-for-push-notifications-in-xcode-8-swift-3-0
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("success in registering for remote notifications with token \(deviceTokenString)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("failed to register for remote notifications: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("Received push notification: \(userInfo)")
        let aps = userInfo["aps"] as! [String: Any]
        print("\(aps)")
    }
}

