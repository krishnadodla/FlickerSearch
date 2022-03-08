//
//  ConstraintHelper.swift
//  FlickerSearch
//
//  Created by kdodla on 3/8/22.
//

import Foundation
import UIKit

class ConstraintsHelper {
    static func applyLandscapeConstraints(view: UIView, view1: UIView, view2: UIView) -> [NSLayoutConstraint] {
        var landscapeConstraints = [NSLayoutConstraint]()
        
        view1.translatesAutoresizingMaskIntoConstraints = false
        view2.translatesAutoresizingMaskIntoConstraints = false
        
        let view1PinToTop = NSLayoutConstraint(item: view1, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 8.0)
        let view1PinToLeft = NSLayoutConstraint(item: view1, attribute: .left, relatedBy: .equal, toItem: view1.superview, attribute: .left, multiplier: 1.0, constant: 0.0)
        let view1Width = NSLayoutConstraint(item: view1, attribute: .width, relatedBy: .equal, toItem: view1.superview, attribute: .width, multiplier: 0.5, constant: -4.0)
        let view1PinToBottom = NSLayoutConstraint(item: view1, attribute: .bottom, relatedBy: .equal, toItem: view1.superview, attribute: .top, multiplier: 1.0, constant: -8.0)
        view.addConstraint(view1PinToTop)
        landscapeConstraints.append(view1PinToTop)
        view.addConstraint(view1PinToLeft)
        landscapeConstraints.append(view1PinToLeft)
        view.addConstraint(view1Width)
        landscapeConstraints.append(view1Width)
        view.addConstraint(view1PinToBottom)
        landscapeConstraints.append(view1PinToBottom)

        let view2PinToTop = NSLayoutConstraint(item: view2, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 8.0)
        let view2Width = NSLayoutConstraint(item: view2, attribute: .width, relatedBy: .equal, toItem: view2.superview, attribute: .width, multiplier: 0.5, constant: -4.0)
        let view2PinToRight = NSLayoutConstraint(item: view2, attribute: .right, relatedBy: .equal, toItem: view2.superview, attribute: .right, multiplier: 1.0, constant: 0.0)
        let view2PinToBottom = NSLayoutConstraint(item: view2, attribute: .bottom, relatedBy: .equal, toItem: view2, attribute: .top, multiplier: 1.0, constant: -8.0)
        view.addConstraint(view2PinToTop)
        landscapeConstraints.append(view2PinToTop)
        view.addConstraint(view2Width)
        landscapeConstraints.append(view2Width)
        view.addConstraint(view2PinToRight)
        landscapeConstraints.append(view2PinToRight)
        view.addConstraint(view2PinToBottom)
        landscapeConstraints.append(view2PinToBottom)
        
        
        return landscapeConstraints
    }
}
