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
    
    public var isVerifiedVP : Bool?
    public var fileURL : String?
    public var vTitle : String?
    @IBOutlet weak var player: BMCustomPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player.backBlock = { [unowned self] (isFullScreen) in
            if isFullScreen == true {
                return
            }
            let _ = self.navigationController?.popViewController(animated: true)
        }
        
        var urlString : URL!
        if  self.isVerifiedVP == false {
            urlString = URL(string: fileURL!)! as URL
        } else {
            urlString = URL(fileURLWithPath: fileURL!)
        }
        
        print("## video url: \(urlString)")
        let asset = BMPlayerResource(url: urlString as URL, name: vTitle!, cover: nil, subtitle: nil)
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
