//
//  NextController.swift
//  ASRoam
//
//  Created by Yanfei Yu on 2017/6/5.
//  Copyright © 2017年 Ataluer. All rights reserved.
//

import UIKit

class NextController : UIViewController {
    
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true) {
            print("dismissed")
        }
    }
}
