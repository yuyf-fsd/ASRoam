//
//  ProfileController.swift
//  ASRoam
//
//  Created by Yanfei Yu on 2017/6/16.
//  Copyright © 2017年 Ataluer. All rights reserved.
//

import UIKit
import WebKit

let UserInfoCellID = "UserInfoCell"
let MineItemCellID = "MineItemCell"

class ProfileController: UIViewController, WKUIDelegate, WKNavigationDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mineTable: UITableView!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadSubView()
        initTable()
        
        // TODO: dd
    }
    
    func initTable() {
        mineTable.delegate = self
        mineTable.dataSource = self
        mineTable.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        mineTable.tableFooterView = UIView()
        //mineTable.backgroundColor = UIColor.lightGray
    }
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 4
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120;
        }
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoCellID) as? UserInfoCell else {
                fatalError("The dequeued cell is not an instance of UserInfoCell.")
            }
            //let cell = UserInfoCell(style: UITableViewCellStyle.default, reuseIdentifier: UserInfoCellID)
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MineItemCellID) as? MineItemCell else {
            fatalError("The dequeued cell is not an instance of MineItemCell.")
        }
        //let cell = MineItemCell(style: UITableViewCellStyle.default, reuseIdentifier: MineItemCellID)
        
        if indexPath.section == 1 {
            if  indexPath.row == 0 {
                cell.titleLabel.text = "我关注的主题"
            } else if  indexPath.row == 1 {
                cell.titleLabel.text = "我的收藏"
            } else if  indexPath.row == 2 {
                cell.titleLabel.text = "动态通知"
            } else if  indexPath.row == 3 {
                cell.titleLabel.text = "小秘书"
            }
        }
        else {
            cell.titleLabel.text = "我创建的主题"
        }
        //cell.backgroundColor = UIColor.darkGray;
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 && indexPath.row == 1 {
            self.performSegue(withIdentifier: "ShowVL", sender: nil)
                        
        }
    }
    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowVL" {
            //代码跳转，storyboard中连接了segue，则这里不需要重复调用
            return;
            //let sb = UIStoryboard(name: "Profile", bundle:nil)
            //let vc = sb.instantiateViewController(withIdentifier: "VLController") as! VLController
            //self.show(vc, sender: nil)
        }
    }
}
