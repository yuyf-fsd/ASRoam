//
//  FollowController.swift
//  ASRoam
//
//  Created by Yanfei Yu on 2017/6/16.
//  Copyright © 2017年 Ataluer. All rights reserved.
//

import UIKit
import WebKit

class FollowController : UIViewController, WKUIDelegate {
    var webView1: WKWebView!
    var webView2: WKWebView!
    
    func loadSubView() {
        let webConfiguration = WKWebViewConfiguration()
        let myURL = URL(string: "https://www.baidu.com")
        let myRequest = URLRequest(url: myURL!)
        webView1 = WKWebView(frame: CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height/2), configuration: webConfiguration)
        webView1.uiDelegate = self
        webView1.load(myRequest)
        self.view.addSubview(webView1)
        
        let webConfiguration2 = WKWebViewConfiguration()
        let myURL2 = URL(string: "https://www.baidu.com")
        let myRequest2 = URLRequest(url: myURL2!)
        webView2 = WKWebView(frame: CGRect(x:0, y:self.view.frame.height/2+5, width:self.view.frame.width, height:self.view.frame.height/2-5), configuration: webConfiguration2)
        webView2.uiDelegate = self
        webView2.load(myRequest2)
        self.view.addSubview(webView2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSubView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
