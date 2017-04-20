//
//  Purchase.swift
//  IQ
//
//  Created by Anton Chebotov on 15/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class Purchase: NSObject {

    var progress: CGFloat
    var name: String
    var price: Int = 450
    var icon: UIImage?

    init(name: String, progress: CGFloat) {
        self.name = name
        self.progress = progress
    }

}
