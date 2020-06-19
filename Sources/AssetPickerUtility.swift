//
//  AssetPickerUtility.swift
//  WXAssetPicker
//
//  Created by xu.shuifeng on 2020/5/28.
//

import Foundation

class AssetPickerUtility {
    
    static var bundle: Bundle? = {
        if let url = Bundle(for: AssetPickerUtility.self).url(forResource: "Media", withExtension: "bundle") {
            return Bundle(url: url)
        }
        return nil
    }()
    
    static func image(named: String) -> UIImage? {
        return UIImage(named: named, in: bundle, compatibleWith: nil)
    }
}
