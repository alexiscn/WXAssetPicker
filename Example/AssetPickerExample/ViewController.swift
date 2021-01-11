//
//  ViewController.swift
//  AssetPickerExample
//
//  Created by xu.shuifeng on 2020/5/26.
//  Copyright © 2020 alexiscn. All rights reserved.
//

import UIKit
import WXAssetPicker

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonClicked(_ sender: Any) {
        
        let assetPicker = AssetPickerViewController()
        let nav = UINavigationController(rootViewController: assetPicker)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
    }
    

}

