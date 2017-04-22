//
//  CatalogCell.swift
//  IQ
//
//  Created by Anton Chebotov on 22/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class CatalogCell: UICollectionViewCell {

    var catalogItem: CatalogItem?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    func setup(_ catalogItem: CatalogItem) {
        nameLabel.text = catalogItem.name
        priceLabel.text = catalogItem.price
        imageView.image = catalogItem.icon
    }
}
