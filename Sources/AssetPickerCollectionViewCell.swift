//
//  AssetPickerCollectionViewCell.swift
//  WeChatSwift
//
//  Created by alexiscn on 2019/7/23.
//  Copyright © 2019 alexiscn. All rights reserved.
//

import UIKit
import Photos

class AssetPickerCollectionViewCell: UICollectionViewCell {
    
    weak var parent: AssetPickerViewController?
    
    var selectionHandler: (() -> Void)?
    
    private let imageView: UIImageView
    
    private let selectionButton: AssetPickerSelectCheckButton
    
    private let selectionOverlay: UIView
    
    private var mediaAsset: MediaAsset?
    
    private var videoLogoView: UIImageView?
    
    private var tagBackgroundView: UIImageView?
    
    private var lengthLabel: UILabel?
    
    var imageViewForZoomTransition: UIImageView {
        return imageView
    }
    
    override init(frame: CGRect) {
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        selectionButton = AssetPickerSelectCheckButton(frame: .zero)
        
        selectionOverlay = UIView()
        selectionOverlay.backgroundColor = UIColor(white: 0, alpha: 0.5)
        selectionOverlay.isHidden = true
        
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(selectionOverlay)
        contentView.addSubview(selectionButton)
        
        selectionButton.addTarget(self, action: #selector(selectionButtonTapped), for: .touchUpInside)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        removeVideoLogoView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        selectionOverlay.frame = bounds
        selectionButton.frame = CGRect(x: bounds.width/2, y: 0, width: bounds.width/2, height: bounds.height/2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func selectionButtonTapped() {
        guard let mediaAsset = mediaAsset, let parent = parent else { return }
        if !mediaAsset.isSelected && parent.selectedIndexPathList.count >= 9 {
            return
        }
        
        mediaAsset.isSelected.toggle()
        selectionButton.isSelected = mediaAsset.isSelected
        selectionOverlay.isHidden = !mediaAsset.isSelected
        if mediaAsset.isSelected {
            let index = parent.selectedIndexPathList.count + 1
            selectionButton.setSelectedIndex(index, animated: true)
        }
        selectionHandler?()
    }
    
    func update(mediaAsset: MediaAsset, configuration: AssetPickerConfiguration) {
        self.mediaAsset = mediaAsset
        
        //selectionButton.isHidden = !options.canSendMultiImage
        //selectionImageView.isHidden = !options.canSendMultiImage
        
        removeVideoLogoView()
        if mediaAsset.asset.mediaType == .video {
            addVideoLogoView()
        } else {
//            if mediaAsset.asset.isGIF {
//                addGifLogoView()
//            }
        }
        
        selectionButton.setSelectedIndex(mediaAsset.index, animated: false)
        selectionButton.isSelected = mediaAsset.isSelected
        selectionOverlay.isHidden = !mediaAsset.isSelected
        
        let size = CGSize(width: 150, height: 150)
        PHCachingImageManager.default().requestImage(for: mediaAsset.asset,
                                                     targetSize: size,
                                                     contentMode: .aspectFill,
                                                     options: nil) { [weak self] (image, _) in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }
    
    private func addVideoLogoView() {
        let videoLogoView = UIImageView(frame: CGRect(x: 10, y: 7, width: 18, height: 11))
        videoLogoView.image = UIImage(named: "fileicon_video_wall_18x11_")
        let tagBackgroundView = UIImageView(frame: CGRect(x: 0, y: bounds.height - 28, width: bounds.width, height: 28))
        tagBackgroundView.image = UIImage(named: "Albumtimeline_video_shadow_4x28_")
        
        let lengthLabel = UILabel()
        lengthLabel.font = UIFont.systemFont(ofSize: 12)
        lengthLabel.textColor = UIColor.white
        //lengthLabel.text = Constants.formatDuration(mediaAsset?.asset.duration ?? 0)
        lengthLabel.frame = CGRect(x: 39, y: 5, width: 34, height: 15)
        
        tagBackgroundView.addSubview(videoLogoView)
        tagBackgroundView.addSubview(lengthLabel)
        contentView.addSubview(tagBackgroundView)
        self.tagBackgroundView = tagBackgroundView
    }
    
    private func removeVideoLogoView() {
        if videoLogoView != nil {
            videoLogoView?.removeFromSuperview()
            videoLogoView = nil
        }
        if tagBackgroundView != nil {
            tagBackgroundView?.removeFromSuperview()
            tagBackgroundView = nil
        }
        if lengthLabel != nil {
            lengthLabel?.removeFromSuperview()
            lengthLabel = nil
        }
    }
    
    private func addGifLogoView() {
        
        let tagBackgroundView = UIImageView(frame: CGRect(x: 0, y: bounds.height - 28, width: bounds.width, height: 28))
        tagBackgroundView.image = UIImage(named: "Albumtimeline_video_shadow_4x28_")
        
        let gifLabel = UILabel()
        gifLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        gifLabel.textColor = .white
        gifLabel.text = "GIF"
        gifLabel.frame = CGRect(x: 10, y: 0, width: 20, height: 28)
        tagBackgroundView.addSubview(gifLabel)
        contentView.addSubview(tagBackgroundView)
        self.tagBackgroundView = tagBackgroundView
    }
}
