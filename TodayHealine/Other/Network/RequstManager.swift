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
    static func requst<T: Mappable>(_ urlStr: String, param: [String: Any]) -> Promise<T> {
        return Promise { fulfill, reject in
            Alamofire.request(urlStr, method: HTTPMethod.get, parameters: param).responseJSON { response in
                switch response.result {
                case .success(let value):
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
    
    static func requset(urlStr: String, param: [String: Any], finished: @escaping (_ json
        : Any?, _ error: Error?) -> Void) {
        Alamofire.request(urlStr, method: HTTPMethod.get, parameters: param).responseJSON { response in
            switch response.result {
            case .success(let value):
                finished(value, nil)
            case .failure(let error):
                print(error)
                finished(nil, error)
            }
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
        case .endpoint(param: let param, endPoint: let endPoint):
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
