//
//  DetailsAnimator.swift
//  IQ
//
//  Created by Anton Chebotov on 22/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class DetailsAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    private let overlayView = UIView()

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 3.0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView

        if let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
            let containerView = transitionContext.containerView

            overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
            overlayView.frame = containerView.bounds
            containerView.addSubview(overlayView)

            containerView.addSubview(toView)
            toView.frame = CGRect(x: 0, y: containerView.bounds.size.height, width: containerView.bounds.size.width, height: containerView.bounds.size.height)

            overlayView.alpha = 0
            UIView.animate(withDuration: duration, animations: {
                self.overlayView.alpha = 1.0
                toView.frame = CGRect(x: 0, y: 0, width: containerView.bounds.size.width, height: containerView.bounds.size.height)

            }) { (finished) in
                transitionContext.completeTransition(true)
            }
        } else if let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) {
            UIView.animate(withDuration: duration, animations: {
                self.overlayView.alpha = 0.0
                fromView.frame = CGRect(x: 0, y: containerView.bounds.size.height, width: containerView.bounds.size.width, height: containerView.bounds.size.height)
            }) { (finished) in
                transitionContext.completeTransition(true)
                self.overlayView.removeFromSuperview()
            }
        }
    }
}
