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

    func setup(_ purchase: Purchase, animated: Bool = false) {
        nameLabel.text = purchase.name
        priceLabel.text = StringUtils.priceText(purchase.price, progress: purchase.progress)
        let url = URL(string: purchase.iconUrlString)
        iconView.sd_setImage(with: url)
        progressView.setup(purchase.progress, animated: animated)
    }
}
