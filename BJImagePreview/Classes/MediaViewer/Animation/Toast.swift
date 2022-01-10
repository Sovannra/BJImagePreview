//
//  Toast.swift
//  BJImagePreview
//
//  Created by Sovannra on 10/1/22.
//

import UIKit

class Toast
{
    class private func showAlert(backgroundColor:UIColor, textColor:UIColor, message:String)
    {
        
        let window = UIApplication.shared.delegate?.window!
        let label = UILabel(frame: CGRect.zero)
        label.textAlignment = NSTextAlignment.center
        label.text = message
        label.font = UIFont(name: "", size: 15)
        label.adjustsFontSizeToFitWidth = true
        
        label.backgroundColor =  backgroundColor //UIColor.whiteColor()
        label.textColor = textColor //TEXT COLOR
        
        let height: CGFloat = 44
        
        label.sizeToFit()
        label.numberOfLines = 4
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowOffset = CGSize(width: 4, height: 3)
        label.layer.shadowOpacity = 0.3
        label.layer.masksToBounds = true
        label.layer.cornerRadius = CGFloat((height / 2))
        
        let width = label.frame.width + 25
        let Y = ImageAppConstant.statusBarHeight + UINavigationController.navBarHeight()
        label.frame = CGRect(x: window!.frame.size.width, y: Y, width: width, height: CGFloat(height))
        
        label.alpha = 1
        
        window?.addSubview(label)
        
        var basketTopFrame: CGRect = label.frame
        basketTopFrame.origin.y = 0
        basketTopFrame.origin.x = (window!.frame.size.width - width) / 2
        label.frame = basketTopFrame
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
            label.center.y += (label.bounds.height)
        },  completion: {
            (value: Bool) in
            UIView.animate(withDuration:2.0, delay: 1.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIView.AnimationOptions.curveLinear, animations: { () -> Void in
                label.center.y -= (label.bounds.height)
                label.alpha = 0
            },  completion: {
                (value: Bool) in
                label.removeFromSuperview()
            })
        })
    }
    
    class func showPositiveMessage(message:String)
    {
        showAlert(backgroundColor: UIColor.systemBlue, textColor: UIColor.white, message: message)
    }
    class func showNegativeMessage(message:String)
    {
        showAlert(backgroundColor: UIColor.red, textColor: UIColor.white, message: message)
    }
}
