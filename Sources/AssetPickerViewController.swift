//
//  AssetPickerViewController.swift
//  WeChatSwift
//
//  Created by xu.shuifeng on 2019/7/23.
//  Copyright © 2019 alexiscn. All rights reserved.
//

import UIKit
import Photos

public protocol AssetPickerViewControllerDelegate: class {
    
    func assetPicker(_ picker: AssetPickerViewController, didSelectedAssets: [PHAsset])
    
    func assetPickerDidDimiss()
}

public class AssetPickerViewController: UIViewController {

    var enableOrigin: Bool = true
    
    private var collectionView: UICollectionView!
    
    private var dataSource: [MediaAsset] = []
    
    private var bottomBar: AssetPickerBottomBar?
    
    private(set) var selectedIndexPathList: [IndexPath] = []
    
    private let options: AssetPickerOptions
    
    private var assetCollection: PHAssetCollection?
    
    public init(options: AssetPickerOptions = .default(), assetCollection: PHAssetCollection? = nil) {
        self.options = options
        self.assetCollection = assetCollection
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureNavigationBar()
        configureCollectionView()
        configureBottomBar()
        configureConstraints()
        configureData()
    }
    
    private func requestAuthorizationAndLoadPhotos() {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch authorizationStatus {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    if status == .authorized {
                        self.loadPhotos()
                    }
                }
            }
        case .authorized:
            loadPhotos()
        default:
            break
        }
    }
    
    private func configureCollectionView() {
        let spacing: CGFloat = 4.0
        let numberOfItemsInRow: Int = 4
        var itemWidth = (UIScreen.main.bounds.width - CGFloat(numberOfItemsInRow + 1) * spacing)/CGFloat(numberOfItemsInRow)
        itemWidth = CGFloat(floorf(Float(itemWidth)))
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.allowsMultipleSelection = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AssetPickerCollectionViewCell.self,
                                forCellWithReuseIdentifier: NSStringFromClass(AssetPickerCollectionViewCell.self))
        collectionView.contentInset = options.showBottomBar ? UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0) : .zero
        view.addSubview(collectionView)
    }
    
    private func configureBottomBar() {
    
        guard options.showBottomBar else {
            return
        }
    
        let bottomBar = AssetPickerBottomBar(frame: .zero)
        bottomBar.previewHandler = {
            
        }
        bottomBar.sendHandler = { [weak self] in
            self?.sendAssets()
        }
        view.addSubview(bottomBar)
        self.bottomBar = bottomBar
    }
    
    private func configureConstraints() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        if let bottomBar = self.bottomBar {
            bottomBar.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bottomBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
    
    private func configureData() {
        if let collection = assetCollection {
            loadPhoto(in: collection)
        } else {
            requestAuthorizationAndLoadPhotos()
        }
    }
    
    private func sendAssets() {
        //let selectedAssets = selectedIndexPathList.map { return dataSource[$0.row] }
        //selectionHandler?(selectedAssets)
    }
    
    private func loadPhotos() {
        var temp: [MediaAsset] = []
        
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        let result = PHAsset.fetchAssets(with: options)
        result.enumerateObjects { (asset, _, _) in
            switch asset.mediaType {
            case .image:
                temp.append(MediaAsset(asset: asset))
            case .video:
                temp.append(MediaAsset(asset: asset))
            case .audio:
                print("Audio")
            case .unknown:
                temp.append(MediaAsset(asset: asset))
            @unknown default:
                temp.append(MediaAsset(asset: asset))
            }
        }
        
        dataSource = temp
        collectionView.reloadData()
        
        if dataSource.count > 0 {
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: self.dataSource.count - 1, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: false)
            }
            
        }
    }
    
    private func loadPhoto(in collection: PHAssetCollection) {
        var temp: [MediaAsset] = []
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let result = PHAsset.fetchAssets(in: collection, options: options)
        result.enumerateObjects { (asset, _, _) in
            temp.append(MediaAsset(asset: asset))
        }
        dataSource = temp
        collectionView.reloadData()
        
        if dataSource.count > 0 {
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: self.dataSource.count - 1, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: false)
            }
            
        }
    }

    private func configureNavigationBar() {
        navigationItem.title = "Camera Roll"
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonClicked))
    }
    
    private func updateSelection(at indexPath: IndexPath) {
    
        let mediaAsset = dataSource[indexPath.row]
        if mediaAsset.selected {
            selectedIndexPathList.append(indexPath)
        } else {
            mediaAsset.index = -1
            if let index = selectedIndexPathList.firstIndex(where: { $0 == indexPath }) {
                selectedIndexPathList.remove(at: index)
            }
        }
        for (index, item) in selectedIndexPathList.enumerated() {
            let asset = dataSource[item.row]
            asset.index = index + 1
        }
        collectionView.reloadItems(at: selectedIndexPathList)
        bottomBar?.updateButtonEnabled(selectedIndexPathList.count > 0)
    }
}

// Event Handlers
extension AssetPickerViewController {
    
    @objc private func cancelButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension AssetPickerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = dataSource[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(AssetPickerCollectionViewCell.self), for: indexPath) as! AssetPickerCollectionViewCell
        cell.update(mediaAsset: asset, options: options)
        cell.selectionHandler = { [weak self] in
            self?.updateSelection(at: indexPath)
        }
        cell.parent = self
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
//        let assets = dataSource.map { return $0.asset }
//        let assetDataSource = PhotoBrowserPHAssetDataSource(numberOfItems: dataSource.count, assets: assets)
//        let trans = PhotoBrowserZoomTransitioning { (browser, index, view) -> UIView? in
//            let indexPath = IndexPath(item: index, section: 0)
//            let cell = collectionView.cellForItem(at: indexPath) as? AssetPickerCollectionViewCell
//            return cell?.imageViewForZoomTransition
//        }
//        let delegate = PhotoBrowserDefaultDelegate()
//        let browser = PhotoBrowserViewController(dataSource: assetDataSource, transDelegate: trans, delegate: delegate)
//        browser.show(pageIndex: indexPath.item, in: self)
    }
}


public protocol PhotoBrowserZoomTransitioningOriginResource {
    
    var originResourceView: UIView { get }
    
    var originResourceAspectRatio: CGFloat { get }
}

extension UIImageView: PhotoBrowserZoomTransitioningOriginResource {
    public var originResourceView: UIView {
        return self
    }
    
    public var originResourceAspectRatio: CGFloat {
        if let image = image, image.size.height > 0 {
            return image.size.width / image.size.height
        }
        if bounds.height > 0 {
            return bounds.width / bounds.height
        }
        return 0
    }
}