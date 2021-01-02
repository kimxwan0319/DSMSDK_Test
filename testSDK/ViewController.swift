//
//  ViewController.swift
//  testSDK
//
//  Created by 김수완 on 2021/01/02.
//

import UIKit
import DSMSDK

class ViewController: UIViewController {

    var refreshToken = ""
    var accessToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginWithDSMAuth(_ sender: Any) {
        DSMAUTH.loginWithDSMAuth(vc: self) { (token, error) in
            if let error = error {
                print(error)
            } else {
                print(token!.Access_Token)
                print(token!.Refresh_Token)
                self.accessToken = token!.Access_Token
                self.refreshToken = token!.Refresh_Token
            }
        }
    }
    
    @IBAction func tokenRefresh(_ sender: Any){
        DSMAUTH.tokenRefresh(refresh_token: refreshToken){ (access_token, error) in
            if let error = error{
                print(error)
            } else{
                print(access_token!)
            }
        }
    }
    
    @IBAction func getMyInfo(_ sender: Any) {
        DSMAUTH.me(access_token: accessToken){ (user, error) in
            if let error = error{
                print(error)
            } else{
                print(user!.name)
                print(user!.StudentID)
                print(user!.email)
            }
        }
    }


}

