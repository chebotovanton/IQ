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
        priceLabel.text = StringUtils.priceText(purchase.price, progress: purchase.progress)
        iconView.image = purchase.icon
        progressView.setup(purchase.progress)
    }
}
