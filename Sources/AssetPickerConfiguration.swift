//
//  AssetPickerOptions.swift
//  WXAssetPicker
//
//  Created by alexiscn on 2019/8/16.
//  Copyright © 2019 alexiscn. All rights reserved.
//

import Foundation
import Photos

public struct AssetType: OptionSet {
    
    public var rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    static let image = AssetType(rawValue: 1 << 0)
    
    static let video = AssetType(rawValue: 1 << 1)
    
    static let gif = AssetType(rawValue: 1 << 2)
    
    static let all: AssetType = [.image, .video, .gif]
}

public class AssetPickerConfiguration {
    
    public struct Layouts {
        
        public var bottomBarHeight: CGFloat = 56.0
        
    }
    
    public struct Assets {
        
        /// The background color of the asset picker. The default color is `#323232`.
        public var backgroundColor = UIColor(red: 50.0/255, green: 50.0/255, blue: 50.0/255, alpha: 1.0)
        
        public var radioButtonNormalImage: UIImage? = Utility.image(named: "wx_asset_picker_select_24x24_")
        
        public var radioButtonSelectedColor: UIColor = UIColor(red: 0.027, green: 0.757, blue: 0.376, alpha: 1.0)
        
        public var originCheckedImage: UIImage? = Utility.image(named: "wx_asset_picker_checked_20x20_")
        
        public var closeButtonImage: UIImage? = Utility.image(named: "wx_asset_picker_close_24x24_")
        
        public var arrowImage: UIImage? = Utility.image(named: "wx_asset_picker_arrow_20x20_")
    }
    
    public var assets = Assets()
    
    public var layouts = Layouts()
    
    public var assetTtype: AssetType = .all
    
    public var compressionType: AssetCompressionType = .default
    
    public var maximumImageCount: Int = 9
    
    public var doneButtonTitle: String = "Done"
    
    public var showBottomBar: Bool = true
    
    public static func `default`() -> AssetPickerConfiguration {
        let configuration = AssetPickerConfiguration()
        configuration.showBottomBar = true
        configuration.doneButtonTitle = "Done"
        return configuration
    }
}

public enum AssetCompressionType {
    case `default`
    case session
    case moment
}
