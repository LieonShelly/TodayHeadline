//
//  FindViewModel.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/26.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import Foundation
import PromiseKit

class FindViewModel {
    
}

extension FindViewModel {
    func loadBanner(finished: @escaping () -> Void) {
        let param = FindRequstParam()
        let req: Promise<Banner> = RequstManager.requst(Router.endpointWithoutToken(param: param, endPoint: FindRequestPath.banner))
    }
}
