//
//  ProgressView.swift
//  IQ
//
//  Created by Anton Chebotov on 21/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class ProgressView: UIView {

    var progress: CGFloat = 0.0

    let fillView = UIView()
    var stripeViews: [UIView] = []

    override func awakeFromNib() {
        super.awakeFromNib()

        initialize()
    }

    private func initialize() {
        layer.cornerRadius = 6
        clipsToBounds = true

        fillView.backgroundColor = Colors.progressColor()
        addSubview(fillView)
        fillView.frame = CGRect(x: 0, y: 0, width: 0, height: frame.size.height)

        let rectsCount: Int = 3
        let vertStep: CGFloat = frame.height / CGFloat(rectsCount)
        for i in 0..<rectsCount {
            let view = UIView()
            view.backgroundColor = Colors.progressColor()
            stripeViews.append(view)
            view.layer.cornerRadius = 6.0
            addSubview(view)
            view.frame = CGRect(x: 0, y: vertStep * CGFloat(i), width: 0, height: vertStep / 2.0)
        }
    }

    func setup(_ progress: CGFloat, animated: Bool = false) {
        self.progress = progress

        if progress == 1 {
            backgroundColor = Colors.progressColor()
        } else if progress > 0 {
            backgroundColor = UIColor.white
            let width = frame.width * progress
            if !animated {
                fillView.frame = CGRect(x: 0, y: 0, width: width, height: frame.height)
                for view in stripeViews {
                    view.frame = CGRect(x: 0, y: view.frame.origin.y, width: width, height: view.frame.height)
                }
            } else {
                for view in stripeViews {
                    animateStripeView(view, width: width)
                }
                animateFillView(fillView, width: width)
            }
        } else {
            backgroundColor = UIColor.white
        }
    }

    private func animateStripeView(_ view: UIView, width: CGFloat) {
        let delay = CGFloat(arc4random_uniform(5)) / 10.0
        UIView.animate(withDuration: 0.2,
                       delay: TimeInterval(delay),
                       options: .curveEaseInOut,
                       animations: {
                        let randWidth = width - CGFloat(arc4random_uniform(10))
                        view.frame = CGRect(x: 0, y: view.frame.origin.y, width: randWidth, height: view.frame.height)
        }, completion: nil)
    }

    private func animateFillView(_ view: UIView, width: CGFloat) {
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.fillView.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.height)
        }, completion: nil)

    }
}
