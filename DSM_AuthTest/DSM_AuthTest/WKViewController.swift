//
//  WKViewController.swift
//  DSM_AuthTest
//
//  Created by 김수완 on 2020/12/20.
//

import UIKit
import WebKit

class WKViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    private var wkWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wkWebView = WKWebView(frame: self.view.frame)
        wkWebView.navigationDelegate = self
        wkWebView.uiDelegate = self
        settingWKView()
    }
    
    
    func settingWKView(){
        let request: URLRequest = URLRequest.init(url: NSURL.init(string: "http://10.156.147.110:3000/external/login?redirect_url=https://www.google.com&client_id=qwer")! as URL, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 10)
        wkWebView.load(request)
        
        wkWebView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
        self.view?.addSubview(self.wkWebView!)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        wkWebView.reload()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.url) {
            // Whenever URL changes, it can be accessed via WKWebView instance
            let url = wkWebView.url
            print("\(url)")
        }
    }
    
}
