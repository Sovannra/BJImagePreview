//
//  ViewController.swift
//  BJImagePreview
//
//  Created by Sovannra on 01/05/2022.
//  Copyright (c) 2022 Sovannra. All rights reserved.
//

import UIKit
import BJCollection
import BJImagePreview

class ViewController: UIViewController {

    let vPhoto: PhotoView = {
        let view = PhotoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Photo"
        setupView()
        vPhoto.imageArr = LocalData.imageArr
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        vPhoto.updateFlowLayout()
    }
    
    func setupView() {
        view.addSubview(vPhoto)
        vPhoto.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        vPhoto.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        vPhoto.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        vPhoto.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func rotated() {
        vPhoto.rotateChanged()
    }
}
