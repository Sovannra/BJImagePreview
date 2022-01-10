//
//  ImageAppConstant.swift
//  BJImagePreview
//
//  Created by Sovannra on 6/1/22.
//

import UIKit

struct ImageAppConstant {
    
    static var statusBarHeight: CGFloat {
        let statusBarH = UIApplication.shared.statusBarFrame.size.height
        return statusBarH
    }
    
    /** Load image from resource path */
    static func loadImageResourcePath(_ fileName: String) -> UIImage? {
        let bundle = Bundle(for: ImageViewerView.self)
        return UIImage(named: fileName, in: bundle, compatibleWith: nil)
    }
}

extension UINavigationController {
  static public func navBarHeight() -> CGFloat {
    let nVc = UINavigationController(rootViewController: UIViewController(nibName: nil, bundle: nil))
    let navBarHeight = nVc.navigationBar.frame.size.height
    return navBarHeight
  }
}
