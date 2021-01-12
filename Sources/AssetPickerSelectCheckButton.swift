//
//  AssetPickerSelectCheckButton.swift
//  WeChatSwift
//
//  Created by alexiscn on 2019/8/21.
//  Copyright © 2019 alexiscn. All rights reserved.
//

import UIKit

class AssetPickerSelectCheckButton: UIButton {
    
    private let numberLabel: UILabel
    
    private let radioImageView: UIImageView
    
    override var isSelected: Bool {
        didSet {
            numberLabel.isHidden = !isSelected
            radioImageView.isHidden = isSelected
        }
    }
    
    override init(frame: CGRect) {
        
        radioImageView = UIImageView()
        radioImageView.image = Utility.image(named: "wx_asset_picker_select_24x24_")
        
        numberLabel = UILabel()
        numberLabel.isHidden = true
        numberLabel.layer.cornerRadius = 12
        numberLabel.clipsToBounds = true
        numberLabel.backgroundColor = UIColor(red: 0.027, green: 0.757, blue: 0.376, alpha: 1.0)
        numberLabel.textColor = .white
        numberLabel.textAlignment = .center
        numberLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
        super.init(frame: frame)
        
        imageView?.isHidden = true
        titleLabel?.isHidden = true
        
        addSubview(radioImageView)
        addSubview(numberLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        radioImageView.frame = CGRect(x: 18, y: 8, width: 24, height: 24)
        numberLabel.frame = radioImageView.frame
    }
    
    func setSelectedIndex(_ index: Int, animated: Bool) {
        numberLabel.text = String(index)
        if animated {
            startPopupAnimation()
        }
    }
    
    func startPopupAnimation() {
        numberLabel.layer.removeAllAnimations()
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.duration = 0.4
        animation.keyTimes = [0, 0.3, 0.6, 1.0].map { NSNumber(value: $0) }
        animation.values = [1.0, 1.2, 0.9, 1.0].map { NSNumber(value: $0) }
        numberLabel.layer.add(animation, forKey: "popup")
    }
    
}
