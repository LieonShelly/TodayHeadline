//
//  RequstManager.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/17.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import PromiseKit
import Alamofire
import ObjectMapper

class RequstManager: NSObject {
    static func requst<T: Mappable>(_ router: Router) -> Promise<[T]> {
        return Promise { fulfill, reject in
           Alamofire.request(router.urlRequest!).validate().responseJSON(completionHandler: { dataResponse in
            switch dataResponse.result {
            case .success(let value):
                guard let json = value as? [String: Any] else { return }
                guard let dataArray = json["data"] as? [[String : Any]] else { return }
                print(dataArray)
                let obj = Mapper<T>().mapArray(JSONArray: dataArray)
                fulfill(obj!)
            case .failure(let error):
                print(error)
            }
           })
    }
    }
}

enum Router: URLRequestConvertible {
    var method: HTTPMethod {
        return .get
    }
    case endpoint(param: Mappable?, endPoint: EndPointProtocol)
    func asURLRequest() throws -> URLRequest {
        switch self {
        case .endpoint(param: let param , endPoint: let endPoint):
            let url = URL(string: endPoint.baseURL)!
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            // 可以在此把param进行加密
            return  try JSONEncoding.default.encode(request, with: param?.toJSON()).urlRequest!
        }
    }
}


protocol EndPointProtocol {
    var baseURL: String { get }
    func URL() -> String
}

extension EndPointProtocol {
    func URL() -> String {
        return baseURL
    }
}
