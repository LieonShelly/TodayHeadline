//
//  HomeNaviBar.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/25.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

class HomeNaviBar: UIView {
    @IBOutlet weak fileprivate var searchButton: UIButton!
    @IBOutlet weak fileprivate var emailButton: UIButton!
    @IBOutlet weak fileprivate var searchBar: UISearchBar!
    @IBOutlet weak var searchBarLeadingCons: NSLayoutConstraint!
    @IBOutlet weak var searchBarTrailCons: NSLayoutConstraint!
}

extension HomeNaviBar {
    static func naviBar() -> HomeNaviBar {
        let bundle = Bundle.main.loadNibNamed("HomeNaviBar", owner: nil, options: nil)
        guard let view = bundle?.first as? HomeNaviBar else { return HomeNaviBar() }
        return view
    }
    
    func setup(opacity: CGFloat) {
        backgroundColor = UIColor(white: 1, alpha: opacity)
        UIView.animate(withDuration: 0.1) {
            if opacity > 0.7 {
                self.searchBar.frame.origin.x = 20
            } else {
                self.searchBar.frame.origin.x = -2000
                
            }
        }
    }
}

extension HomeNaviBar {
    override func awakeFromNib() {
        super.awakeFromNib()
        searchBar.placeholder = "搜索值得买的好物"
        backgroundColor = UIColor(white: 1, alpha: 0)
        self.searchBar.frame.origin.x = -2000
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
