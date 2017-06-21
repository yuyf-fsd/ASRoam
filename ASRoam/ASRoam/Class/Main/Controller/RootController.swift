//
//  RootController.swift
//  ASRoam
//
//  Created by Yanfei Yu on 2017/5/18.
//  Copyright © 2017年 Ataluer. All rights reserved.
//

import UIKit

class RootController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC(stroyName: "Home")
        addChildVC(stroyName: "Follow")
        addChildVC(stroyName: "Find")
        addChildVC(stroyName: "Profile")

        // Do any additional setup after loading the view.
    }
    
    private func addChildVC(stroyName: String){
        //1.初始化控制器
        let vc = UIStoryboard(name: stroyName, bundle: nil).instantiateInitialViewController()!
        //2.添加到tabbar
        addChildViewController(vc)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
