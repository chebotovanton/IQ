//
//  HeaderView.swift
//  IQ
//
//  Created by Anton Chebotov on 19/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    @IBOutlet weak var nameLabel: UILabel?

    func setStyle(black: Bool) {
        if black {
            backgroundColor = Colors.whiteBackgroundColor()
            nameLabel?.textColor = UIColor.black
        } else {
            backgroundColor = UIColor.clear
            nameLabel?.textColor = UIColor.white
        }
    }
}
