//
//  ImageViewerView.swift
//  Messenger
//
//  Created by VLC on 4/2/21.
//  Copyright © 2021 VLC. All rights reserved.
//

import UIKit

public protocol ImageViewerDelegate: AnyObject {
    func imageViewer(imageViewerView: ImageViewerView, getCurrentIndex index: Int)
    func imageViewer(imageViewerView: ImageViewerView, graggingView state: ImageViewerView.DraggingState)
}
public extension ImageViewerView {
    
    enum DraggingState {
        case began
        case changed
        case ended
        case none
    }
}


open class ImageViewerView: UIView {
    weak var imageViewerDelegate: ImageViewerDelegate?
    //
    private var photos: [String]
    var currentIndex: Int
    //
    var outsideFrame = CGRect.zero
    var insideFrame = CGRect.zero
    private var gesture: DragGestureHandler?

    //MARK: -Init view
    init(frame: CGRect, photos: [String],currentIndex: Int = 0) {
        self.photos = photos
        self.currentIndex = currentIndex
        super.init(frame: frame)
        
        // Setup component
        addSubview(self.imageViewPager.view)
        addSubview(self.imageView)
        setupTopBarView()
        
       // CallBack
        gesture = DragGestureHandler.init(gestureView: self.imageView, bgView: self.imageViewPager.view)
        gesture?.completeBlock = { [self] (finish) in
            if finish {
                hide()
                return
            }
            updateUI(state: .none)
        }
        
        gesture?.beganDragBlock = { [self] in
            updateUI(state: .began)
        }
        // Update photo count
        vTopView.setupPhotoCount(count: currentIndex, total: photos.count)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = UIScreen.main.bounds
    }
    
    //MARK: - local func
    private func updateUI(state: DraggingState) {
        switch state {
        case .none:
            imageViewerDelegate?.imageViewer(imageViewerView: self, graggingView: .none)
            imageViewPager.currentViewController.photosPage.alpha = 1
            imageView.alpha = 0
            vTopView.alpha = 1
            
        case .began:
            imageViewerDelegate?.imageViewer(imageViewerView: self, graggingView: .began)
            imageViewPager.currentViewController.photosPage.setZoomScale(1.0, animated: true)
            imageViewPager.currentViewController.photosPage.alpha = 0
            imageView.alpha = 1
            vTopView.alpha = 0
        default:
            break
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTopBarView() {
        addSubview(vTopView)
        vTopView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        vTopView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        vTopView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        // Hanlde show / hide top bar
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(showHideTopView(_:)))
        singleTapGesture.numberOfTouchesRequired = 1
        addGestureRecognizer(singleTapGesture)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(showHideTopView(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTapGesture)
        singleTapGesture.require(toFail: doubleTapGesture)
    }
        
    //MARK:- action
    func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
        self.imageViewPager.view.alpha = 0
        self.vTopView.alpha = 0
        self.imageView.frame = self.outsideFrame
        UIView.animate(withDuration: 0.3, animations: {
            self.imageView.frame = self.insideFrame
            self.imageViewPager.view.alpha = 1
            self.vTopView.alpha = 1
            
        }) {[self] (_) in
            updateUI(state: .none)
        }
    }
    
    private func hide() {
        self.imageViewPager.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3, animations: {
            self.imageView.frame = self.outsideFrame
            self.imageViewPager.view.alpha = 0
            self.vTopView.alpha = 0
        }) { (finished) in
            self.imageViewerDelegate?.imageViewer(imageViewerView: self, graggingView: .ended)
            self.removeFromSuperview()
            NotificationCenter.default.removeObserver(self, name: UIApplication.didChangeStatusBarOrientationNotification, object: nil)
        }
    }
    
    @objc private func showHideTopView(_ tap: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) { [self] in
            vTopView.alpha = (vTopView.alpha == 1) ? 0 : 1
        } completion: { _ in }
    }
    
    func loadMoreImage(image: [String], currentIndex: Int) {
        photos.append(contentsOf: image)
        imageViewPager.photos.append(contentsOf: image)
        vTopView.setupPhotoCount(count: currentIndex, total: photos.count)
    }

    //MARK:- setter & getter

    private(set) var imageView: UIImageView = {
        let view = UIImageView.init()
        view.contentMode = .scaleAspectFill
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var imageViewPager: ImageViewerPagerVC = {
        let pager =  ImageViewerPagerVC(photos: photos, currentIndex: currentIndex)
        pager.view.frame = self.bounds
        pager.view.backgroundColor = .black
        pager.currentViewController.photosPage.alpha = 0
        pager.myDelegate = self
        return pager
    }()
    
    private lazy var vTopView: TopViewMask = {
        let view = TopViewMask()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}
extension ImageViewerView: ImageViewerPagerVCDelegate {

    func containerViewController(indexDidUpdate currentIndex: Int) {
        self.currentIndex = currentIndex
        vTopView.setupPhotoCount(count: currentIndex, total: photos.count)
        imageViewPager.currentViewController.photosPage.alpha = 1
        imageViewerDelegate?.imageViewer(imageViewerView: self, getCurrentIndex: currentIndex)
    }
}

 class ImageViewerCell: UICollectionViewCell {
    var zoomImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        zoomImageView.contentMode = .scaleAspectFill
        zoomImageView.clipsToBounds = true
        addSubview(zoomImageView)
        zoomImageView.translatesAutoresizingMaskIntoConstraints = false
        zoomImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        zoomImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        zoomImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        zoomImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
