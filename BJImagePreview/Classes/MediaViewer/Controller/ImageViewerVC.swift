//
//  ImageViewerVC.swift
//  BJImagePreview
//
//  Created by Sovannra on 10/1/22.
//

import UIKit

class ImageViwerVC: UIViewController {
    
    lazy var photosPage: MediaPhotosPageView = {
        let imageView = MediaPhotosPageView()
        imageView.myDelegate = self
        return imageView
    }()
    
    var delegate: mediaPhotosPageViewDelegate?
    
    fileprivate var displacementSpringBounce: CGFloat = 0.7
    fileprivate var displacementDuration: TimeInterval = 0.55
    
    var index: Int
    var image: String
    var frameView: CGRect
    init(frameView: CGRect, image: String,index: Int) {
        self.frameView = frameView
        self.image = image
        self.index = index
        super.init(nibName: nil, bundle: nil)
        view.addSubview(photosPage)
        photosPage.imageView.loadImage(with: image)
        photosPage.translatesAutoresizingMaskIntoConstraints = false
        photosPage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        photosPage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        photosPage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        photosPage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photosPage.configureLayout()
    }
}

extension ImageViwerVC: mediaPhotosPageViewDelegate {
    func viewWillBeginZooming() {
  
    }
    
    func viewDidEndZooming() {
      
    }
}
