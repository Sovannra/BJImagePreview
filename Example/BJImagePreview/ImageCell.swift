//
//  ImageCell.swift
//  BJImagePreview_Example
//
//  Created by Sovannra on 5/1/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import BJImagePreview

class ImageCell: UICollectionViewCell {
    
    var imageString: String? {
        didSet {
            vImage.loadImage(with: imageString ?? "")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(vImage)
        vImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        vImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        vImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        vImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    lazy var vImage: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
}

