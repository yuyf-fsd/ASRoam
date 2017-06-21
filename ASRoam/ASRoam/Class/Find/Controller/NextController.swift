//
//  NextController.swift
//  ASRoam
//
//  Created by Yanfei Yu on 2017/6/5.
//  Copyright © 2017年 Ataluer. All rights reserved.
//

import UIKit
import WebKit

class NextController : UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    
    var webView1: WKWebView!
    var webView2: WKWebView!
    
    func loadSubView() {
        let webConfiguration = WKWebViewConfiguration()
        webView1 = WKWebView(frame: CGRect(x:0, y:64, width:self.view.frame.width, height:self.view.frame.height/2-64), configuration: webConfiguration)
        webView1.uiDelegate = self
    
        let myURL = URL(string: "https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView1.load(myRequest)
        self.view.addSubview(webView1)
        
        webView2 = WKWebView(frame: CGRect(x:0, y:self.view.frame.height/2+5, width:self.view.frame.width, height:self.view.frame.height/2-5), configuration: webConfiguration)
        webView2.uiDelegate = self
        let myURL2 = URL(string: "https://www.baidu.com")
        let myRequest2 = URLRequest(url: myURL2!)
        webView2.load(myRequest2)
        self.view.addSubview(webView2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSubView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("##viewDidAppear")
        //self.view.addSubview(wkWebView2)
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true) {
            print("dismissed")
        }
    }
    
    //MARK:- WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
    }
}
