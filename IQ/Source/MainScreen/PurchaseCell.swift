//
//  PurchaseCell.swift
//  IQ
//
//  Created by Anton Chebotov on 15/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class PurchaseCell: UICollectionViewCell {

    @IBOutlet private weak var iconView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var progressView: UIView!
    private var shapeLayer = CAShapeLayer()

    override func awakeFromNib() {
        super.awakeFromNib()

        progressView.layer.addSublayer(shapeLayer)
        progressView.layer.cornerRadius = 6
        progressView.clipsToBounds = true

        let color = UIColor(red: 250.0/255.0, green: 241.0/255.0, blue: 93.0/255.0, alpha: 1.0)
        self.shapeLayer.strokeColor = color.cgColor
        self.shapeLayer.fillColor = color.cgColor
        self.shapeLayer.lineWidth = 1.0
        self.shapeLayer.position = CGPoint.zero
    }

    func setup(_ purchase: Purchase) {
        nameLabel.text = purchase.name
        priceLabel.text = priceText(purchase.price, progress: purchase.progress)
        iconView.image = purchase.icon

        if purchase.progress > 0 {
    //        let oldPath = shapeLayer.path
            let newPath = createBezierPath(purchase).cgPath

    //        let myAnimation = CABasicAnimation(keyPath: "path")
    //        myAnimation.fromValue = oldPath
    //        myAnimation.toValue = newPath
    //        myAnimation.duration = 3.4
    //        myAnimation.fillMode = kCAFillModeForwards
    //        myAnimation.isRemovedOnCompletion = false
    //        shapeLayer.add(myAnimation, forKey: "animatePath")
            shapeLayer.path = newPath
        } else {
            shapeLayer.path = nil
        }
    }

    private func priceText(_ price: Int, progress: CGFloat) -> String {
        if progress == 0 || progress == 1  {
            return "$" + String(price)
        } else {
            let currentValue = Int(CGFloat(price) * progress)
            return "$" + String(currentValue) + " / " + "$" + String(price)
        }
    }

    private func createBezierPath(_ purchase: Purchase) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))

        let rectsCount: Int = 5
        let vertStep: CGFloat = frame.height / CGFloat(rectsCount)

        for i in 0...rectsCount {
            let minX = frame.width * purchase.progress + CGFloat(arc4random_uniform(10))
            let maxX = frame.width * purchase.progress + 20 + CGFloat(arc4random_uniform(30))
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
