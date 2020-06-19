//
//  AssetPickerOptions.swift
//  WXAssetPicker
//
//  Created by xu.shuifeng on 2019/8/16.
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

public class AssetPickerOptions {
    
    public var assetTtype: AssetType = .all
    
    public var compressionType: AssetCompressionType = .default
    
    public var maximumImageCount: Int = 9
    
    public var doneButtonTitle: String = "Done"
    
    public var showBottomBar: Bool = true
    
    public var bottomBarHeight: CGFloat = 45.0
    
    public static func `default`() -> AssetPickerOptions {
        let configuration = AssetPickerOptions()
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
