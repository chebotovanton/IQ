//
//  Purchase.swift
//  IQ
//
//  Created by Anton Chebotov on 15/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class Purchase: NSObject {

    var name: String
    var price: Int
    var refund: Int
    var iconUrlString: String
    var progress: CGFloat = 0

    init(name: String, price: Int, refund: Int, iconUrlString: String) {
        self.name = name
        self.price = price
        self.refund = refund
        self.iconUrlString = iconUrlString

        if price > 0 {
            self.progress = CGFloat(refund) / CGFloat(price)
        }
    }

}
