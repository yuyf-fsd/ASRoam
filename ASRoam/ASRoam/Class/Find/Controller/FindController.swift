//
//  FindController.swift
//  ASRoam
//
//  Created by Yanfei Yu on 2017/6/16.
//  Copyright © 2017年 Ataluer. All rights reserved.
//

import UIKit
import WebKit

class FindController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    @IBOutlet weak var backBtn: UIButton!
    var webView: WKWebView!
    
    func loadSubView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect(x:0, y:64, width:self.view.frame.width, height:self.view.frame.height-64), configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view = webView
        
        let myURL = URL(string: "https://www.baidu.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSubView()        
    }
    
    @IBAction func backAction(_ sender: Any) {
        print("back from find")
    }
}
