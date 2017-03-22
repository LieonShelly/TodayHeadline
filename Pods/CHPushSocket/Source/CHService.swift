//
//  CHService.swift
//  CHPushWebSocketSDK
//
//  Created by lieon on 2016/12/13.
//  Copyright © 2016年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

 public class CHService: NSObject {
    public class func setupSocket(appKey: String, appSecret: String, deviceToken: String, applePushToken: String? = nil) {
        CHWebSocket.shared.setup(appKey: appKey, appSecret: appSecret, deviceToken: deviceToken, applePushToken: applePushToken)
    }
    
    public class func registerRemoteNotification() {
        CHPushService.registerRemoteNotification()
    }
}
