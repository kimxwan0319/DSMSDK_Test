//
//  WKViewController.swift
//  DSM_AuthTest
//
//  Created by 김수완 on 2020/12/20.
//

import UIKit
import WebKit
import Alamofire

class WKViewController: UIViewController {

    private var _base_URL = ""
    
    private var _client_id: String = ""
    private var _client_secret: String = ""
    private var _redirctURL: String = ""
    
    private var wkWebView: WKWebView!
     
    override func viewDidLoad() {
        super.viewDidLoad()

        wkWebView = WKWebView(frame: self.view.frame)
        wkWebView.navigationDelegate = self
        wkWebView.uiDelegate = self
        
        settingWKView()
    }
    
    public func initialize(base_URL: String ,client_id: String, client_secret: String, redirctURL: String){
        _base_URL = base_URL
        _client_id = client_id
        _client_secret = client_secret
        _redirctURL = redirctURL
    }
    
    
}

extension WKViewController : WKUIDelegate, WKNavigationDelegate {
    func settingWKView(){
        let URL = "http://192.168.43.93:3000/external/login?redirect_url="+_redirctURL+"&client_id"+_client_id
        
        let request: URLRequest = URLRequest.init(url: NSURL.init(string:URL)! as URL, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 10)
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
            let url = wkWebView.url
            print("\(url)")
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func getToken(){
        let requestBody : [String:String] = [
            "client_id": _client_id,
            "client_secret": _client_secret
        ]
        
        AF.request(_base_URL+"/token", method: .post, parameters: requestBody, encoder: JSONParameterEncoder.default).validate().responseJSON(completionHandler:{ res in
            print(res)
        })
    }
}

