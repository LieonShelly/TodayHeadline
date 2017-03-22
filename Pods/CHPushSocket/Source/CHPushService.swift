//
//  CHPushService.swift
//  CHWebSocketSDK
//
//  Created by lieon on 2016/12/6.
//  Copyright © 2016年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

private let service = CHPushService()
public class CHPushService:NSObject {
   public class func registerRemoteNotification() {
        setupiOS9Notification(types: [.alert, .badge, .sound])
    }
    
   private class func setupiOS9Notification(types: UIUserNotificationType) {
        let setting = UIUserNotificationSettings(types: types, categories: nil)
        UIApplication.shared.registerUserNotificationSettings(setting)
        UIApplication.shared.registerForRemoteNotifications()
    }
}



