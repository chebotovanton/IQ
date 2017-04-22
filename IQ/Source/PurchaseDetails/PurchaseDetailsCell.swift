//
//  PurchaseDetailsCell.swift
//  IQ
//
//  Created by Anton Chebotov on 23/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class PurchaseDetailsCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var icon: UIImageView!

    func setup(_ action: PurchaseAction) {
        nameLabel.text = action.name
        icon.image = action.icon
    }
}
