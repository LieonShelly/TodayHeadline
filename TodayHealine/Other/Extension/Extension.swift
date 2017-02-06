//
//  Extension.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/16.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReuseableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T:ViewNameReusable {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIndentifier, for: indexPath) as? T else {
             fatalError("Could not dequeue cell with identifier: \(T.reuseIndentifier)")
        }
        return cell
    }
    
    func dequeueReuseableHeaderFooter<T: UITableViewHeaderFooterView>(for indexPath: IndexPath) -> T where T: ViewNameReusable {
         guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIndentifier) as? T else { fatalError("Could not dequeue HeaderFooterView with identifier: \(T.reuseIndentifier)")  }
        return cell
    }
}

extension UITabBar {
    static let height: CGFloat = 44
}

extension UIScreen {
    static let width: CGFloat = UIScreen.main.bounds.width
    static let height: CGFloat = UIScreen.main.bounds.height
}

extension UIColor {
    static func random() -> UIColor {
        let r = arc4random_uniform(256)
        let g = arc4random_uniform(256)
        let b = arc4random_uniform(256)
        return  UIColor(red: CGFloat(r)/256.0, green: CGFloat(g)/256.0, blue: CGFloat(b)/256.0, alpha: 1.0)
    }
    
    static func colorFromHex(_ rgbValue: UInt32, alpha: Double = 1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/255.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/255.0
        let blue = CGFloat(rgbValue & 0xFF)/255.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
