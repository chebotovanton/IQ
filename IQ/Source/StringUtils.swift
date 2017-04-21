//
//  StringUtils.swift
//  IQ
//
//  Created by Anton Chebotov on 21/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class StringUtils: NSObject {

    static func priceText(_ price: Int, progress: CGFloat) -> String {
        if progress == 0 || progress == 1  {
            return "$" + String(price)
        } else {
            let currentValue = Int(CGFloat(price) * progress)
            return "$" + String(currentValue) + " / " + "$" + String(price)
        }
    }

}
