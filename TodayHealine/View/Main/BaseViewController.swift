//
//  BaseViewController.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/24.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       navigationController?.delegate = self
    }
}

extension BaseViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController == self {
            navigationController.setNavigationBarHidden(true, animated: false)
        } else {
            navigationController.setNavigationBarHidden(false, animated: false)
        }
    }
}
