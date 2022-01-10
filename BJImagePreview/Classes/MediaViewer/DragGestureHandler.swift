//
//  DragGestureHandler.swift
//  Messenger
//
//  Created by VLC on 8/2/21.
//  Copyright © 2021 VLC. All rights reserved.
//

import UIKit

class DragGestureHandler: NSObject {
    //Whether to start dragging
    private var startDrag = false
    //Gestures response
    private var noResponse = false
    //Original location
    private var originFrame = CGRect.zero
    //The distance from the touch point to the center of the view
    private var distanceToCenter = CGSize.zero
    
    
    //View for gestures
    weak var gestureView: UIView?
    //Background view
    weak var bgView: UIView?
    //Callback for end of gesture
    var completeBlock: ((_ finish: Bool)->())?
    //Drag callback with drag effect
    var dragBlock: (()->())?
    var beganDragBlock: (()->())?
    
    convenience init(gestureView: UIView, bgView: UIView) {
        self.init()
        
        self.gestureView = gestureView
        self.bgView = bgView
        bgView.addGestureRecognizer(self.panGesture)
    }
    
    override init() {
        super.init()
    }
    
    @objc private func panAction(gesture: UIPanGestureRecognizer) {
        guard let operateView = self.gestureView,let bgView = self.bgView else {
            return
        }
        let pointVelocity = gesture.velocity(in: bgView)
        let changePoint = gesture.translation(in: bgView)
        
        switch (gesture.state) {
        case .began:// The recognizer has received a touch recognized for this gesture (state) (Began)
            beganDragBlock?()
            self.startDrag = true
            self.noResponse = false
            self.originFrame = operateView.frame
            //Drag point distance from the center point
            let insidePoint = gesture.location(in: operateView)
            let distanceX = insidePoint.x - operateView.frame.width * 0.5
            let distanceY = insidePoint.y - operateView.frame.height * 0.5
            self.distanceToCenter = CGSize.init(width: distanceX, height: distanceY)
        case .changed:// The recognizer has received a touch and recognized it as a gesture change (Changed)
            
            if self.startDrag == true {
                self.startDrag = false
                if changePoint.y < 0 {
                    self.noResponse = true
                }else if abs(changePoint.x) > changePoint.y {
                    self.noResponse = true
                }
            }

            if self.noResponse {
                return
            }
            if self.dragBlock != nil {
                self.dragBlock!()
            }
            
            //Half the height of the background as a reference
            let halfHeight = bgView.frame.height * 0.5
            let halfWidth = bgView.frame.width * 0.5
            let surplus = changePoint.y > halfHeight ? halfHeight : changePoint.y
            let scale = surplus/halfHeight
            bgView.alpha = 0.1 + 0.9 * (1 - scale)

            //transform scale
            let frameScale = (1 - 0.5 * scale)
            //Center point after moving (without tranform change)
            let afterCenter = CGPoint.init(x: halfWidth + changePoint.x, y: halfHeight + changePoint.y)
            //Center point offset after tranform change
            let afterCenterOffsetY = self.distanceToCenter.height * (1 - frameScale)
            let afterCenterOffsetX = self.distanceToCenter.width * (1 - frameScale)
            //Change the center point and transform of operateView
            operateView.center = CGPoint.init(x: afterCenter.x + afterCenterOffsetX, y: afterCenter.y + afterCenterOffsetY)
            operateView.transform = CGAffineTransform.init(scaleX: frameScale, y: frameScale)
        case .ended:// The recognizer has received the touch and recognized the gesture as Ended (Ended)

            self.startDrag = false
            self.noResponse = false
            //If the instantaneous speed of letting go is greater than 100 or the offset distance is greater than 100, go back
            if pointVelocity.y > 100 || changePoint.y > 80 {
                if self.completeBlock != nil {
                    self.completeBlock!(true)
                }
            }else {
                UIView.animate(withDuration: 0.3) {
                    operateView.transform = CGAffineTransform.identity
                    operateView.frame = self.originFrame
                    bgView.alpha = 1
                } completion: { (finished) in
                    
                    if self.completeBlock != nil {
                        self.completeBlock!(false)
                    }
                }
                
            }
        default:
            break
        }
    }
    
    //MARK:- setter & getter
    
    private lazy var panGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panAction(gesture:)))
        return gesture
    }()
}
