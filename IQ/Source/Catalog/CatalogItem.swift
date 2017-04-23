//
//  CatalogItem.swift
//  IQ
//
//  Created by Anton Chebotov on 22/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class CatalogItem: NSObject {
    let name: String
    let discount: Int
    let iconUrl: String
    let urlString: String

    init(name: String, discount: Int, iconUrl: String, urlString: String) {
        self.name = name
        self.discount = discount
        self.iconUrl = iconUrl
        self.urlString = urlString
    }
}
