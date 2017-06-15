//
//  LiveController.swift
//  ASRoam
//
//  Created by Yanfei Yu on 2017/6/5.
//  Copyright © 2017年 Ataluer. All rights reserved.
//

import UIKit

class LiveController : UIViewController {
    let initValue = 11
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("777 \(initValue)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var count = 0
        count  = count + 1
        print(count)
    }
    
    override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
    }
    
    @IBAction func jumpAction(_ sender: Any) {
        print("push")
    }
    @IBAction func presentAction(_ sender: Any) {
        print("present")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("666 \(segue.identifier)")
    }
}
