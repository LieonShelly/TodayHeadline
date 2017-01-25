//
//  HomeViewModel.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/24.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import ObjectMapper

class HomeViewModel {
    lazy var banners: [Banner] = [Banner]()
    
}

extension HomeViewModel {
    func loadBanner(finished: @escaping (Void) -> Void) {
        let para = ["app_id": "com.jzyd.BanTang",
                    "app_installtime": "1482905598",
                    "app_versions": "5.9.5",
                    "channel_name": "appStore",
                    "client_id": "bt_app_ios",
                    "client_secret": "9c1e6634ce1c5098e056628cd66a17a5",
                    "oauth_token": "4150e754a624ecdc255ad1d13f6287bc",
                    //"last_get_time":"1463238932",
            
            "os_versions": "10.2",
            "screensize": "750",
            "track_device_info": "iPhone8,4",
            "track_device_uuid": "DE964894-8C6F-48BF-9F6C-A47167353EAC",
            "track_deviceid": "BAEA9AD2-16E3-4D12-8E28-4EB9F15A1412",
            "track_user_id": "2777434",
            "v": "24",
            "page": "0",
            "pagesize": "20"
        ]
        
        RequstManager.requset(urlStr: "http://open3.bantangapp.com/recommend/operationElement?", param: para) {[unowned self] (json, error) in
            guard let dict = json as? [String: Any], let dataDict = dict["data"] as? [String: Any], let bannerArray = dataDict["banner"] as? [[String: Any]] else { return }
            for bannerDictt: [String: Any] in bannerArray {
                guard let banner = Mapper<Banner>().map(JSON: bannerDictt) else { continue }
                self.banners.append(banner)
            }
            finished()
        }
    }
}
