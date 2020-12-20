//
//  ViewController.swift
//  DSM_AuthTest
//
//  Created by 김수완 on 2020/12/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func moveNext(_ sender: Any) {
        let VC = WKViewController()
        present(VC, animated: true)
    }
}

