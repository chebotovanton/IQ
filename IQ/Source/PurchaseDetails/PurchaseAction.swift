//
//  PurchaseAction.swift
//  IQ
//
//  Created by Anton Chebotov on 21/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class PurchaseAction: NSObject {
    var name: String
    var icon: UIImage

    init(name: String, icon: UIImage) {
        self.name = name
        self.icon = icon
    }
}
