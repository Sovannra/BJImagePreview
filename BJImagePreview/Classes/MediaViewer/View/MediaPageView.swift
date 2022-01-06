//
//  MediaPageView.swift
//  VidoePlayer
//
//  Created by Sovannra on 28/6/21.
//

import UIKit

protocol mediaPhotosPageViewDelegate: AnyObject {
    func viewWillBeginZooming()
    func viewDidEndZooming()
}
/// PhotosPageView
class MediaPhotosPageView: UIScrollView, UIScrollViewDelegate {
    weak var myDelegate: mediaPhotosPageViewDelegate?
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    var statusTapped: Bool = false {
        didSet{
            if statusTapped{
                myDelegate?.viewWillBeginZooming()
            }else{
                myDelegate?.viewDidEndZooming()
            }
        }
    }
    var contentFrame = CGRect.zero
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureImageView()
    }
    func configureLayout() {
        zoomScale = 1.0
        contentFrame = frame
        contentSize = frame.size
        imageView.frame = frame
        zoomScale = minimumZoomScale
        configureImageView()
        myDelegate?.viewDidEndZooming()
    }
    // MARK: - Configuration
    
    func configure() {
        addSubview(imageView)
        delegate = self
        isMultipleTouchEnabled = true
        minimumZoomScale = 1.0
        maximumZoomScale = 3.0
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(singleTapped))
        singleTapGesture.numberOfTapsRequired = 1
        addGestureRecognizer(singleTapGesture)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapped(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTapGesture)
        
        singleTapGesture.require(toFail: doubleTapGesture)
    }
    func configureImageView() {
        guard let image = imageView.image else {
            centerImageView()
            return
        }
        
        let imageViewSize = imageView.frame.size
        let imageSize = image.size
        let realImageViewSize: CGSize
        
        if imageSize.width / imageSize.height > imageViewSize.width / imageViewSize.height {
            realImageViewSize = CGSize(
                width: imageViewSize.width,
                height: imageViewSize.width / imageSize.width * imageSize.height)
        } else {
            realImageViewSize = CGSize(
                width: imageViewSize.height / imageSize.height * imageSize.width,
                height: imageViewSize.height)
        }
        
        imageView.frame = CGRect(origin: CGPoint.zero, size: realImageViewSize)
        
        centerImageView()
    }
    
    func centerImageView() {
        let boundsSize = contentFrame.size
        var imageViewFrame = imageView.frame
        
        if imageViewFrame.size.width < boundsSize.width {
            imageViewFrame.origin.x = (boundsSize.width - imageViewFrame.size.width) / 2.0
        } else {
            imageViewFrame.origin.x = 0.0
        }
        
        if imageViewFrame.size.height < boundsSize.height {
            imageViewFrame.origin.y = (boundsSize.height - imageViewFrame.size.height) / 2.0
        } else {
            imageViewFrame.origin.y = 0.0
        }
        
        imageView.frame = imageViewFrame
    }
    
    // MARK: - Recognizers
    
    @objc func doubleTapped(_ recognizer: UITapGestureRecognizer) {
        let pointInView = recognizer.location(in: imageView)
        let newZoomScale = zoomScale > minimumZoomScale
            ? minimumZoomScale
            : maximumZoomScale
        
        let width = contentFrame.size.width / newZoomScale
        let height = contentFrame.size.height / newZoomScale
        let x = pointInView.x - (width / 2.0)
        let y = pointInView.y - (height / 2.0)
        
        let rectToZoomTo = CGRect(x: x, y: y, width: width, height: height)
        
        zoom(to: rectToZoomTo, animated: true)
    }
    
    @objc func singleTapped(){
        if statusTapped {
            statusTapped = false
        }else{
            statusTapped = true
        }
    }
    
    // MARK: - UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImageView()
        
    }
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        
        statusTapped = true
        
        
    }
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if scale == 1.0 && statusTapped{
            statusTapped = false
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
