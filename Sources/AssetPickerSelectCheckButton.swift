//
//  AssetPickerSelectCheckButton.swift
//  WeChatSwift
//
//  Created by xu.shuifeng on 2019/8/21.
//  Copyright © 2019 alexiscn. All rights reserved.
//

import UIKit

class AssetPickerSelectCheckButton: UIButton {
    
    private let selectionNumberLabel: UILabel
    
    private let selectionImageView: UIImageView
    
    private let normalSelectView: UIView
    
    override init(frame: CGRect) {
        
        selectionImageView = UIImageView()
        selectionImageView.image = UIImage(named: "FriendsSendsPicturesSelectIcon_27x27_")
        
        normalSelectView = UIView()
        normalSelectView.layer.backgroundColor = UIColor(white: 0, alpha: 0.3).cgColor
        normalSelectView.layer.cornerRadius = 1.5
        normalSelectView.layer.cornerRadius = 12
        
        selectionNumberLabel = UILabel()
        selectionNumberLabel.isHidden = true
        selectionNumberLabel.layer.cornerRadius = 11.5
        selectionNumberLabel.layer.masksToBounds = true
        selectionNumberLabel.clipsToBounds = true
        selectionNumberLabel.frame = CGRect(x: 2, y: 2, width: 23, height: 23)
        selectionNumberLabel.backgroundColor = UIColor(red: 26.0/255, green: 173.0/255, blue: 25.0/255, alpha: 1.0)
        
        super.init(frame: frame)
        
        imageView?.isHidden = true
        titleLabel?.isHidden = true
        
        addSubview(normalSelectView)
//        addSubview(selectionImageView)
        addSubview(selectionNumberLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        normalSelectView.frame = CGRect(x: 18, y: 8, width: 24, height: 24)
        selectionNumberLabel.frame = CGRect(x: 2, y: 2, width: 24, height: 24)
    }
    
    private func startPopupAnimation() {
        selectionNumberLabel.layer.removeAllAnimations()
        let animation = CAKeyframeAnimation(keyPath: "transform")
        animation.duration = 0.6
        animation.keyTimes = [0, 0.8, 0.9, 1.0]
        animation.values = [1, 1.1, 0.9, 1.0]
        selectionNumberLabel.layer.add(animation, forKey: "popup")
    }
    
}
