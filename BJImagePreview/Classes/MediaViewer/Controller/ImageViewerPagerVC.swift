//
//  ImageViewerVC.swift
//  Messenger
//
//  Created by VLC on 11/17/20.
//  Copyright © 2020 VLC. All rights reserved.
//

import UIKit
import AVFoundation

protocol ImageViewerPagerVCDelegate: class {
    func containerViewController(indexDidUpdate currentIndex: Int)
    func handleClose()
}


class ImageViewerPagerVC: UIPageViewController{
    
    weak var myDelegate: ImageViewerPagerVCDelegate?
    
    var currentViewController: ImageViwerVC!
    var nextViewController: ImageViwerVC!

    fileprivate var spineDividerWidth: Float = 10
    var photos: [String]
    var currentIndex: Int
    var nextIndex: Int?
    
    init(photos: [String], currentIndex: Int = 0) {
        self.photos = photos
        self.currentIndex = currentIndex
        super.init(
            transitionStyle: UIPageViewController.TransitionStyle.scroll,
            navigationOrientation: UIPageViewController.NavigationOrientation.horizontal,
            options: [UIPageViewController.OptionsKey.interPageSpacing : NSNumber(value: spineDividerWidth as Float)]
        )
        let vc = ImageViwerVC(frameView: self.view.frame, image: photos[currentIndex], index: currentIndex)
        self.currentViewController = vc
        self.setViewControllers(
            [currentViewController],
            direction: UIPageViewController.NavigationDirection.forward,
            animated: false,
            completion: nil
        )
        self.delegate = self
        self.dataSource = self
        self.view.clipsToBounds = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateLayout()
    }
    
    private func updateLayout() {
        self.view.frame = UIScreen.main.bounds
    }
}

extension ImageViewerPagerVC: mediaPhotosPageViewDelegate {
    func viewWillBeginZooming() {
        
    }
    
    func viewDidEndZooming() {
        
    }
    
}

extension ImageViewerPagerVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if currentIndex == 0 {
            return nil
        }
        let before = currentIndex - 1
        return ImageViwerVC(frameView: self.view.frame, image: self.photos[before], index: before)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if currentIndex == (self.photos.count - 1) {
            return nil
        }
        let after = currentIndex + 1
        return  ImageViwerVC(frameView: self.view.frame, image: self.photos[after], index: after)
    }

    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let nextVC = pendingViewControllers.first as? ImageViwerVC else {
            return
        }
        
        self.nextIndex = nextVC.index
        self.nextViewController = nextVC
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if (completed && self.nextIndex != nil) {

            previousViewControllers.forEach { vc in
                let zoomVC = vc as! ImageViwerVC
                zoomVC.photosPage.zoomScale = zoomVC.photosPage.minimumZoomScale
            }
            self.currentIndex = self.nextIndex!
            self.currentViewController = nextViewController
            
            self.myDelegate?.containerViewController(indexDidUpdate: self.currentIndex)
            
        }
        
        self.nextIndex = nil
    }
    
}


extension ImageViewerPagerVC: ZoomAnimatorDelegate {

    func transitionWillStartWith(zoomAnimator: ZoomAnimator) {
    }

    func transitionDidEndWith(zoomAnimator: ZoomAnimator) {
    }

    func referenceImageView(for zoomAnimator: ZoomAnimator) -> UIImageView? {
        return self.currentViewController.photosPage.imageView
    }

    func referenceImageViewFrameInTransitioningView(for zoomAnimator: ZoomAnimator) -> CGRect? {
        return self.currentViewController.photosPage.convert(self.currentViewController.photosPage.imageView.frame, to: self.currentViewController.view)
    }
}
