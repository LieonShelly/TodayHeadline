//
//  AppDelegate.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/16.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import SnapKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupAppearance()
        setupNotification()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        DataBaseController.saveContext()
    }
}

extension AppDelegate {
    func scheduleNotification() {
        UNUserNotificationCenter.current().delegate = self
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "Stay Health"
        content.body = "Just a reminder to eat your favourtite healty food."
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "foodCategory"
         guard let path = Bundle.main.path(forResource: "Ap", ofType: "png") else { return  }
        let url = URL(fileURLWithPath: path)
        guard let attachment = try? UNNotificationAttachment(identifier: "logo", url: url, options: nil) else { return }
        content.attachments = [attachment]
        let request = UNNotificationRequest(identifier: "foodNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) { (err) in
            print(err ?? "")
        }
    }
    
    fileprivate func setupNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (authorized, error) in
            if !authorized {
                print("App is useless because you did not allow notifications.")
            }
        }
        let fruitAction = UNNotificationAction(identifier: "addFruit", title: "Add a piece of fruit", options: [])
        let vegiAction = UNNotificationAction(identifier: "addVegetable", title: "Add a piece of vegetable", options: [])
        let category = UNNotificationCategory(identifier: "foodCategory", actions: [fruitAction, vegiAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    fileprivate func setupAppearance() {
        let tabBar = UITabBar.appearance()
        tabBar.tintColor = UIColor.colorFromHex(0xff0000)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let foodItem = Food(context: DataBaseController.getContext())
        foodItem.added = NSDate()
        
        if response.actionIdentifier == "addFruit" {
            foodItem.type = "Fruit"
        } else { // Vegetable
            foodItem.type = "Vegetable"
        }
        
        DataBaseController.saveContext()
        scheduleNotification()
        
        completionHandler()
    }
}
