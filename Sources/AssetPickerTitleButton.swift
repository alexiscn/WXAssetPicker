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
        
        containerView.backgroundColor = UIColor(red: 76.0/255, green: 76.0/255, blue: 76.0/255, alpha: 1.0)
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = true
        
        textLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        textLabel.textColor = UIColor(white: 1.0, alpha: 0.9)
        
        arrowImageView.image = configuration.assets.arrowImage
        arrowImageView.backgroundColor = UIColor(red: 204.0/255, green: 204.0/255, blue: 204.04/255, alpha: 0.8)
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
        
        let titleSize = ((textLabel.text ?? "") as NSString).size(withAttributes: [
            .font: UIFont.systemFont(ofSize: 17, weight: .medium)
        ])
        textLabel.frame = CGRect(x: 12,
                                 y: (32 - titleSize.height)/2.0,
                                 width: titleSize.width,
                                 height: titleSize.height)
        
        arrowImageView.frame = CGRect(x: textLabel.frame.maxX + 6,
                                      y: 6,
                                      width: 20,
                                      height: 20)
        
        let containerWidth = arrowImageView.frame.maxX + 12
        containerView.frame = CGRect(x: (bounds.width - containerWidth)/2.0,
                                     y: (bounds.height - 32)/2.0,
                                     width: containerWidth,
                                     height: 32)
    }
    
    func updateTitle(_ title: String) {
        
        textLabel.text = title
        setNeedsLayout()
    }
}
