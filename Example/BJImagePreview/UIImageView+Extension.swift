//
//  UIImageView+Extension.swift
//  BJImagePreview_Example
//
//  Created by Sovannra on 6/1/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView {
    
    /** Load image from url */
    public func loadImage(with url: String, placeholder: String?="", completion: ImageTask.Completion? = nil) {
        let options = ImageLoadingOptions(
            transition: .fadeIn(duration: 0.33)
        )
        if let url = URL(string: url) {
            Nuke.loadImage(with: url, options: options, into: self, completion: completion)
        }
    }
}
