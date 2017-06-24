//
//  VLController.swift
//  ASRoam
//
//  Created by Yanfei Yu on 2017/6/23.
//  Copyright © 2017年 Ataluer. All rights reserved.
//

import UIKit
import BMPlayer

class VLController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var videoTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        initTable()
    }
    
    func initTable() {
        videoTable.delegate = self
        videoTable.dataSource = self
        videoTable.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        videoTable.tableFooterView = UIView()
        //mineTable.backgroundColor = UIColor.lightGray
    }
    
    
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCellIdentifier", for: indexPath)
        
        cell.textLabel?.text = "999"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        playVideo(indexPath)
    }
    
    func playVideo(_ indexPath: IndexPath) {
        print("555\(indexPath.row)")
        // play
        //self.perf
        
        self.performSegue(withIdentifier: "pushVPlayer", sender: nil)
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "VPController" {
            //代码跳转，storyboard中连接了segue，则这里不需要重复调用
            let sb = UIStoryboard(name: "Profile", bundle:nil)
            let vc = sb.instantiateViewController(withIdentifier: "VPController") as! VLController
            //vc
            //self.show(vc, sender: nil)
        }
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
