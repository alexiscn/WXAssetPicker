//
//  AssetPickerTitleButton.swift
//  WXAssetPicker
//
//  Created by alexiscn on 2021/1/11.
//

import UIKit

class AssetPickerTitleButton: UIButton {
    
    private let containerView = UIView()
    
    private let textLabel = UILabel()
    
    private let arrowImageView = UIImageView()
    
    init(frame: CGRect, configuration: AssetPickerConfiguration) {
        
        containerView.backgroundColor = UIColor(white: 76.0/255, alpha: 1.0)
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = true
        
        textLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        textLabel.textColor = UIColor(white: 1.0, alpha: 0.9)
        
        arrowImageView.image = configuration.assets.arrowImage
        arrowImageView.backgroundColor = UIColor(white: 204.0/255, alpha: 0.8)
        arrowImageView.layer.cornerRadius = 10
        arrowImageView.clipsToBounds = true
        
        super.init(frame: frame)
        
        addSubview(containerView)
        
        containerView.addSubview(textLabel)
        containerView.addSubview(arrowImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        
        arrowImageView.frame = CGRect(x: 0, y: 6, width: 20, height: 20)
    }
    
    func updateTitle(_ title: String) {
        
        textLabel.text = title
        
    }
}
