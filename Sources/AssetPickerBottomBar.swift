//
//  AssetPickerBottomBar.swift
//  WeChatSwift
//
//  Created by alexiscn on 2019/7/23.
//  Copyright © 2019 alexiscn. All rights reserved.
//

import UIKit

class AssetPickerBottomBar: UIView {
    
    var previewHandler: (() -> Void)?
    var sendHandler: (() -> Void)?
    
    private let effectView: UIVisualEffectView
    
    private let containerView: UIView
    
    private let previewButton: UIButton
    
    private let originButton: UIButton
    
    private let sendButton: UIButton
    
    init(configuration: AssetPickerConfiguration, frame: CGRect) {
        
        let effect = UIBlurEffect(style: .dark)
        effectView = UIVisualEffectView(effect: effect)
        
        containerView = UIView()
        
        previewButton = UIButton(type: .system)
        previewButton.isEnabled = false
        previewButton.setTitle("预览", for: .normal)
        previewButton.setTitleColor(UIColor(white: 1, alpha: 0.3), for: .disabled)
        previewButton.setTitleColor(UIColor.white, for: .normal)
        previewButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        originButton = UIButton(type: .custom)
        originButton.setTitle("原图", for: .normal)
        originButton.setTitleColor(.white, for: .normal)
        originButton.setImage(UIImage(named: "FriendsSendsPicturesArtworkNIcon_20x21_"), for: .normal)
        originButton.setImage(configuration.assets.originCheckedImage, for: .selected)
        originButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        originButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
        
        sendButton = UIButton(type: .system)
        sendButton.isEnabled = false
        sendButton.layer.cornerRadius = 4
        sendButton.setTitle("发送", for: .normal)
        sendButton.setTitleColor(UIColor(white: 1, alpha: 0.3), for: .disabled)
        sendButton.setTitleColor(UIColor.white, for: .normal)
        sendButton.backgroundColor = UIColor(red: 26.0/255, green: 173.0/255, blue: 25.0/255, alpha: 1.0)
        sendButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        super.init(frame: frame)
        
        addSubview(effectView)
        addSubview(containerView)
        
        containerView.addSubview(previewButton)
        containerView.addSubview(originButton)
        containerView.addSubview(sendButton)
        
        previewButton.addTarget(self, action: #selector(previewButtonClicked), for: .touchUpInside)
        originButton.addTarget(self, action: #selector(originButtonClicked), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        effectView.frame = bounds
        containerView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 56)
        
        previewButton.frame = CGRect(x: 6, y: (bounds.height - 20)/2.0, width: 60, height: 20)
        originButton.frame = CGRect(x: (bounds.width - 80)/2.0, y: 0, width: 80, height: bounds.height)
        sendButton.frame = CGRect(x: bounds.width - 60 - 15, y: (bounds.height - 30)/2.0, width: 60, height: 30)
    }
    
    func updateButtonEnabled(_ enabled: Bool) {
        previewButton.isEnabled = enabled
        sendButton.isEnabled = enabled
    }
    
    @objc private func originButtonClicked() {
        originButton.isSelected.toggle()
    }
    
    @objc private func previewButtonClicked() {
        previewHandler?()
    }
    
    @objc private func sendButtonClicked() {
        sendHandler?()
    }
}
