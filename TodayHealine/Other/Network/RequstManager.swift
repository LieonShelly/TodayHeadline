//
//  RequstManager.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/17.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//  swiftlint:disable force_unwrapping

import UIKit
import PromiseKit
import Alamofire
import ObjectMapper

class RequstManager: NSObject {
    static func requst<T: Mappable>(_ router: Router) -> Promise<T> {
        return Promise { fulfill, reject in
            Alamofire.request(router.URLString, method: .post, parameters: router.param?.toJSON()).responseJSON { response in
                switch response.result {
                    case .success(let value):
//                        print(value)
                        guard let json = value as? [String: Any], let dataJson = json["data"] as? [String: Any] else { return }
                        guard let obj = Mapper<T>().map(JSON: dataJson) else { return }
                       
                        fulfill(obj)
                    case .failure(let error):
                        print(error)
                        reject(error)
                    }
            }
       }
    }
}
