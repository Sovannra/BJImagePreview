//
//  UIViewController+Extension.swift
//  iOS-adc-app
//
//  Created by Sovannra on 28/6/21.
//  Copyright © 2021 Core-MVVM. All rights reserved.
//

import UIKit

//MARK: - Popup Image Viewer
extension UIViewController{
    /// Present ImageViewer
    public func popImageViewer(photos: [String],outsideFrame: CGRect, statusImageView: UIImageView, currentIndex: Int, imageViewerDelegate: ImageViewerDelegate ) {
        let showView = ImageViewerView.init(frame: UIScreen.main.bounds, photos: photos, currentIndex: currentIndex)
        showView.imageViewerDelegate = imageViewerDelegate
        showView.imageView.image = statusImageView.image
        showView.outsideFrame    = outsideFrame
        showView.insideFrame     = getInsideFrame(image: statusImageView.image)
        showView.show()
    }
    
    /// Update ImageViewer frame
    public func updateImageViewer(imageViewerView: ImageViewerView, outsideFrame: CGRect, statusImageView: UIImageView) {
        imageViewerView.outsideFrame    = outsideFrame
        imageViewerView.insideFrame     = getInsideFrame(image: statusImageView.image)
        imageViewerView.imageView.image = statusImageView.image
        imageViewerView.imageView.frame = imageViewerView.insideFrame
    }
        
    /// Append more image to ImageViewer photo
    public func loadMoreImageViewer(imageViewerView: ImageViewerView, photo: [String], currentIndex: Int) {
        imageViewerView.loadMoreImage(image: photo, currentIndex: currentIndex)
    }
    
    /// Get inside frame from UIImage
    func getInsideFrame(image: UIImage?) -> CGRect {
        if UIApplication.shared.statusBarOrientation.isLandscape {
            // Landscape
            if let image = image{
                let scale = image.size.width/image.size.height
                let insideHeight = UIScreen.main.bounds.height
                let insideWidth = insideHeight * scale
                return CGRect.init(x: (UIScreen.main.bounds.width - insideWidth) * 0.5, y: 0,
                                   width: insideWidth, height: insideHeight)
            }
        } else {
            // Portrait
            if let image = image{
                let scale = image.size.height/image.size.width
                let insideWidth = UIScreen.main.bounds.width
                let insideHeight = insideWidth * scale
                return CGRect.init(x: 0, y: (UIScreen.main.bounds.height - insideHeight) * 0.5,
                                   width: insideWidth, height: insideHeight)
            }
        }
        return view.frame
    }
    
}
//MARK: -
