//
//  Section.swift
//  IQ
//
//  Created by Anton Chebotov on 18/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

enum LayoutStyle: Int {
    case done = 0
    case progress
    case queue
}

import UIKit

class Section: NSObject {
    var name: String
    var purchases: [Purchase]
    var layoutStyle: LayoutStyle

    init(_ purchases: [Purchase], name: String, layoutStyle: LayoutStyle) {
        self.purchases = purchases
        self.name = name
        self.layoutStyle = layoutStyle
    }
}
