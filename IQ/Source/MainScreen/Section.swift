//
//  Section.swift
//  IQ
//
//  Created by Anton Chebotov on 18/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class Section: NSObject {
    var purchases: [Purchase] = []

    init(_ purchases: [Purchase]) {
        self.purchases = purchases
    }
}
