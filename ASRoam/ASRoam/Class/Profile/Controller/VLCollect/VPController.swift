//
//  VPController.swift
//  ASRoam
//
//  Created by Yanfei Yu on 2017/6/24.
//  Copyright © 2017年 Ataluer. All rights reserved.
//

import UIKit
import BMPlayer

class VPController: UIViewController {

    @IBOutlet weak var player: BMCustomPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player.backBlock = { [unowned self] (isFullScreen) in
            if isFullScreen == true {
                return
            }
            let _ = self.navigationController?.popViewController(animated: true)
        }
        
//        let asset = BMPlayerResource(url: URL(string: "http://baobab.wdjcdn.com/1457162012752491010143.mp4")!,
//                                     name: "周末号外丨中国第一高楼",
//                                     cover: nil,
//                                     subtitle: nil)
        let asset = BMPlayerResource(url: URL(string: "http://baobab.wdjcdn.com/1457162012752491010143.mp4")!,
                                     name: "周末号外丨中国第一高楼",
                                     cover: nil,
                                     subtitle: nil)
        player.setVideo(resource: asset)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
