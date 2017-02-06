//
//  FindViewModel.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/26.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import PromiseKit

class FindViewModel {
    
}

extension FindViewModel {
    func loadBanner(finished: @escaping () -> Void) {
        let param = FindRequstParam()
        let req: Promise<Banner> = RequstManager.requst(Router.endpointWithoutToken(param: param, endPoint: FindRequestPath.banner))
        req.then { _ -> Void in
            
        }.catch { error in
            print(error)
        }
    }
}

extension FindViewModel {
    func numberOfSections() -> Int {
        return 2
    }
    
    func numberOfRows(in section: Int) -> Int {
        return section == 1 ? 40: 4
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func heightForHeader(in section: Int) -> CGFloat {
        if section == 1 {
            return 40.0
        } else {
            return 0.0
        }
    }
}
