//
//  AssetPickerUtility.swift
//  WXAssetPicker
//
//  Created by alexiscn on 2020/5/28.
//

import UIKit

class Utility {
    
    static var bundle: Bundle? = {
        if let url = Bundle(for: Utility.self).url(forResource: "Media", withExtension: "bundle") {
            return Bundle(url: url)
        }
        return nil
    }()
    
    static func image(named: String) -> UIImage? {
        return UIImage(named: named, in: bundle, compatibleWith: nil)
    }
}
