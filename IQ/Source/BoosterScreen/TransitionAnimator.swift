//
//  DetailsAnimator.swift
//  IQ
//
//  Created by Anton Chebotov on 22/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    private let overlayView = UIView()

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        let toVC = transitionContext.viewController(forKey: .to)
        let fromVC = transitionContext.viewController(forKey: .from)
        guard let toView = toVC?.view else { return }
        guard let fromView = fromVC?.view else { return }

        if toVC is BoosterVC || toVC is PurchaseDetailsVC {
            overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
            overlayView.frame = containerView.bounds
            containerView.addSubview(overlayView)

            containerView.addSubview(toView)
            toView.frame = CGRect(x: 0, y: containerView.bounds.size.height, width: containerView.bounds.size.width, height: containerView.bounds.size.height)

            overlayView.alpha = 0
            UIView.animate(withDuration: duration, animations: {
                fromView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.overlayView.alpha = 1.0
                toView.frame = CGRect(x: 0, y: 0, width: containerView.bounds.size.width, height: containerView.bounds.size.height)

            }) { (finished) in
                transitionContext.completeTransition(true)
            }
        } else {
            UIView.animate(withDuration: duration, animations: {
                self.overlayView.alpha = 0.0
                toView.transform = CGAffineTransform(scaleX: 1, y: 1)
                fromView.frame = CGRect(x: 0, y: containerView.bounds.size.height, width: containerView.bounds.size.width, height: containerView.bounds.size.height)
            }) { (finished) in
                fromView.removeFromSuperview()
                self.overlayView.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        }
    }
}
