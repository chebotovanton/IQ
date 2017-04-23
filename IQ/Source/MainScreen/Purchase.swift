//
//  Purchase.swift
//  IQ
//
//  Created by Anton Chebotov on 15/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class Purchase: NSObject {

    var purchaseId: Int
    var name: String
    var price: Int
    var refund: Int
    var iconUrlString: String
    var progress: CGFloat = 0
    var status: String

    init(purchaseId: Int, name: String, price: Int, refund: Int, iconUrlString: String, status: String) {
        self.purchaseId = purchaseId
        self.name = name
        self.price = price
        self.refund = refund
        self.iconUrlString = iconUrlString
        self.status = status

        if price > 0 {
            self.progress = CGFloat(refund) / CGFloat(price)
        }
    }

}
