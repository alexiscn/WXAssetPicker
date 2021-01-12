//
//  AssetPickerTitleButton.swift
//  WXAssetPicker
//
//  Created by alexiscn on 2021/1/11.
//

import UIKit

class AssetPickerTitleButton: UIButton {
    
    private let textLabel = UILabel()
    
    private let arrowImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textLabel)
        addSubview(arrowImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
