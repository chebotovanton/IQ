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
    @IBOutlet private weak var progressView: ProgressView!

    func setup(_ purchase: Purchase) {
        nameLabel.text = purchase.name
        priceLabel.text = priceText(purchase.price, progress: purchase.progress)
        iconView.image = purchase.icon
        progressView.setup(purchase.progress)
    }

    private func priceText(_ price: Int, progress: CGFloat) -> String {
        if progress == 0 || progress == 1  {
            return "$" + String(price)
        } else {
            let currentValue = Int(CGFloat(price) * progress)
            return "$" + String(currentValue) + " / " + "$" + String(price)
        }
    }
}
