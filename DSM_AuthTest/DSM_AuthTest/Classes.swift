//
//  Classes.swift
//  DSM_AuthTest
//
//  Created by 김수완 on 2020/12/22.
//

import Foundation
import Alamofire

final public class SWHSDK{
    
    public static let shared = SWHSDK()
    
    private let AuthorizationServer : String = "http://54.180.98.91:8080"
    
    private var _client_id : String? = nil
    private var _client_secret : String? = nil
    private var _redirctURL : String? = nil
    
    public init(){
        _client_id = nil
        _client_secret = nil
        _redirctURL = nil
    }
    
    public static func initSDK(client_id : String, client_secret : String, redirctURL : String){
        SWHSDK.shared.initialize(client_id : client_id, client_secret : client_secret, redirctURL : redirctURL)
    }
    
    private func initialize(client_id : String, client_secret : String, redirctURL : String){
        _client_id = client_id
        _client_secret = client_secret
        _redirctURL = redirctURL
    }
}

extension SWHSDK{
    // login
    
    func loginWithSWHAuth(_ vc: UIViewController){
        let VC = WKViewController()
        VC.initialize(base_URL: AuthorizationServer,
                      client_id: _client_id!,
                      client_secret: _client_secret!,
                      redirctURL: _redirctURL!)
        vc.present(VC, animated: true)
    }
}

extension SWHSDK{
    // API
    func RefreshToken(refresh_token: String){
        AF.request(AuthorizationServer+"/"+now(), method: .get, headers: ["refresh_token": "Bearer "+refresh_token]).validate().responseJSON(completionHandler:{ res in
            
        })
    }
    
    private func now() -> String{
        let formatter_time = DateFormatter()
        formatter_time.dateFormat = "ss"
        let current_time_string = formatter_time.string(from: Date())
        return current_time_string
    }
    
}
