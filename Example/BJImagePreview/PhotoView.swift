//
//  PhotoView.swift
//  BJImagePreview_Example
//
//  Created by Sovannra on 10/1/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import BJCollection
import BJImagePreview

class PhotoView: UIView {
    
    var imageArr: [String]? {
        didSet {
            vCollection.reloadData()
        }
    }
    /** Check loadIndex when scroll image view to load more image */
    var loadIndex: Int {
        return (imageArr?.count ?? 0) - 10
    }
    /** Store old index for showing image cell */
    var oldIndex: Int = 0
    /** Check is get more image is reach limit */
    var isReachLimit: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(vCollection)
        vCollection.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        vCollection.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        vCollection.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        vCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    lazy var vCollection: BJCollectionView = {
        let view = BJCollectionView(numberOfItems: 3, spacingBetweenItems: 1.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showScrollIndicator = false
        view.alwaysBounceVertical = true
        view.register(cell: ImageCell.self)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    /// Store UIImageView from cell
    var vImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    /// Store ImageViewerView after init ImageViewerView
    var vImageViewer: ImageViewerView!
}

extension PhotoView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageCell = collectionView.dequeue(for: indexPath)
        cell.imageString = imageArr?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        initImageViewer(indexPath: indexPath)
    }
}

extension PhotoView: ImageViewerDelegate{
    func imageViewer(imageViewerView: ImageViewerView) {
        vImageViewer = imageViewerView
    }

    public func imageViewer(imageViewerView: ImageViewerView, getCurrentIndex index: Int) {
        appendImage(imageViewerView: imageViewerView, index: index)
        vCollection.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredVertically, animated: false)
        if oldIndex != index {
            updateImageView(imageViewerView: imageViewerView, index: oldIndex, alpha: 1)
        }
        updateImageView(imageViewerView: imageViewerView, index: index, alpha: 0)
        oldIndex = index
    }

    public func imageViewer(imageViewerView: ImageViewerView, graggingView state: ImageViewerView.DraggingState) {
        switch state {
        case .ended:
            let statusImageView = vImage
            statusImageView.alpha = 1
            vImageViewer = nil
        default:
            break
        }
    }
}

extension PhotoView {
    
    ///Mark: - Init ImageViewer view
    func initImageViewer(indexPath: IndexPath) {
        let cell = vCollection.cellForItem(at: indexPath) as! ImageCell
        vImage = cell.vImage
        oldIndex = indexPath.row
        let statusImageView = vImage
        statusImageView.alpha = 0
        
        if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil) {
            let viewController = UIApplication.shared.keyWindow!.rootViewController!
            viewController.popImageViewer(
                photos: imageArr ?? [],
                outsideFrame: startingFrame,
                statusImageView: statusImageView,
                currentIndex: indexPath.row,
                imageViewerDelegate: self
            )
        }
    }
    
    ///Mark: -- Update imageViewer view
    func updateImageView(imageViewerView: ImageViewerView, index: Int, alpha: CGFloat) {
        let indexPath = IndexPath(item: index, section: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {[self] in
            guard let cell = vCollection.cellForItem(at: indexPath) as? ImageCell else { return }
            vImage = cell.vImage
            oldIndex = index
            let statusImageView = vImage
            statusImageView.alpha = alpha
            if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil) {
                let viewController = UIApplication.shared.keyWindow!.rootViewController!
                viewController.updateImageViewer(
                    imageViewerView: imageViewerView,
                    outsideFrame: startingFrame,
                    statusImageView: statusImageView
                )
            }
        }
    }
    
    ///Mark: -- Append more image to imageArr & imageViewerView
    func appendImage(imageViewerView: ImageViewerView, index: Int) {
        let not = (!)
        if not(isReachLimit) && index >= loadIndex {
            isReachLimit = true
            imageArr?.append(contentsOf: LocalData.moreImage)
            let viewController = UIApplication.shared.keyWindow!.rootViewController!
            viewController.loadMoreImageViewer(imageViewerView: imageViewerView, photo: LocalData.moreImage, currentIndex: index)
        }
    }
    
    ///Mark: -- Update imageView outsize & inside frame when orientation changed
    func rotateChanged() {
        DispatchQueue.main.async {[self] in
            if let imageViewerView = vImageViewer {
                vCollection.scrollToItem(at: IndexPath(item: oldIndex, section: 0), at: .centeredVertically, animated: false)
                updateImageView(imageViewerView: imageViewerView, index: oldIndex, alpha: 0)
            }
        }
    }
    
    ///Mark: -- Update collection view flow layout when orientation changed
    func updateFlowLayout() {
        guard let flowLayout = vCollection.collectionViewLayout as? BaseCollectionViewFlowLayout else {
            return
        }
        flowLayout.heightItems = 0
        if UIDevice.current.orientation.isLandscape {
            //here you can do the logic for the cell size if phone is in landscape
            flowLayout.numberOfItemsInRow = 5
        } else {
            //logic if not landscape
            flowLayout.numberOfItemsInRow = 3
        }
        flowLayout.invalidateLayout()
    }
}
