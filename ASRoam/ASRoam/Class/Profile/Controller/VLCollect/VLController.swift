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
    private var isVerifiedVL = false
    var dataSource : Array<String> = []
    var netDataSource = ["http://baobab.wdjcdn.com/14525705791193.mp4", "http://baobab.wdjcdn.com/1457162012752491010143.mp4"]
    var netDataName = ["风格互换: 原来你我相爱", "周末号外| 中国第一高楼"]
    
     // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isVerifiedVL = false
        loadData()
        initTable()
        showAlert()
    }
    
    func loadData() {
        let bundle = Bundle.main
        //let pathURLs = bundle.urls(forResourcesWithExtension: nil, subdirectory: "Videos")
        let paths = bundle.paths(forResourcesOfType: nil, inDirectory: "Videos")
        print("##paths: \(String(describing: paths.first)))")
        for item in paths {
            dataSource.append(item)
        }
    }
    
    func initTable() {
        videoTable.delegate = self
        videoTable.dataSource = self
        videoTable.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        videoTable.tableFooterView = UIView()
    }
    
    func showAlert() {
        // 1 实例化
        let alertVC = UIAlertController(title: "验证后继续", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        // 2 带输入框
        alertVC.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "请输入验证码"
        }
        
        // 3 命令（样式：退出Cancel，警告Destructive-按钮标题为红色，默认Default）
        let alertActionCancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.destructive, handler: {
            action in
            self.navigationController?.popViewController(animated: true)
        })
        let alertActionOK = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: {
            action in
            
            let codeField = alertVC.textFields!.first! as UITextField
            if codeField.text == "doit" {
                self.isVerifiedVL = true
                self.videoTable.reloadData()
            } else if codeField.text == "my" {
                let username = alertVC.textFields!.first! as UITextField
                let password = alertVC.textFields!.last! as UITextField
                print("##用户名：\(String(describing: username.text))，密码：\(String(describing: password.text))")
            } else {
                
                self.navigationController?.popViewController(animated: true)
            }
        })
        alertVC.addAction(alertActionCancel)
        alertVC.addAction(alertActionOK)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    // MARK: - Action
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isVerifiedVL == false {
            return netDataSource.count
        }
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCellIdentifier", for: indexPath)
        
        if self.isVerifiedVL == false {
            cell.textLabel?.text = netDataName[indexPath.row]
        }
        else {
            cell.textLabel?.text = dataSource[indexPath.row].components(separatedBy: "/").last
            print("##\(indexPath.row)")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        playVideo(indexPath)
    }
    
    // MARK: - Navigation
    
    func playVideo(_ indexPath: IndexPath) {
        print("##555 - \(indexPath.row)")
        self.performSegue(withIdentifier: "pushVPlayer", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushVPlayer" {
            let indexPath : IndexPath = sender as! IndexPath
            print("##performSegue pushVPlayer")
            let vpC:VPController = segue.destination as! VPController
            vpC.isVerifiedVP = self.isVerifiedVL
            
            if self.isVerifiedVL == true {
                vpC.fileURL = dataSource[indexPath.row]
                vpC.vTitle = dataSource[indexPath.row].components(separatedBy: "/").last
            }
            else {
                vpC.fileURL = netDataSource[indexPath.row]
                vpC.vTitle = netDataName[indexPath.row]
            }
            
//            let bundle = Bundle.main
//            let pathURL = bundle.path(forResource: "Videos/qidong", ofType: "mp4")
//            vpC.fileURL = pathURL
        }
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
