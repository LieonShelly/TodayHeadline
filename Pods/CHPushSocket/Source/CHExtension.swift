//
//  CHExtension.swift
//  CHPushWebSocketSDK
//
//  Created by lieon on 2016/12/16.
//  Copyright © 2016年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

extension String {
    func ch_ToBase64() -> String? {
        guard let data = self.data(using: String.Encoding.utf8) else { return nil }
        let base64String: String = data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        let result = String(base64String)
        return result
    }
    
}

extension Dictionary {
    func toJSONString() -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else { return  ""}
        guard let str = String(data: data, encoding: .utf8) else { return  ""}
        return str
    }
}
