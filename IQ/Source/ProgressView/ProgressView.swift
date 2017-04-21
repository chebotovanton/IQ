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

    private var shapeLayer = CAShapeLayer()

    override func awakeFromNib() {
        super.awakeFromNib()

        initialize()
    }

    private func initialize() {
        layer.addSublayer(shapeLayer)
        layer.cornerRadius = 6
        clipsToBounds = true

        let color = Colors.progressColor()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = color.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.position = CGPoint.zero
    }

    func setup(_ progress: CGFloat) {
        self.progress = progress

        if progress == 1 {
            shapeLayer.path = nil
            backgroundColor = Colors.progressColor()
        } else if progress > 0 {
            backgroundColor = UIColor.white
            let newPath = createBezierPath(progress).cgPath

            //        let myAnimation = CABasicAnimation(keyPath: "path")
            //        myAnimation.fromValue = oldPath
            //        myAnimation.toValue = newPath
            //        myAnimation.duration = 3.4
            //        myAnimation.fillMode = kCAFillModeForwards
            //        myAnimation.isRemovedOnCompletion = false
            //        shapeLayer.add(myAnimation, forKey: "animatePath")
            shapeLayer.path = newPath
        } else {
            backgroundColor = UIColor.white
            shapeLayer.path = nil
        }

    }

    private func createBezierPath(_ progress: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))

        let rectsCount: Int = 5
        let vertStep: CGFloat = frame.height / CGFloat(rectsCount)

        for i in 0...rectsCount {
            let minX = frame.width * progress + CGFloat(arc4random_uniform(10))
            let maxX = frame.width * progress + 20 + CGFloat(arc4random_uniform(30))
            var point = CGPoint(x: minX, y: vertStep * CGFloat(i))
            path.addLine(to: point)
            point.y += vertStep / 2.0
            path.addLine(to: point)
            point.x = maxX
            path.addLine(to: point)
            point.y += vertStep / 2.0
            path.addLine(to: point)
        }
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        path.close()

        return path
    }
}
