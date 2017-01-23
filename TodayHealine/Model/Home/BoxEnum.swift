//
//  BoxEnum.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/22.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import Foundation
import ObjectMapper

enum NewsModelBox {
    case stickop(NoImageNews)
    case recomondView(RecomandViewNews)
    case oneImage(OneImageNews)
    case threeImage(ThreeImageNews)
    
    init(model: News) {
        switch model.cellType {
        case .noImage:
            self = .stickop(NoImageNews())
        case .oneImage:
            self = .oneImage(OneImageNews())
        case .threeImage:
            self = .threeImage(ThreeImageNews())
        case .recommandVideo:
            self = .recomondView(RecomandViewNews())
        }
    }
}
