//
//  RecommendViewController.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/16.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

/**
 http://a3.bytecdn.cn/article/content/15/2/6376433278118789634/6376433278118789634/1/?
 version_code=5.9.4&
      app_name=news_article
      &vid=9C031438-FD95-48AB-A043-0AEC587BD0D4
      &device_id=25295014168
 &channel=App%20Store
 &resolution=750*1334
 &aid=13
 &ab_version=101967,100770,100743,102063,101786,101988,101848,101827,102168,101533,100845,97143,100729,31210,102123,101558,92441,101295,102165,101000,102111,100961,100755,101710,98040,100825,101405,101310,101799
 &ab_feature=z1&openudid=3d20c6f2d7de79d11eae5717e72cc830c5beb076
 &live_sdk_version=1.3.0
 &idfv=9C031438-FD95-48AB-A043-0AEC587BD0D4
 &ac=WIFI&os_version=10.2
 &ssmix=a
 &device_platform=iphone
 &iid=7429513344
 &ab_client=a1,f2,f7,e1
 &device_type=iPhone%207
 &idfa=B8288A9B-027C-4AC8-9B43-8AB19F637125
 **/
import UIKit
import Alamofire
import PromiseKit
import LRefresh

class RecommendViewController: HomeBaseTableViewController {
    fileprivate lazy var refresh: LRefreshControl = {
        let refresh = LRefreshControl()
        return refresh
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor
         = UIColor.random()
        let param = TestParam()
        let req: Promise<[News]> = RequstManager.requst(Router.endpoint(param: nil, endPoint: param))
        req.then { obj -> Void in
            print(obj.count)
            
            }.always {
                
            }.catch { error in
            print(error)
        }
        tableView.addSubview(refresh)
  }
}

extension RecommendViewController {
   
}
