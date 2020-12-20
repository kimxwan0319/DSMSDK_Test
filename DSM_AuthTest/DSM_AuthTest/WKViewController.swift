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
        let request: URLRequest = URLRequest.init(url: NSURL.init(string: "http://192.168.137.1:3001/external/login?redirect_url=http://localhost:3000&client_id=123456")! as URL, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 10)
        wkWebView.load(request)
        
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
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("1")
    }
}
