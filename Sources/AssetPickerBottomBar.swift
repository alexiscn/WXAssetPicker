//
//  AssetPickerBottomBar.swift
//  WeChatSwift
//
//  Created by xu.shuifeng on 2019/7/23.
//  Copyright © 2019 alexiscn. All rights reserved.
//

import UIKit

class AssetPickerBottomBar: UIView {
    
    var previewHandler: (() -> Void)?
    var sendHandler: (() -> Void)?
    
    private let backgroundImageView: UIImageView
    
    private let containerView: UIView
    
    private let previewButton: UIButton
    
    private let originButton: UIButton
    
    private let sendButton: UIButton
    
    override init(frame: CGRect) {
        
        backgroundImageView = UIImageView()
        backgroundImageView.image = AssetPickerUtility.image(named: "wx_asset_picker_toolbar_bg")
        
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
        originButton.setImage(UIImage(named: "FriendsSendsPicturesArtworkIcon_20x21_"), for: .selected)
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
        
        addSubview(backgroundImageView)
        addSubview(containerView)
        
        containerView.addSubview(previewButton)
        containerView.addSubview(originButton)
        containerView.addSubview(sendButton)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 45.0)
        ])
        
        previewButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            previewButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 6),
            previewButton.heightAnchor.constraint(equalToConstant: 20),
            previewButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        originButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            originButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            originButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 60),
            sendButton.heightAnchor.constraint(equalToConstant: 30),
            sendButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15)
        ])
        
        previewButton.addTarget(self, action: #selector(previewButtonClicked), for: .touchUpInside)
        originButton.addTarget(self, action: #selector(originButtonClicked), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundImageView.frame = bounds
        containerView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 45)
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
